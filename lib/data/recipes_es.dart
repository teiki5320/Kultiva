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
/// Les sept lots sont là : 123 légumes, 736 recettes. Le découpage se
/// retrouve avec `dart run tool/exporter_recettes.dart --lots`, et un
/// squelette se régénère avec `--squelette --langue=es --lot=N`.
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

  // ─────────── carotte (6 recettes) ───────────
  'carotte/Rondelles de carottes blanchies congelées': RecipeText(
    // FR: Rondelles de carottes blanchies congelées
    name: 'Rodajas de zanahoria escaldadas y congeladas',
    // FR: Trois minutes d'eau bouillante, et tes carottes gardent leur couleur et leur goût sucré jusqu'au printemps.
    description: 'Tres minutos de agua hirviendo y tus zanahorias conservan su color y su sabor dulce hasta la primavera.',
    // FR: 12 mois au congélateur
    keeps: '12 meses en el congelador',
    ingredients: <String>[
      '2 kg de zanahorias', // FR: 2 kg de carottes
      'sal gruesa', // FR: gros sel
      'un bol grande de agua con hielo', // FR: un grand saladier d'eau glacée
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Brosse les carottes sous l'eau ; épluche seulement les grosses.
      'Cepilla las zanahorias bajo el agua; pela solo las grandes.',
      // FR: Coupe-les en rondelles d'un demi-centimètre, toutes de la même épaisseur pour qu'elles blanchissent pareil.
      'Córtalas en rodajas de medio centímetro, todas del mismo grosor para que se escalden por igual.',
      // FR: Plonge-les par fournées dans l'eau bouillante salée et compte **3 minutes** à la reprise de l'ébullition.
      'Échalas por tandas en agua hirviendo con sal y cuenta **3 minutos** desde que vuelva a hervir.',
      // FR: Transfère-les aussitôt dans l'eau glacée, autant de temps qu'elles ont cuit.
      'Pásalas enseguida al agua con hielo, el mismo tiempo que han cocido.',
      // FR: Égoutte et sèche-les sur un torchon : chaque goutte qui reste devient du givre.
      'Escúrrelas y sécalas con un paño: cada gota que quede se convierte en escarcha.',
      // FR: Étale-les sur une plaque, congèle 2 heures, puis verse-les en sac : tu en prendras une poignée à la fois.
      'Extiéndelas sobre una bandeja, congela 2 horas y luego échalas en una bolsa: así sacarás un puñado cada vez.',
    ],
  ),
  'carotte/Carottes lacto-fermentées au gingembre': RecipeText(
    // FR: Carottes lacto-fermentées au gingembre
    name: 'Zanahorias lactofermentadas con jengibre',
    // FR: Des bâtonnets croquants et acidulés qui se gardent des mois, sans cuisson ni vinaigre : juste du sel et de la patience.
    description: 'Palitos crujientes y ácidos que se conservan meses, sin cocción ni vinagre: solo sal y paciencia.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 meses en la nevera',
    ingredients: <String>[
      '1 kg de zanahorias', // FR: 1 kg de carottes
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '1 trozo de jengibre de 4 cm', // FR: 1 morceau de gingembre de 4 cm
      '2 dientes de ajo', // FR: 2 gousses d'ail
    ],
    steps: <String>[
      // FR: Dissous **30 g de sel dans 1 litre d'eau** : c'est la saumure à 3 %. Eau du robinet laissée une nuit à l'air, ou eau de source.
      'Disuelve **30 g de sal en 1 litro de agua**: es la salmuera al 3 %. Agua del grifo dejada una noche al aire, o agua de manantial.',
      // FR: Épluche les carottes et coupe-les en bâtonnets un peu plus courts que la hauteur du bocal.
      'Pela las zanahorias y córtalas en palitos un poco más cortos que la altura del tarro.',
      // FR: Range-les debout bien serrés dans un bocal propre, avec le gingembre et l'ail en lamelles.
      'Colócalas de pie, bien apretadas, en un tarro limpio, con el jengibre y el ajo en láminas.',
      // FR: Verse la saumure jusqu'à **couvrir de 2 cm**, en laissant 3 cm de vide sous le couvercle.
      'Vierte la salmuera hasta **cubrirlas 2 cm**, dejando 3 cm de vacío bajo la tapa.',
      // FR: Pose un poids pour que rien ne dépasse, ferme sans serrer et laisse 10 à 15 jours vers 20 °C, à l'abri de la lumière.
      'Pon un peso para que nada sobresalga, cierra sin apretar y deja de 10 a 15 días a unos 20 °C, protegido de la luz.',
      // FR: Quand la saumure est trouble et que ça sent l'aigrelet, serre le couvercle et range au réfrigérateur.
      'Cuando la salmuera esté turbia y huela a ácido, aprieta la tapa y guárdalo en la nevera.',
    ],
  ),
  'carotte/Pickles de carottes au cumin': RecipeText(
    // FR: Pickles de carottes au cumin
    name: 'Encurtidos de zanahoria al comino',
    // FR: Le vinaigre chaud, le cumin et une pointe de sucre : les carottes deviennent un apéritif qu'on ressort toute l'année.
    description: 'Vinagre caliente, comino y una pizca de azúcar: las zanahorias se convierten en un aperitivo que sacarás todo el año.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '1 kg de zanahorias', // FR: 1 kg de carottes
      '50 cl de vinagre de sidra al 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '50 cl de agua', // FR: 50 cl d'eau
      '60 g de azúcar', // FR: 60 g de sucre
      '15 g de sal', // FR: 15 g de sel
      '2 cucharaditas de semillas de comino', // FR: 2 cuillères à café de graines de cumin
    ],
    steps: <String>[
      // FR: Épluche les carottes et coupe-les en bâtonnets ou en rondelles biseautées.
      'Pela las zanahorias y córtalas en palitos o en rodajas al bies.',
      // FR: Blanchis-les **3 minutes** à l'eau bouillante : elles s'imprègnent mieux et restent croquantes.
      'Escáldalas **3 minutos** en agua hirviendo: se impregnan mejor y se quedan crujientes.',
      // FR: Rafraîchis-les sous l'eau froide et égoutte-les.
      'Refréscalas bajo agua fría y escúrrelas.',
      // FR: Fais griller le cumin à sec 1 minute, puis ajoute vinaigre, eau, sucre et sel, et porte à ébullition.
      'Tuesta el comino en seco 1 minuto, luego añade el vinagre, el agua, el azúcar y la sal, y lleva a ebullición.',
      // FR: Tasse les carottes dans des bocaux propres jusqu'à 2 cm du bord.
      'Apelmaza las zanahorias en tarros limpios hasta 2 cm del borde.',
      // FR: Verse le vinaigre bouillant pour **les couvrir entièrement**, ferme, laisse refroidir et range au réfrigérateur. Prêtes en 3 jours.
      'Vierte el vinagre hirviendo para **cubrirlas por completo**, cierra, deja enfriar y guarda en la nevera. Listas en 3 días.',
    ],
  ),
  'carotte/Carottes râpées au citron': RecipeText(
    // FR: Carottes râpées au citron
    name: 'Zanahoria rallada con limón',
    // FR: Deux minutes de râpe, un citron, et la plus franche des entrées.
    description: 'Dos minutos de rallador, un limón y el entrante más sincero.',
    ingredients: <String>[
      '6 zanahorias', // FR: 6 carottes
      '1 limón', // FR: 1 citron
      '3 cucharadas de aceite', // FR: 3 cuillères à soupe d'huile
      '1 cucharadita de miel', // FR: 1 cuillère à café de miel
      'sal, perejil', // FR: sel, persil
    ],
    steps: <String>[
      // FR: Râpe les carottes gros : trop fin, elles rendent leur eau.
      'Ralla las zanahorias gruesas: si el rallado es muy fino, sueltan su agua.',
      // FR: Presse le citron, mélange huile, miel et sel.
      'Exprime el limón y mezcla el aceite, la miel y la sal.',
      // FR: Verse, mélange, laisse reposer 10 minutes.
      'Vierte, mezcla y deja reposar 10 minutos.',
      // FR: Persil ciselé au dernier moment.
      'Perejil picado en el último momento.',
    ],
  ),
  'carotte/Carottes Vichy': RecipeText(
    // FR: Carottes Vichy
    name: 'Zanahorias Vichy',
    // FR: Cuites dans leur eau avec beurre et sucre, elles se glacent toutes seules.
    description: 'Cocidas en su propia agua con mantequilla y azúcar, se glasean solas.',
    ingredients: <String>[
      '800 g de zanahorias', // FR: 800 g de carottes
      '30 g de mantequilla', // FR: 30 g de beurre
      '1 cucharadita de azúcar', // FR: 1 cuillère à café de sucre
      'sal, perejil', // FR: sel, persil
    ],
    steps: <String>[
      // FR: Coupe les carottes en rondelles épaisses.
      'Corta las zanahorias en rodajas gruesas.',
      // FR: Mets-les dans une casserole large avec beurre, sucre, sel, et de l'eau à mi-hauteur seulement.
      'Ponlas en una cazuela ancha con la mantequilla, el azúcar, la sal y agua solo hasta la mitad de la altura.',
      // FR: Cuis à découvert 20 minutes : l'eau doit s'évaporer et laisser un sirop.
      'Cuece sin tapar 20 minutos: el agua debe evaporarse y dejar un almíbar.',
      // FR: Remue en fin de cuisson pour les enrober de ce glaçage.
      'Remueve al final de la cocción para bañarlas con ese glaseado.',
      // FR: Persil, et à table.
      'Perejil, y a la mesa.',
    ],
  ),
  'carotte/Soupe de carottes au cumin': RecipeText(
    // FR: Soupe de carottes au cumin
    name: 'Sopa de zanahoria al comino',
    // FR: Le cumin réveille le sucré de la carotte — une soupe qui ne lasse pas.
    description: 'El comino despierta el dulzor de la zanahoria: una sopa que no cansa.',
    ingredients: <String>[
      '1 kg de zanahorias', // FR: 1 kg de carottes
      '1 patata', // FR: 1 pomme de terre
      '1 cebolla', // FR: 1 oignon
      '1 cucharadita de comino', // FR: 1 cuillère à café de cumin
      '1 litro de caldo, sal, pimienta', // FR: 1 litre de bouillon, sel, poivre
    ],
    steps: <String>[
      // FR: Fais fondre l'oignon émincé dans un peu d'huile.
      'Pocha la cebolla en láminas finas con un poco de aceite.',
      // FR: Ajoute le cumin et laisse-le chauffer 30 secondes : il doit sentir avant de mouiller.
      'Añade el comino y déjalo calentar 30 segundos: debe oler antes de mojar.',
      // FR: Ajoute carottes et pomme de terre en morceaux, puis le bouillon.
      'Añade las zanahorias y la patata en trozos, y luego el caldo.',
      // FR: Cuis 25 minutes, couvercle posé.
      'Cuece 25 minutos, con la tapa puesta.',
      // FR: Mixe. Trop épaisse ? un peu de bouillon. Trop claire ? laisse réduire.
      'Tritura. ¿Muy espesa? Un poco de caldo. ¿Muy clara? Déjala reducir.',
    ],
  ),

  // ─────────── cassissier (6 recettes) ───────────
  'cassissier/Grains de cassis congelés': RecipeText(
    // FR: Grains de cassis congelés
    name: 'Granos de grosella negra congelados',
    // FR: Le cassis supporte le congélateur mieux que personne : il en ressort aussi parfumé qu'à la cueillette.
    description: 'La grosella negra soporta el congelador mejor que nadie: sale tan perfumada como el día de la cosecha.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '1 kg de grosellas negras', // FR: 1 kg de cassis
      'un tenedor', // FR: une fourchette
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Égrappe le cassis en passant les dents d'une fourchette le long des grappes.
      'Desgrana las grosellas pasando los dientes de un tenedor a lo largo de los racimos.',
      // FR: Rince rapidement s'il le faut, puis sèche les grains sur un torchon.
      'Enjuaga rápidamente si hace falta y seca los granos con un paño.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent et congèle 2 heures.
      'Extiéndelos sobre una bandeja sin que se toquen y congela 2 horas.',
      // FR: Verse-les en sac une fois durs. Ils vont directement dans un gâteau, un sorbet ou une compote.
      'Pásalos a una bolsa cuando estén duros. Van directamente a un bizcocho, un sorbete o una compota.',
    ],
  ),
  'cassissier/Gelée de cassis': RecipeText(
    // FR: Gelée de cassis
    name: 'Jalea de grosella negra',
    // FR: Le cassis est si riche en pectine que sa gelée prend en quelques minutes, dense et brillante.
    description: 'La grosella negra es tan rica en pectina que su jalea cuaja en pocos minutos, densa y brillante.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierta en la nevera',
    ingredients: <String>[
      '1,5 kg de grosellas negras desgranadas', // FR: 1,5 kg de cassis égrappé
      '30 cl de agua', // FR: 30 cl d'eau
      '1 kg de azúcar por litro de zumo', // FR: 1 kg de sucre par litre de jus
      '6 tarros de mermelada', // FR: 6 pots de confiture
    ],
    steps: <String>[
      // FR: Cuis le cassis avec l'eau à couvert, en écrasant, jusqu'à ce que tous les grains éclatent.
      'Cuece las grosellas con el agua, tapadas y aplastándolas, hasta que todos los granos revienten.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse égoutter, puis presse doucement.
      'Vierte sobre un paño limpio colocado en un colador y deja escurrir; luego presiona suavemente.',
      // FR: Mesure le jus, ajoute **1 kg de sucre par litre** et porte à ébullition en remuant.
      'Mide el zumo, añade **1 kg de azúcar por litro** y lleva a ebullición removiendo.',
      // FR: Cuis à gros bouillons en écumant : pas plus, sinon la gelée devient caoutchouteuse.
      'Cuece a borbotones espumando: no más, o la jalea se vuelve gomosa.',
      // FR: Teste sur une assiette froide : une goutte qui se fige et se ride au doigt est prête.
      'Prueba en un plato frío: una gota que se cuaja y se arruga al tocarla con el dedo está lista.',
      // FR: Mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Envasa en tarros escaldados, cierra y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'cassissier/Feuilles de cassis séchées pour infusion': RecipeText(
    // FR: Feuilles de cassis séchées pour infusion
    name: 'Hojas de grosella negra secas para infusión',
    // FR: On oublie souvent les feuilles : séchées, elles donnent une infusion au parfum de cassis tout l'hiver.
    description: 'Las hojas se olvidan a menudo: secas, dan una infusión con aroma a grosella negra todo el invierno.',
    // FR: 1 an en bocal, à l'abri de la lumière
    keeps: '1 año en un tarro, protegidas de la luz',
    ingredients: <String>[
      '2 buenos puñados de hojas jóvenes de grosella negra', // FR: 2 grosses poignées de jeunes feuilles de cassis
      'un paño o una rejilla', // FR: un torchon ou une claie
      'un tarro opaco', // FR: un bocal opaque
    ],
    steps: <String>[
      // FR: Cueille de jeunes feuilles saines en fin de matinée, quand la rosée est partie. Prends-en un peu sur chaque branche.
      'Coge hojas jóvenes y sanas a última hora de la mañana, cuando se haya ido el rocío. Toma unas pocas de cada rama.',
      // FR: Ne les lave que si elles sont sales, et sèche-les bien sur un torchon.
      'Lávalas solo si están sucias, y sécalas bien con un paño.',
      // FR: Étale-les en une couche sur une claie, **à l'ombre**, dans une pièce sèche et aérée, pendant une semaine.
      'Extiéndelas en una sola capa sobre una rejilla, **a la sombra**, en una habitación seca y ventilada, durante una semana.',
      // FR: Teste : une feuille sèche craque entre tes doigts. Si elle plie encore, attends deux jours de plus.
      'Compruébalo: una hoja seca cruje entre los dedos. Si aún se dobla, espera dos días más.',
      // FR: Émiette-les grossièrement et range-les en bocal opaque. Une cuillère à soupe pour une tasse d'eau frémissante.
      'Desmenúzalas toscamente y guárdalas en un tarro opaco. Una cucharada por taza de agua a punto de hervir.',
    ],
  ),
  'cassissier/Crème de cassis': RecipeText(
    // FR: Crème de cassis
    name: 'Crema de casis',
    // FR: Baies macérées dans l'alcool, puis sucrées. Patience de deux mois.
    description: 'Bayas maceradas en alcohol y luego endulzadas. Dos meses de paciencia.',
  ),
  'cassissier/Confiture de cassis': RecipeText(
    // FR: Confiture de cassis
    name: 'Mermelada de grosella negra',
    // FR: Intense, presque amère, parfaite sur du pain grillé.
    description: 'Intensa, casi amarga, perfecta sobre pan tostado.',
  ),
  'cassissier/Sorbet au cassis': RecipeText(
    // FR: Sorbet au cassis
    name: 'Sorbete de grosella negra',
    // FR: Mixé cru, passé au tamis, sucré au sirop.
    description: 'Triturado en crudo, pasado por el tamiz y endulzado con almíbar.',
  ),

  // ─────────── celeri (6 recettes) ───────────
  'celeri/Mirepoix céleri-carotte-oignon': RecipeText(
    // FR: Mirepoix céleri-carotte-oignon
    name: 'Mirepoix de apio, zanahoria y cebolla',
    // FR: Le trio de base de toutes les sauces, coupé une fois pour toutes et prêt à jeter dans la cocotte.
    description: 'El trío base de todas las salsas, cortado de una vez por todas y listo para echar a la cazuela.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 cabeza de apio', // FR: 1 pied de céleri-branche
      '4 zanahorias', // FR: 4 carottes
      '3 cebollas', // FR: 3 oignons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les branches de céleri à fond, la terre se loge dans le creux du bas. Garde les feuilles pour le sel de céleri.
      'Lava a fondo las ramas de apio: la tierra se mete en el hueco de abajo. Guarda las hojas para la sal de apio.',
      // FR: Retire les fils des grosses branches avec un économe, puis coupe en petits dés de 5 mm.
      'Quita los hilos de las ramas grandes con un pelador y corta en dados pequeños de 5 mm.',
      // FR: Épluche carottes et oignons et taille-les à la même taille, pour qu'ils cuisent ensemble.
      'Pela las zanahorias y las cebollas y córtalas del mismo tamaño, para que se cuezan juntas.',
      // FR: Mélange les trois légumes dans un saladier.
      'Mezcla las tres verduras en un bol.',
      // FR: Répartis en sachets d'une portion, à plat, et congèle. Ils vont **gelés** dans la cocotte, sans décongeler.
      'Reparte en bolsitas de una ración, en plano, y congela. Van **congeladas** a la cazuela, sin descongelar.',
    ],
  ),
  'celeri/Sel de céleri maison': RecipeText(
    // FR: Sel de céleri maison
    name: 'Sal de apio casera',
    // FR: Les feuilles qu'on jette, séchées et mixées au sel : un assaisonnement pour les tomates, les œufs et les soupes.
    description: 'Las hojas que se tiran, secas y trituradas con la sal: un aliño para los tomates, los huevos y las sopas.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegida de la luz',
    ingredients: <String>[
      'las hojas de 2 cabezas de apio', // FR: les feuilles de 2 pieds de céleri
      '150 g de sal gruesa o flor de sal', // FR: 150 g de gros sel ou de fleur de sel
      'un tarro de cristal pequeño bien seco', // FR: un petit pot en verre bien sec
    ],
    steps: <String>[
      // FR: Rince les feuilles et sèche-les bien en les roulant dans un torchon.
      'Aclara las hojas y sécalas bien enrollándolas en un paño.',
      // FR: Étale-les sur une plaque et fais-les sécher au four à **60 °C**, porte entrouverte.
      'Extiéndelas sobre una bandeja y sécalas en el horno a **60 °C**, con la puerta entreabierta.',
      // FR: Elles sont prêtes quand elles s'émiettent sous les doigts. Encore souples, laisse-les un peu plus.
      'Están listas cuando se desmenuzan entre los dedos. Si aún están blandas, déjalas un poco más.',
      // FR: Mixe les feuilles refroidies avec le sel, par à-coups, jusqu'à une poudre verte.
      'Tritura las hojas frías con la sal, a golpes, hasta obtener un polvo verde.',
      // FR: Mets en pot bien fermé. Le sel garde le vert et le parfum : pas besoin d'autre chose.
      'Pásala a un tarro bien cerrado. La sal conserva el verde y el aroma: no hace falta nada más.',
    ],
  ),
  'celeri/Céleri-rave râpé fermenté': RecipeText(
    // FR: Céleri-rave râpé fermenté
    name: 'Apio nabo rallado fermentado',
    // FR: Râpé et salé comme une choucroute, il devient acidulé et croquant, parfait en crudité d'hiver.
    description: 'Rallado y salado como un chucrut, se vuelve ácido y crujiente, perfecto como crudité de invierno.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 meses en la nevera',
    ingredients: <String>[
      '1,5 kg de apio nabo', // FR: 1,5 kg de céleri-rave
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '1 manzana ácida', // FR: 1 pomme acide
      '1 cucharadita de semillas de mostaza', // FR: 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Épluche le céleri au couteau, assez épais pour enlever toute la peau terreuse, et râpe-le avec la pomme.
      'Pela el apio con cuchillo, con grosor suficiente para quitar toda la piel terrosa, y rállalo con la manzana.',
      // FR: Pèse la râpée et ajoute **20 g de sel par kilo**, avec la moutarde. Malaxe 5 minutes avec les mains.
      'Pesa lo rallado y añade **20 g de sal por kilo**, con la mostaza. Amasa 5 minutos con las manos.',
      // FR: Laisse reposer, le temps que le sel fasse sortir le jus.
      'Deja reposar mientras la sal hace salir el jugo.',
      // FR: Tasse fort dans un bocal, jusqu'à ce que le jus remonte et couvre tout, en laissant 3 cm sous le bord.
      'Apelmaza con fuerza en un tarro, hasta que el jugo suba y lo cubra todo, dejando 3 cm bajo el borde.',
      // FR: Pose un poids pour garder tout **sous le jus**. S'il en manque, complète avec une saumure à 30 g de sel par litre.
      'Pon un peso para mantener todo **bajo el jugo**. Si falta, completa con una salmuera de 30 g de sal por litro.',
      // FR: Laisse fermenter 2 semaines à 18–22 °C, couvercle posé sans serrer, puis range au réfrigérateur.
      'Deja fermentar 2 semanas a 18–22 °C, con la tapa puesta sin apretar, y luego guárdalo en la nevera.',
    ],
  ),
  'celeri/Céleri rémoulade': RecipeText(
    // FR: Céleri rémoulade
    name: 'Apio nabo en remoulade',
    // FR: Râpé cru dans une mayonnaise moutardée — le classique des charcutiers.
    description: 'Rallado en crudo con una mayonesa de mostaza: el clásico de los charcuteros.',
    ingredients: <String>[
      '1 apio nabo', // FR: 1 céleri-rave
      '1 yema de huevo', // FR: 1 jaune d'oeuf
      '1 cucharada de mostaza', // FR: 1 cuillère à soupe de moutarde
      '15 cl de aceite', // FR: 15 cl d'huile
      '1 limón, sal, pimienta, perejil', // FR: 1 citron, sel, poivre, persil
    ],
    steps: <String>[
      // FR: Pèle le céleri et râpe-le en julienne, pas trop fin.
      'Pela el apio y rállalo en juliana, no demasiado fino.',
      // FR: Citronne-le aussitôt : il noircit en quelques minutes à l'air.
      'Échale limón enseguida: se ennegrece en pocos minutos al aire.',
      // FR: Monte une mayonnaise moutardée : jaune, moutarde, sel, puis l'huile en filet.
      'Monta una mayonesa de mostaza: yema, mostaza, sal y luego el aceite en hilo.',
      // FR: Mélange, poivre, persil.
      'Mezcla, pimienta, perejil.',
      // FR: Une heure au frais : le céleri s'attendrit un peu.
      'Una hora en frío: el apio se ablanda un poco.',
    ],
  ),
  'celeri/Purée de céleri-rave': RecipeText(
    // FR: Purée de céleri-rave
    name: 'Puré de apio nabo',
    // FR: Plus fine qu'une purée de pommes de terre, et moins lourde.
    description: 'Más fino que un puré de patatas, y menos pesado.',
    ingredients: <String>[
      '1 apio nabo (800 g)', // FR: 1 céleri-rave (800 g)
      '2 patatas', // FR: 2 pommes de terre
      '20 cl de leche', // FR: 20 cl de lait
      '40 g de mantequilla', // FR: 40 g de beurre
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Coupe céleri et pommes de terre en cubes égaux.
      'Corta el apio y las patatas en cubos iguales.',
      // FR: Cuis-les dans du lait coupé d'eau, 25 minutes : le céleri y perd son amertume.
      'Cuécelos en leche rebajada con agua, 25 minutos: así el apio pierde su amargor.',
      // FR: Égoutte en gardant un peu du liquide.
      'Escurre guardando un poco del líquido.',
      // FR: Écrase avec le beurre, détends au liquide réservé.
      'Machaca con la mantequilla y aligera con el líquido reservado.',
      // FR: Sel, poivre. Très bon avec du gibier.
      'Sal, pimienta. Muy bueno con carne de caza.',
    ],
  ),
  'celeri/Velouté de céleri aux noisettes': RecipeText(
    // FR: Velouté de céleri aux noisettes
    name: 'Crema de apio nabo con avellanas',
    // FR: La noisette torréfiée épouse le céleri comme personne.
    description: 'La avellana tostada se funde con el apio como ninguna otra.',
    ingredients: <String>[
      '1 apio nabo', // FR: 1 céleri-rave
      '1 patata, 1 cebolla', // FR: 1 pomme de terre, 1 oignon
      '80 cl de caldo', // FR: 80 cl de bouillon
      '60 g de avellanas', // FR: 60 g de noisettes
      '10 cl de nata, sal, pimienta', // FR: 10 cl de crème, sel, poivre
    ],
    steps: <String>[
      // FR: Torréfie les noisettes 8 minutes au four à 170 °C, puis frotte-les pour ôter la peau.
      'Tuesta las avellanas 8 minutos en el horno a 170 °C y frótalas para quitarles la piel.',
      // FR: Fais fondre l'oignon, ajoute céleri et pomme de terre.
      'Pocha la cebolla y añade el apio y la patata.',
      // FR: Bouillon à hauteur, cuis 25 minutes.
      'Cubre con el caldo y cuece 25 minutos.',
      // FR: Mixe avec la moitié des noisettes et la crème.
      'Tritura con la mitad de las avellanas y la nata.',
      // FR: Reste de noisettes concassées sur le velouté, pour le croquant.
      'El resto de las avellanas, troceadas, sobre la crema, para dar crujiente.',
    ],
  ),

  // ─────────── celosie (6 recettes) ───────────
  'celosie/Célosie blanchie en boulettes': RecipeText(
    // FR: Célosie blanchie en boulettes
    name: 'Celosía escaldada en bolitas',
    // FR: Blanchie une minute et pressée en boulettes : une portion de feuilles prête pour chaque sauce.
    description: 'Escaldada un minuto y prensada en bolitas: una ración de hojas lista para cada salsa.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 kg de hojas de celosía', // FR: 1 kg de feuilles de célosie
      'sal gruesa', // FR: gros sel
      '1 bol grande de agua con cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Effeuille les tiges et coupe les grosses feuilles en lanières.
      'Deshoja los tallos y corta las hojas grandes en tiras.',
      // FR: Lave dans plusieurs eaux : la terre se cache à la base des feuilles.
      'Lava en varias aguas: la tierra se esconde en la base de las hojas.',
      // FR: Plonge dans une grande eau bouillante salée, à gros bouillons.
      'Sumerge en abundante agua hirviendo con sal, a borbotones.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée pour fixer le vert.
      'Escurre y sumerge enseguida en agua con hielo para fijar el verde.',
      // FR: Presse fort entre tes mains pour chasser l'eau.
      'Prensa con fuerza entre las manos para sacar el agua.',
      // FR: Forme des boulettes, congèle 2 heures sur une plaque, puis mets en sac.
      'Forma bolitas, congela 2 horas sobre una bandeja y luego pásalas a una bolsa.',
    ],
  ),
  'celosie/Célosie fondue à l\'oignon': RecipeText(
    // FR: Célosie fondue à l'oignon
    name: 'Celosía pochada con cebolla',
    // FR: Déjà fondue avec l'oignon, elle n'attend plus que la tomate ou le poisson : une base de sauce toute prête.
    description: 'Ya pochada con la cebolla, solo espera al tomate o al pescado: una base de salsa lista.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 kg de hojas de celosía', // FR: 1 kg de feuilles de célosie
      '2 cebollas', // FR: 2 oignons
      '3 cucharadas de aceite', // FR: 3 cuillères à soupe d'huile
      'sal', // FR: sel
      'recipientes de congelación', // FR: des boîtes de congélation
    ],
    steps: <String>[
      // FR: Effeuille et lave la célosie, puis hache-la grossièrement.
      'Deshoja y lava la celosía, luego pícala toscamente.',
      // FR: Émince les oignons finement.
      'Corta las cebollas en láminas finas.',
      // FR: Fais revenir les oignons dans l'huile jusqu'à ce qu'ils soient tendres et dorés.
      'Sofríe las cebollas en el aceite hasta que estén tiernas y doradas.',
      // FR: Ajoute la célosie par poignées et remue jusqu'à ce qu'elle ait fondu et rendu son eau.
      'Añade la celosía a puñados y remueve hasta que se haya reducido y soltado su agua.',
      // FR: Sale légèrement : tu ajusteras dans la sauce finale.
      'Sala ligeramente: ya ajustarás en la salsa final.',
      // FR: Refroidis vite, casserole dans l'eau froide, puis répartis en boîtes en laissant 2 cm de vide et congèle.
      'Enfría rápido, con la cazuela en agua fría, luego reparte en recipientes dejando 2 cm de vacío y congela.',
    ],
  ),
  'celosie/Feuilles de célosie séchées': RecipeText(
    // FR: Feuilles de célosie séchées
    name: 'Hojas de celosía secas',
    // FR: Séchées à l'ombre, les feuilles s'émiettent dans les soupes et les sauces quand le jardin est vide.
    description: 'Secas a la sombra, las hojas se desmenuzan en sopas y salsas cuando el huerto está vacío.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegidas de la luz',
    ingredients: <String>[
      'hojas de celosía bien sanas', // FR: des feuilles de célosie bien saines
      'rejillas o una sábana limpia', // FR: des claies ou un drap propre
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Effeuille les tiges et écarte les feuilles abîmées ou piquées.
      'Deshoja los tallos y aparta las hojas estropeadas o picadas.',
      // FR: Rince et égoutte bien sur un torchon.
      'Aclara y escurre bien sobre un paño.',
      // FR: Étale en une couche à l'ombre, dans un endroit aéré, 2 à 3 jours en retournant chaque jour.
      'Extiende en una sola capa a la sombra, en un lugar ventilado, 2 o 3 días, dándoles la vuelta cada día.',
      // FR: Elles sont prêtes quand elles craquent sous les doigts.
      'Están listas cuando crujen entre los dedos.',
      // FR: Mets-les en bocaux hermétiques. Émiette-les dans la sauce 10 minutes avant la fin de la cuisson.
      'Guárdalas en tarros herméticos. Desmenúzalas en la salsa 10 minutos antes del final de la cocción.',
    ],
  ),
  'celosie/Célosie sautée à la tomate': RecipeText(
    // FR: Célosie sautée à la tomate
    name: 'Celosía salteada con tomate',
    // FR: Les jeunes feuilles tombent en quelques minutes.
    description: 'Las hojas jóvenes se ablandan en pocos minutos.',
  ),
  'celosie/Soupe de célosie': RecipeText(
    // FR: Soupe de célosie
    name: 'Sopa de celosía',
    // FR: Avec de l'oignon et du piment, nourrissante et verte.
    description: 'Con cebolla y guindilla, nutritiva y verde.',
  ),
  'celosie/Sauce feuilles de célosie': RecipeText(
    // FR: Sauce feuilles de célosie
    name: 'Salsa de hojas de celosía',
    // FR: Les feuilles tendres de célosie mijotées avec tomate et poisson fumé.
    description: 'Las hojas tiernas de celosía cocidas a fuego lento con tomate y pescado ahumado.',
  ),

  // ─────────── cerfeuil (6 recettes) ───────────
  'cerfeuil/Cerfeuil ciselé congelé': RecipeText(
    // FR: Cerfeuil ciselé congelé
    name: 'Perifollo picado congelado',
    // FR: Le cerfeuil fane en un jour et ne supporte pas le séchage : le congélateur est son seul refuge.
    description: 'El perifollo se marchita en un día y no soporta el secado: el congelador es su único refugio.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '3 manojos de perifollo', // FR: 3 bouquets de cerfeuil
      'una cajita rígida de congelación', // FR: une petite boîte rigide de congélation
    ],
    steps: <String>[
      // FR: Rince le cerfeuil délicatement, ses feuilles se froissent vite.
      'Aclara el perifollo con delicadeza: sus hojas se arrugan enseguida.',
      // FR: Étale-le sur un torchon et tamponne jusqu'à ce qu'il soit **bien sec**.
      'Extiéndelo sobre un paño y sécalo con toquecitos hasta que esté **bien seco**.',
      // FR: Ôte les grosses tiges et cisèle les feuilles aux ciseaux, sans les écraser au couteau.
      'Quita los tallos gruesos y pica las hojas con tijeras, sin aplastarlas con el cuchillo.',
      // FR: Mets-les en vrac dans la boîte, sans tasser, ferme et congèle.
      'Ponlas sueltas en la caja, sin apretar, cierra y congela.',
      // FR: Ajoute-le gelé **hors du feu** dans le potage ou la sauce : la chaleur tue son parfum anisé.
      'Añádelo congelado **fuera del fuego** en el potaje o la salsa: el calor mata su aroma anisado.',
    ],
  ),
  'cerfeuil/Beurre de cerfeuil en rouleau': RecipeText(
    // FR: Beurre de cerfeuil en rouleau
    name: 'Mantequilla de perifollo en rollo',
    // FR: Enfermé dans le beurre, le cerfeuil garde son goût délicat jusqu'à l'hiver.
    description: 'Encerrado en la mantequilla, el perifollo conserva su delicado sabor hasta el invierno.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '250 g de mantequilla blanda', // FR: 250 g de beurre mou
      '2 manojos de perifollo', // FR: 2 bouquets de cerfeuil
      '1 chalota pequeña', // FR: 1 petite échalote
      '1 pizca de flor de sal', // FR: 1 pincée de fleur de sel
      'film transparente', // FR: du film alimentaire
    ],
    steps: <String>[
      // FR: Lave et sèche le cerfeuil, puis garde seulement les feuilles.
      'Lava y seca el perifollo y quédate solo con las hojas.',
      // FR: Hache-les finement avec l'échalote.
      'Pícalas finamente con la chalota.',
      // FR: Écrase le beurre mou à la fourchette avec le cerfeuil, l'échalote et le sel.
      'Machaca la mantequilla blanda con un tenedor junto con el perifollo, la chalota y la sal.',
      // FR: Roule-le dans le film en boudin bien serré et noue les deux bouts.
      'Enróllala en el film formando un churro bien apretado y anuda los dos extremos.',
      // FR: Congèle. Coupe une rondelle encore gelée sur un poisson poché, des carottes ou une pomme de terre chaude.
      'Congela. Corta una rodaja aún congelada sobre un pescado escalfado, zanahorias o una patata caliente.',
    ],
  ),
  'cerfeuil/Vinaigre blanc au cerfeuil': RecipeText(
    // FR: Vinaigre blanc au cerfeuil
    name: 'Vinagre blanco de perifollo',
    // FR: Une façon de garder sa note d'anis douce pour les vinaigrettes d'hiver.
    description: 'Una forma de guardar su suave nota anisada para los aliños de invierno.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 año en la despensa, protegido de la luz',
    ingredients: <String>[
      '2 manojos de perifollo', // FR: 2 bouquets de cerfeuil
      '50 cl de vinagre de vino blanco al 6 % como mínimo', // FR: 50 cl de vinaigre de vin blanc à 6 % minimum
      'un tarro limpio', // FR: un bocal propre
    ],
    steps: <String>[
      // FR: Rince le cerfeuil et sèche-le parfaitement sur un torchon.
      'Aclara el perifollo y sécalo perfectamente con un paño.',
      // FR: Tasse-le légèrement dans le bocal, tiges comprises.
      'Apriétalo ligeramente en el tarro, tallos incluidos.',
      // FR: Verse le vinaigre pur à froid pour le couvrir **entièrement** : chaud, il cuirait ce cerfeuil fragile.
      'Vierte el vinagre puro en frío hasta cubrirlo **por completo**: caliente, cocería este perifollo tan frágil.',
      // FR: Laisse infuser deux semaines à l'ombre, en secouant tous les deux jours.
      'Deja infusionar dos semanas a la sombra, agitando cada dos días.',
      // FR: Filtre dans une bouteille propre et jette le cerfeuil, qui a tout donné.
      'Filtra a una botella limpia y tira el perifollo, que ya lo ha dado todo.',
    ],
  ),
  'cerfeuil/Potage au cerfeuil': RecipeText(
    // FR: Potage au cerfeuil
    name: 'Potaje de perifollo',
    // FR: Ajouté à la fin seulement : la cuisson tue son parfum.
    description: 'Se añade solo al final: la cocción mata su aroma.',
  ),
  'cerfeuil/Sauce aux fines herbes': RecipeText(
    // FR: Sauce aux fines herbes
    name: 'Salsa de finas hierbas',
    // FR: Cerfeuil, ciboulette, persil, estragon — les quatre canoniques.
    description: 'Perifollo, cebollino, perejil, estragón: las cuatro canónicas.',
  ),
  'cerfeuil/Œufs brouillés au cerfeuil': RecipeText(
    // FR: Œufs brouillés au cerfeuil
    name: 'Huevos revueltos con perifollo',
    // FR: Cuisson très douce, cerfeuil hors du feu.
    description: 'Cocción muy suave, perifollo fuera del fuego.',
  ),

  // ─────────── cerisier (6 recettes) ───────────
  'cerisier/Cerises au sirop en bocaux': RecipeText(
    // FR: Cerises au sirop en bocaux
    name: 'Cerezas en almíbar en tarros',
    // FR: Un bocal de cerises en plein hiver, et le clafoutis de janvier a le goût de juin.
    description: 'Un tarro de cerezas en pleno invierno, y el clafoutis de enero sabe a junio.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 año en la despensa, 5 días abierto en la nevera',
    ingredients: <String>[
      '2 kg de cerezas', // FR: 2 kg de cerises
      '1 litro de agua', // FR: 1 litre d'eau
      '300 g de azúcar', // FR: 300 g de sucre
      'el zumo de un limón', // FR: le jus d'un citron
      '5 tarros de 50 cl con juntas nuevas', // FR: 5 bocaux de 50 cl avec joints neufs
    ],
    steps: <String>[
      // FR: Lave les cerises, équeute-les et écarte celles qui sont fendues ou piquées.
      'Lava las cerezas, quítales el rabito y aparta las que estén abiertas o picadas.',
      // FR: Dénoyaute-les ou garde-les entières : **avec le noyau**, elles se tiennent mieux et gardent plus de goût.
      'Deshuésalas o déjalas enteras: **con el hueso** se mantienen mejor y conservan más sabor.',
      // FR: Porte l'eau et le sucre à ébullition 2 minutes, puis ajoute le jus de citron.
      'Lleva el agua y el azúcar a ebullición 2 minutos y añade el zumo de limón.',
      // FR: Tasse les cerises dans les bocaux et couvre de sirop chaud **jusqu'à 2 cm du bord**. Ferme avec des joints neufs.
      'Apelmaza las cerezas en los tarros y cúbrelas con almíbar caliente **hasta 2 cm del borde**. Cierra con juntas nuevas.',
      // FR: Stérilise les bocaux couverts d'eau, 25 minutes à partir de l'ébullition.
      'Esteriliza los tarros cubiertos de agua, 25 minutos desde que hierva.',
      // FR: Laisse refroidir dans l'eau et vérifie le vide : couvercle creux, joint qui tient. Sinon, au frais et à manger vite.
      'Deja enfriar en el agua y comprueba el vacío: tapa hundida, junta que aguanta. Si no, a la nevera y a comerlas pronto.',
    ],
  ),
  'cerisier/Cerises dénoyautées congelées': RecipeText(
    // FR: Cerises dénoyautées congelées
    name: 'Cerezas deshuesadas congeladas',
    // FR: Dénoyautées une fois pour toutes, elles tombent directement dans un gâteau ou une compote.
    description: 'Deshuesadas de una vez por todas, van directamente a un bizcocho o a una compota.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1 kg de cerezas bien maduras', // FR: 1 kg de cerises bien mûres
      'un deshuesador', // FR: un dénoyauteur
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les cerises **avec leur queue**, pour que l'eau n'entre pas dans le fruit.
      'Lava las cerezas **con el rabito**, para que el agua no entre en la fruta.',
      // FR: Sèche-les bien sur un torchon : toute goutte restée devient du givre.
      'Sécalas bien con un paño: cada gota que quede se convierte en escarcha.',
      // FR: Équeute et dénoyaute-les au-dessus d'un saladier pour garder le jus.
      'Quítales el rabito y deshuésalas sobre un bol para recoger el jugo.',
      // FR: Étale-les sur une plaque **sans qu'elles se touchent** et congèle 3 heures.
      'Extiéndelas sobre una bandeja **sin que se toquen** y congela 3 horas.',
      // FR: Verse-les en sac une fois dures : elles ne forment pas de bloc et se prennent à la poignée.
      'Pásalas a una bolsa cuando estén duras: no forman bloque y se cogen a puñados.',
    ],
  ),
  'cerisier/Cerises séchées maison': RecipeText(
    // FR: Cerises séchées maison
    name: 'Cerezas secas caseras',
    // FR: Plus acidulées qu'un raisin sec, elles réveillent un muesli, un cake ou une farce de volaille.
    description: 'Más ácidas que una pasa, despiertan un muesli, un bizcocho o un relleno de ave.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 meses en tarro, en lugar seco',
    ingredients: <String>[
      '1,5 kg de cerezas bien maduras', // FR: 1,5 kg de cerises bien mûres
      'un deshuesador', // FR: un dénoyauteur
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Lave les cerises avec leur queue, puis sèche-les.
      'Lava las cerezas con el rabito y sécalas.',
      // FR: Équeute et dénoyaute-les, ou coupe-les en deux pour qu'elles sèchent plus vite.
      'Quítales el rabito y deshuésalas, o pártelas por la mitad para que se sequen más rápido.',
      // FR: Pose-les côté coupé vers le haut sur des grilles et sèche au four à **65 °C**, porte entrouverte.
      'Colócalas con el lado cortado hacia arriba sobre rejillas y sécalas en el horno a **65 °C**, con la puerta entreabierta.',
      // FR: Teste : elles doivent être fripées et souples comme des raisins secs, sans jus quand tu les presses.
      'Compruébalo: deben estar arrugadas y blandas como pasas, sin soltar jugo cuando las aprietas.',
      // FR: Laisse-les refroidir, mets-les en bocal et secoue chaque jour une semaine. De la buée, et c'est retour au four.
      'Déjalas enfriar, pásalas a un tarro y agítalo cada día durante una semana. Si ves vaho, vuelven al horno.',
    ],
  ),
  'cerisier/Clafoutis aux cerises': RecipeText(
    // FR: Clafoutis aux cerises
    name: 'Clafoutis de cerezas',
    // FR: Avec les noyaux, comme en Limousin : ils parfument la pâte.
    description: 'Con los huesos, como en el Limousin: perfuman la masa.',
  ),
  'cerisier/Confiture de cerises': RecipeText(
    // FR: Confiture de cerises
    name: 'Mermelada de cerezas',
    // FR: Dénoyautées à la main, un peu de citron pour la prise.
    description: 'Deshuesadas a mano, un poco de limón para que cuaje.',
  ),
  'cerisier/Cerises au vinaigre': RecipeText(
    // FR: Cerises au vinaigre
    name: 'Cerezas al vinagre',
    // FR: En aigre-doux, pour accompagner une viande froide.
    description: 'En agridulce, para acompañar una carne fría.',
  ),

  // ─────────── champignon_paris (6 recettes) ───────────
  'champignon_paris/Champignons poêlés pour le congélateur': RecipeText(
    // FR: Champignons poêlés pour le congélateur
    name: 'Champiñones salteados para el congelador',
    // FR: Crus, ils rendent de l'eau et deviennent spongieux ; poêlés d'abord, ils se congèlent parfaitement.
    description: 'Crudos, sueltan agua y se vuelven esponjosos; salteados antes, se congelan perfectamente.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de champiñones', // FR: 1,5 kg de champignons de Paris
      '30 g de mantequilla', // FR: 30 g de beurre
      '1 cucharada de aceite', // FR: 1 cuillère à soupe d'huile
      'sal', // FR: sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe le bout terreux des pieds et essuie les champignons avec un linge humide. **Ne les fais pas tremper** : ils boivent l'eau comme une éponge.
      'Corta la punta terrosa de los pies y limpia los champiñones con un paño húmedo. **No los dejes en remojo**: absorben el agua como una esponja.',
      // FR: Émince-les en lamelles de 5 mm.
      'Córtalos en láminas de 5 mm.',
      // FR: Fais-les sauter à feu vif dans le beurre et l'huile, en plusieurs fois, jusqu'à ce que leur eau soit **complètement évaporée** et qu'ils dorent.
      'Saltéalos a fuego vivo en la mantequilla y el aceite, en varias tandas, hasta que su agua se haya **evaporado por completo** y se doren.',
      // FR: Sale en fin de cuisson seulement : salés trop tôt, ils rendent leur eau et bouillent au lieu de dorer.
      'Sala solo al final de la cocción: salados demasiado pronto, sueltan su agua y hierven en lugar de dorarse.',
      // FR: Étale-les sur une assiette et laisse refroidir.
      'Extiéndelos en un plato y deja enfriar.',
      // FR: Mets en sacs d'une portion, à plat, et date. Réchauffe-les directement à la poêle.
      'Reparte en bolsas de una ración, en plano, y pon la fecha. Caliéntalos directamente en la sartén.',
    ],
  ),
  'champignon_paris/Lamelles de champignons séchées': RecipeText(
    // FR: Lamelles de champignons séchées
    name: 'Láminas de champiñón secas',
    // FR: Séchés, ils concentrent leur goût et se gardent un an : une poignée réhydratée suffit pour une sauce.
    description: 'Secos, concentran su sabor y se guardan un año: basta un puñado rehidratado para una salsa.',
    // FR: 1 an au sec, en bocal hermétique
    keeps: '1 año en seco, en tarro hermético',
    ingredients: <String>[
      '1 kg de champiñones bien firmes', // FR: 1 kg de champignons de Paris bien fermes
      'rejillas o bandejas', // FR: des grilles ou plaques
      'tarros bien secos', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Essuie les champignons sans les mouiller et coupe le bout des pieds.
      'Limpia los champiñones sin mojarlos y corta la punta de los pies.',
      // FR: Tranche-les en lamelles régulières de 5 mm.
      'Córtalos en láminas regulares de 5 mm.',
      // FR: Étale-les sur des grilles sans qu'elles se touchent et sèche à 50 °C, porte entrouverte, ou au déshydrateur.
      'Extiende las láminas sobre rejillas sin que se toquen y sécalas a 50 °C, con la puerta entreabierta, o en el deshidratador.',
      // FR: Retourne-les à mi-temps. Elles sont prêtes quand elles sont **cassantes**, plus du tout souples.
      'Dales la vuelta a mitad de tiempo. Están listas cuando son **quebradizas**, ya nada flexibles.',
      // FR: Laisse refroidir et mets en bocaux hermétiques. Pour cuisiner, trempe-les 20 minutes dans l'eau tiède, et garde l'eau pour la sauce.
      'Deja enfriar y pásalas a tarros herméticos. Para cocinar, ponlas 20 minutos en remojo en agua tibia y guarda el agua para la salsa.',
    ],
  ),
  'champignon_paris/Champignons marinés au vinaigre': RecipeText(
    // FR: Champignons marinés au vinaigre
    name: 'Champiñones marinados en vinagre',
    // FR: Petits champignons entiers, cuits dans un bouillon vinaigré aux aromates : l'antipasto de ton potager.
    description: 'Champiñones pequeños enteros, cocidos en un caldo avinagrado con hierbas aromáticas: el antipasto de tu huerto.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      '800 g de champiñones pequeños', // FR: 800 g de petits champignons de Paris
      '40 cl de vinagre blanco al 8 %', // FR: 40 cl de vinaigre blanc à 8 %
      '40 cl de agua', // FR: 40 cl d'eau
      '15 g de sal', // FR: 15 g de sel
      '2 hojas de laurel, 3 ramitas de tomillo, 1 cucharadita de granos de pimienta', // FR: 2 feuilles de laurier, 3 brins de thym, 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Essuie les champignons, coupe le bout des pieds et laisse-les entiers. Coupe en deux les plus gros.
      'Limpia los champiñones, corta la punta de los pies y déjalos enteros. Parte por la mitad los más grandes.',
      // FR: Porte à ébullition le vinaigre, l'eau et le sel avec le laurier, le thym et le poivre.
      'Lleva a ebullición el vinagre, el agua y la sal con el laurel, el tomillo y la pimienta.',
      // FR: Ajoute les champignons et laisse frémir **5 minutes** : ils cuisent dans le vinaigre, c'est ce qui les conserve.
      'Añade los champiñones y deja hervir suavemente **5 minutos**: se cuecen en el vinagre, y eso es lo que los conserva.',
      // FR: Répartis-les avec les aromates dans deux bocaux ébouillantés.
      'Repártelos con las hierbas aromáticas en dos tarros escaldados.',
      // FR: Verse le liquide bouillant pour **couvrir entièrement**, ferme et laisse refroidir.
      'Vierte el líquido hirviendo para **cubrirlos por completo**, cierra y deja enfriar.',
      // FR: Range au réfrigérateur et attends 2 jours. Pour servir, égoutte-les et arrose d'un filet d'huile dans l'assiette.
      'Guarda en la nevera y espera 2 días. Para servir, escúrrelos y riégalos con un chorrito de aceite en el plato.',
    ],
  ),
  'champignon_paris/Champignons à la persillade': RecipeText(
    // FR: Champignons à la persillade
    name: 'Champiñones al ajo y perejil',
    // FR: À feu vif pour qu'ils dorent au lieu de rendre leur eau.
    description: 'A fuego vivo para que se doren en lugar de soltar su agua.',
  ),
  'champignon_paris/Duxelles': RecipeText(
    // FR: Duxelles
    name: 'Duxelles',
    // FR: Hachés fin et desséchés au beurre — la base de mille plats.
    description: 'Picados finos y desecados en mantequilla: la base de mil platos.',
  ),
  'champignon_paris/Champignons farcis au four': RecipeText(
    // FR: Champignons farcis au four
    name: 'Champiñones rellenos al horno',
    // FR: Têtes garnies de duxelles et de chapelure.
    description: 'Sombreros rellenos de duxelles y pan rallado.',
  ),

  // ─────────── chou_bruxelles (6 recettes) ───────────
  'chou_bruxelles/Choux de Bruxelles blanchis congelés': RecipeText(
    // FR: Choux de Bruxelles blanchis congelés
    name: 'Coles de Bruselas escaldadas y congeladas',
    // FR: Blanchis entiers puis congelés sur plaque, ils passent directement du sac à la poêle.
    description: 'Escaldadas enteras y congeladas en bandeja, pasan directamente de la bolsa a la sartén.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de coles de Bruselas', // FR: 2 kg de choux de Bruxelles
      'sal gruesa', // FR: gros sel
      '1 bol grande de agua con hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Retire les feuilles extérieures abîmées et recoupe la base. Trie-les par taille.
      'Quita las hojas exteriores estropeadas y recorta la base. Clasifícalas por tamaño.',
      // FR: Rince-les à l'eau froide et fais une petite croix au pied des plus gros.
      'Enjuágalas con agua fría y haz una crucecita en la base de las más grandes.',
      // FR: Blanchis dans une grande eau bouillante salée : **3 minutes** pour les petits, **4 minutes** pour les gros.
      'Escalda en abundante agua hirviendo con sal: **3 minutos** las pequeñas, **4 minutos** las grandes.',
      // FR: Plonge-les aussitôt dans l'eau glacée, le temps qu'ils soient froids à cœur.
      'Sumérgelas enseguida en agua con hielo, el tiempo necesario para que estén frías por dentro.',
      // FR: Égoutte et sèche-les bien en les roulant dans un torchon.
      'Escúrrelas y sécalas bien enrollándolas en un paño.',
      // FR: Congèle-les 2 heures sur une plaque sans qu'ils se touchent, puis mets-les en sac daté.
      'Congélalas 2 horas sobre una bandeja sin que se toquen y luego pásalas a una bolsa con fecha.',
    ],
  ),
  'chou_bruxelles/Choux de Bruxelles lacto-fermentés': RecipeText(
    // FR: Choux de Bruxelles lacto-fermentés
    name: 'Coles de Bruselas lactofermentadas',
    // FR: Coupés en deux et noyés de saumure, ils deviennent acidulés et croquants, parfaits en apéritif.
    description: 'Partidas por la mitad y sumergidas en salmuera, se vuelven ácidas y crujientes, perfectas de aperitivo.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 meses en la nevera',
    ingredients: <String>[
      '1 kg de coles de Bruselas', // FR: 1 kg de choux de Bruxelles
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '2 dientes de ajo, 1 hoja de laurel', // FR: 2 gousses d'ail, 1 feuille de laurier
    ],
    steps: <String>[
      // FR: Fais dissoudre **30 g de sel dans 1 litre d'eau** : c'est ta saumure à 3 %. L'eau du robinet chlorée freine la fermentation, laisse-la reposer une nuit ou prends de l'eau de source.
      'Disuelve **30 g de sal en 1 litro de agua**: es tu salmuera al 3 %. El agua del grifo con cloro frena la fermentación; déjala reposar una noche o usa agua de manantial.',
      // FR: Nettoie les choux et coupe-les en deux pour que la saumure pénètre.
      'Limpia las coles y pártelas por la mitad para que la salmuera penetre.',
      // FR: Tasse-les dans deux bocaux avec l'ail écrasé et le laurier, en laissant 3 cm de vide en haut.
      'Apelmázalas en dos tarros con el ajo aplastado y el laurel, dejando 3 cm de vacío arriba.',
      // FR: Verse la saumure pour les couvrir, puis pose un poids : **rien ne doit dépasser**.
      'Vierte la salmuera para cubrirlas y pon un peso: **nada debe sobresalir**.',
      // FR: Ferme sans serrer et laisse fermenter 2 semaines à 18–22 °C, sur une assiette. Des bulles et une saumure trouble, c'est bon signe.
      'Cierra sin apretar y deja fermentar 2 semanas a 18–22 °C, sobre un plato. Burbujas y salmuera turbia son buena señal.',
      // FR: Goûte : quand c'est acidulé, serre les couvercles et passe au réfrigérateur.
      'Prueba: cuando estén ácidas, aprieta las tapas y pásalas a la nevera.',
    ],
  ),
  'chou_bruxelles/Pickles de choux de Bruxelles': RecipeText(
    // FR: Pickles de choux de Bruxelles
    name: 'Encurtidos de coles de Bruselas',
    // FR: Blanchis deux minutes puis mis au vinaigre épicé : une façon inattendue de finir une grosse récolte.
    description: 'Escaldadas dos minutos y puestas en vinagre especiado: una forma inesperada de acabar una cosecha abundante.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '800 g de coles de Bruselas pequeñas', // FR: 800 g de petits choux de Bruxelles
      '30 cl de vinagre blanco al 8 %', // FR: 30 cl de vinaigre blanc à 8 %
      '30 cl de agua', // FR: 30 cl d'eau
      '12 g de sal, 30 g de azúcar', // FR: 12 g de sel, 30 g de sucre
      '1 cucharadita de semillas de mostaza, 1 guindilla pequeña', // FR: 1 cuillère à café de graines de moutarde, 1 petit piment
    ],
    steps: <String>[
      // FR: Nettoie les choux et coupe les plus gros en deux.
      'Limpia las coles y parte por la mitad las más grandes.',
      // FR: Blanchis-les **2 minutes** à l'eau bouillante salée : crus, le vinaigre ne les pénètre pas.
      'Escáldalas **2 minutos** en agua hirviendo con sal: crudas, el vinagre no las penetra.',
      // FR: Refroidis-les dans l'eau glacée et égoutte.
      'Enfríalas en agua con hielo y escúrrelas.',
      // FR: Remplis deux bocaux ébouillantés avec les choux, la moutarde et le piment.
      'Llena dos tarros escaldados con las coles, la mostaza y la guindilla.',
      // FR: Fais bouillir le vinaigre, l'eau, le sel et le sucre.
      'Hierve el vinagre, el agua, la sal y el azúcar.',
      // FR: Verse bouillant pour **couvrir entièrement** les choux, ferme, laisse refroidir et range au frais. Attends une semaine avant d'ouvrir.
      'Vierte hirviendo para **cubrir por completo** las coles, cierra, deja enfriar y guarda en frío. Espera una semana antes de abrir.',
    ],
  ),
  'chou_bruxelles/Choux de Bruxelles rôtis au lard': RecipeText(
    // FR: Choux de Bruxelles rôtis au lard
    name: 'Coles de Bruselas asadas con tocino',
    // FR: Coupés en deux, face contre la plaque : ils caramélisent.
    description: 'Partidas por la mitad, con la cara contra la bandeja: se caramelizan.',
  ),
  'chou_bruxelles/Choux de Bruxelles à la crème': RecipeText(
    // FR: Choux de Bruxelles à la crème
    name: 'Coles de Bruselas a la crema',
    // FR: Blanchis, puis fondus dans la crème à la muscade.
    description: 'Escaldadas y luego fundidas en nata con nuez moscada.',
  ),
  'chou_bruxelles/Salade de choux de Bruxelles crus': RecipeText(
    // FR: Salade de choux de Bruxelles crus
    name: 'Ensalada de coles de Bruselas crudas',
    // FR: Émincés très fin, pomme, noisettes, vinaigrette au miel.
    description: 'Cortadas muy finas, con manzana, avellanas y vinagreta de miel.',
  ),

  // ─────────── chou_chinois (6 recettes) ───────────
  'chou_chinois/Chou chinois en saumure au gingembre': RecipeText(
    // FR: Chou chinois en saumure au gingembre
    name: 'Col china en salmuera con jengibre',
    // FR: Tout simplement en saumure, sans pâte de piment : un chou acidulé et doux à glisser dans les soupes et les bols de riz.
    description: 'Sencillamente en salmuera, sin pasta de guindilla: una col ácida y suave para meter en sopas y boles de arroz.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '1 col china grande (alrededor de 1,5 kg)', // FR: 1 gros chou chinois (environ 1,5 kg)
      '1,5 litros de agua sin cloro', // FR: 1,5 litre d'eau non chlorée
      '45 g de sal sin yodo', // FR: 45 g de sel non iodé
      '1 trozo de jengibre de 4 cm', // FR: 1 morceau de gingembre de 4 cm
      '2 dientes de ajo', // FR: 2 gousses d'ail
    ],
    steps: <String>[
      // FR: Fais dissoudre **45 g de sel dans 1,5 litre d'eau** : saumure à 3 %.
      'Disuelve **45 g de sal en 1,5 litros de agua**: salmuera al 3 %.',
      // FR: Coupe le chou en tronçons de 4 cm, le gingembre en fines lamelles et l'ail en deux.
      'Corta la col en trozos de 4 cm, el jengibre en láminas finas y el ajo por la mitad.',
      // FR: Rince les tronçons à l'eau froide et égoutte-les.
      'Enjuaga los trozos con agua fría y escúrrelos.',
      // FR: Tasse le chou dans trois bocaux en intercalant gingembre et ail, jusqu'à 3 cm du bord.
      'Apelmaza la col en tres tarros alternando jengibre y ajo, hasta 3 cm del borde.',
      // FR: Couvre de saumure et pose un poids : les feuilles flottent, il faut les **maintenir dessous**.
      'Cubre con salmuera y pon un peso: las hojas flotan, hay que **mantenerlas debajo**.',
      // FR: Laisse fermenter à 18–22 °C, couvercle posé sans serrer, de 1 à 2 semaines. Goûte à partir du 5e jour.
      'Deja fermentar a 18–22 °C, con la tapa puesta sin apretar, de 1 a 2 semanas. Prueba a partir del 5.º día.',
      // FR: Quand c'est acidulé à ton goût, ferme et passe au réfrigérateur.
      'Cuando esté ácida a tu gusto, cierra y pásala a la nevera.',
    ],
  ),
  'chou_chinois/Pickles rapides de chou chinois': RecipeText(
    // FR: Pickles rapides de chou chinois
    name: 'Encurtido rápido de col china',
    // FR: Un quart d'heure, et les côtes blanches deviennent un condiment aigre-doux pour les nouilles et les sandwichs.
    description: 'Un cuarto de hora, y los tallos blancos se convierten en un condimento agridulce para los fideos y los bocadillos.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      '600 g de tallos de col china', // FR: 600 g de côtes de chou chinois
      '25 cl de vinagre blanco al 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl de agua', // FR: 25 cl d'eau
      '10 g de sal, 40 g de azúcar', // FR: 10 g de sel, 40 g de sucre
      '1 cucharadita de semillas de sésamo', // FR: 1 cuillère à café de graines de sésame
    ],
    steps: <String>[
      // FR: Sépare les côtes blanches du vert et taille-les en biais en lanières d'un doigt. Garde le vert pour une poêlée.
      'Separa los tallos blancos de la parte verde y córtalos al bies en tiras del ancho de un dedo. Guarda lo verde para un salteado.',
      // FR: Remplis deux bocaux ébouillantés avec les lanières et le sésame.
      'Llena dos tarros escaldados con las tiras y el sésamo.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre jusqu'à dissolution.
      'Hierve el vinagre, el agua, la sal y el azúcar hasta que se disuelvan.',
      // FR: Verse bouillant pour **couvrir entièrement** les côtes, ferme aussitôt.
      'Vierte hirviendo para **cubrir por completo** los tallos y cierra enseguida.',
      // FR: Laisse refroidir puis range au réfrigérateur. Prêt dès le lendemain.
      'Deja enfriar y guarda en la nevera. Listo desde el día siguiente.',
    ],
  ),
  'chou_chinois/Chou chinois blanchi pour les soupes': RecipeText(
    // FR: Chou chinois blanchi pour les soupes
    name: 'Col china escaldada para sopas',
    // FR: Une minute dans l'eau, et il attend au congélateur le prochain bouillon ou la prochaine soupe de nouilles.
    description: 'Un minuto en el agua, y espera en el congelador al próximo caldo o a la próxima sopa de fideos.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de col china', // FR: 1,5 kg de chou chinois
      'sal gruesa', // FR: gros sel
      '1 bol grande de agua con hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe le chou en lanières de 3 cm, en séparant les côtes du vert tendre.
      'Corta la col en tiras de 3 cm, separando los tallos de lo verde tierno.',
      // FR: Lave et égoutte les lanières.
      'Lava y escurre las tiras.',
      // FR: Blanchis les côtes **1 minute 30** puis ajoute le vert pour 30 secondes, dans une grande eau bouillante salée.
      'Escalda los tallos **1 min 30 s** y luego añade lo verde durante 30 segundos, en abundante agua hirviendo con sal.',
      // FR: Plonge tout dans l'eau glacée, puis presse bien pour chasser l'eau.
      'Sumerge todo en agua con hielo y luego prensa bien para sacar el agua.',
      // FR: Mets en sacs à plat, en portions d'une soupe. Il se met directement, encore gelé, dans le bouillon : décongelé, il est trop mou pour un sauté.
      'Pasa a bolsas en plano, en raciones de una sopa. Va directamente, aún congelada, al caldo: descongelada, está demasiado blanda para un salteado.',
    ],
  ),
  'chou_chinois/Chou chinois sauté au wok': RecipeText(
    // FR: Chou chinois sauté au wok
    name: 'Col china salteada en wok',
    // FR: Gingembre, ail, sauce soja, deux minutes à feu vif.
    description: 'Jengibre, ajo, salsa de soja, dos minutos a fuego vivo.',
  ),
  'chou_chinois/Kimchi maison': RecipeText(
    // FR: Kimchi maison
    name: 'Kimchi casero',
    // FR: Salé, épicé, fermenté une semaine à température.
    description: 'Salado, picante, fermentado una semana a temperatura ambiente.',
  ),
  'chou_chinois/Salade de chou chinois au sésame': RecipeText(
    // FR: Salade de chou chinois au sésame
    name: 'Ensalada de col china con sésamo',
    // FR: Émincé cru, vinaigre de riz, huile de sésame.
    description: 'Cortada cruda, vinagre de arroz, aceite de sésamo.',
  ),

  // ─────────── chou_fleur (6 recettes) ───────────
  'chou_fleur/Fleurettes de chou-fleur blanchies': RecipeText(
    // FR: Fleurettes de chou-fleur blanchies
    name: 'Ramilletes de coliflor escaldados',
    // FR: Trois minutes dans l'eau bouillante, et ton chou-fleur attend sagement le gratin de janvier.
    description: 'Tres minutos en agua hirviendo, y tu coliflor espera tranquila al gratinado de enero.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 coliflores', // FR: 2 chou-fleurs
      'sal gruesa', // FR: gros sel
      'un bol grande de agua con hielo', // FR: un grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Retire les feuilles et détaille le chou-fleur en fleurettes de 3 cm, de taille régulière.
      'Quita las hojas y separa la coliflor en ramilletes de 3 cm, de tamaño regular.',
      // FR: Fais-les tremper 10 minutes dans l'eau salée : les petites chenilles cachées remontent à la surface.
      'Déjalos 10 minutos en remojo en agua con sal: las pequeñas orugas escondidas suben a la superficie.',
      // FR: Plonge les fleurettes dans une grande eau salée bouillante, **3 minutes**.
      'Sumerge los ramilletes en abundante agua con sal hirviendo, **3 minutos**.',
      // FR: Transfère-les aussitôt dans l'eau glacée, jusqu'à ce qu'elles soient froides à cœur.
      'Pásalos enseguida al agua con hielo, hasta que estén fríos por dentro.',
      // FR: Égoutte-les tête en bas et sèche-les bien dans un torchon.
      'Escúrrelos boca abajo y sécalos bien en un paño.',
      // FR: Congèle-les sur une plaque, puis passe-les en sac. Elles se cuisent sans décongeler.
      'Congélalos sobre una bandeja y luego pásalos a una bolsa. Se cocinan sin descongelar.',
    ],
  ),
  'chou_fleur/Piccalilli au chou-fleur': RecipeText(
    // FR: Piccalilli au chou-fleur
    name: 'Piccalilli de coliflor',
    // FR: Le condiment anglais jaune vif à la moutarde et au curcuma, pour la viande froide et les sandwichs.
    description: 'El condimento inglés de un amarillo intenso, con mostaza y cúrcuma, para la carne fría y los bocadillos.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '1 coliflor, 2 zanahorias y 1 cebolla', // FR: 1 chou-fleur, 2 carottes et 1 oignon
      '50 g de sal gruesa', // FR: 50 g de gros sel
      '50 cl de vinagre de sidra al 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '150 g de azúcar', // FR: 150 g de sucre
      '2 cucharadas de mostaza en polvo, 1 de cúrcuma', // FR: 2 cuillères à soupe de moutarde en poudre, 1 de curcuma
      '2 cucharadas de maicena', // FR: 2 cuillères à soupe de maïzena
    ],
    steps: <String>[
      // FR: Taille le chou-fleur en toutes petites fleurettes, les carottes en petits dés et l'oignon en morceaux.
      'Corta la coliflor en ramilletes muy pequeños, las zanahorias en dados pequeños y la cebolla en trozos.',
      // FR: Mélange les légumes au gros sel et laisse dégorger une nuit au frais : ils restent croquants.
      'Mezcla las verduras con la sal gruesa y déjalas sudar una noche en frío: se mantienen crujientes.',
      // FR: Rince-les à grande eau et égoutte-les bien.
      'Aclara abundantemente y escúrrelas bien.',
      // FR: Délaie moutarde, curcuma et maïzena dans un peu de vinaigre froid, puis ajoute le reste du vinaigre et le sucre.
      'Disuelve la mostaza, la cúrcuma y la maicena en un poco de vinagre frío, y añade el resto del vinagre y el azúcar.',
      // FR: Porte cette sauce à ébullition en fouettant jusqu'à ce qu'elle épaississe, ajoute les légumes et cuis-les dedans.
      'Lleva esta salsa a ebullición batiendo hasta que espese, añade las verduras y cuécelas en ella.',
      // FR: Remplis des pots ébouillantés, ferme et laisse refroidir, puis range au réfrigérateur. Attends une semaine avant d'ouvrir.
      'Llena tarros escaldados, cierra y deja enfriar, luego guarda en la nevera. Espera una semana antes de abrir.',
    ],
  ),
  'chou_fleur/Chou-fleur fermenté au curcuma': RecipeText(
    // FR: Chou-fleur fermenté au curcuma
    name: 'Coliflor fermentada con cúrcuma',
    // FR: En saumure, les fleurettes deviennent acidulées et dorées, à picorer à l'apéritif ou à glisser dans une salade.
    description: 'En salmuera, los ramilletes se vuelven ácidos y dorados, para picar de aperitivo o echar en una ensalada.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 meses en la nevera',
    ingredients: <String>[
      '1 coliflor', // FR: 1 chou-fleur
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '1 cucharadita de cúrcuma', // FR: 1 cuillère à café de curcuma
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '1 cucharadita de semillas de cilantro', // FR: 1 cuillère à café de graines de coriandre
    ],
    steps: <String>[
      // FR: Dissous **30 g de sel** et le curcuma dans 1 litre d'eau : c'est la saumure.
      'Disuelve **30 g de sal** y la cúrcuma en 1 litro de agua: es la salmuera.',
      // FR: Détaille le chou-fleur en fleurettes de 3 cm et rince-les.
      'Separa la coliflor en ramilletes de 3 cm y enjuágalos.',
      // FR: Tasse-les dans un bocal avec l'ail écrasé et la coriandre, jusqu'à 3 cm du bord.
      'Apelmázalos en un tarro con el ajo aplastado y el cilantro, hasta 3 cm del borde.',
      // FR: Verse la saumure pour couvrir et pose un poids : les fleurettes flottent, elles doivent rester **sous la saumure**.
      'Vierte la salmuera para cubrir y pon un peso: los ramilletes flotan, deben quedar **bajo la salmuera**.',
      // FR: Laisse fermenter 2 semaines à 18–22 °C, couvercle posé sans serrer. L'odeur un peu soufrée est normale chez les choux.
      'Deja fermentar 2 semanas a 18–22 °C, con la tapa puesta sin apretar. El olor algo sulfuroso es normal en las coles.',
      // FR: Quand c'est assez acide à ton goût, ferme bien et range au réfrigérateur.
      'Cuando esté lo bastante ácida a tu gusto, cierra bien y guarda en la nevera.',
    ],
  ),
  'chou_fleur/Gratin de chou-fleur': RecipeText(
    // FR: Gratin de chou-fleur
    name: 'Gratinado de coliflor',
    // FR: Béchamel muscadée, gruyère, cuit juste assez pour rester entier.
    description: 'Bechamel con nuez moscada, gruyer, cocida lo justo para que quede entera.',
  ),
  'chou_fleur/Chou-fleur rôti aux épices': RecipeText(
    // FR: Chou-fleur rôti aux épices
    name: 'Coliflor asada con especias',
    // FR: En steaks épais, curcuma et cumin, four très chaud.
    description: 'En filetes gruesos, cúrcuma y comino, horno muy caliente.',
  ),
  'chou_fleur/Taboulé de chou-fleur': RecipeText(
    // FR: Taboulé de chou-fleur
    name: 'Tabulé de coliflor',
    // FR: Mixé cru en semoule, citron, menthe et persil.
    description: 'Triturada en crudo hasta quedar como sémola, limón, menta y perejil.',
  ),

  // ─────────── chou_kale (6 recettes) ───────────
  'chou_kale/Kale blanchi en boulettes': RecipeText(
    // FR: Kale blanchi en boulettes
    name: 'Kale escaldado en bolitas',
    // FR: Deux minutes à l'eau, une boulette pressée, et tu as une portion de vert prête pour une soupe ou une poêlée.
    description: 'Dos minutos en el agua, una bolita prensada, y tienes una ración de verde lista para una sopa o un salteado.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de hojas de kale', // FR: 1,5 kg de feuilles de kale
      'sal gruesa', // FR: gros sel
      '1 bol grande de agua con hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les feuilles dans plusieurs eaux, en frottant le revers où se cachent les pucerons.
      'Lava las hojas en varias aguas, frotando el envés, donde se esconden los pulgones.',
      // FR: Arrache la feuille de la grosse côte, qui reste dure même cuite, et déchire en morceaux.
      'Separa la hoja de la nervadura gruesa, que sigue dura incluso cocida, y trocea a mano.',
      // FR: Plonge le kale par poignées dans une grande eau bouillante salée, **2 minutes**.
      'Sumerge el kale a puñados en abundante agua hirviendo con sal, **2 minutos**.',
      // FR: Transfère aussitôt dans l'eau glacée : le vert devient éclatant et ne bougera plus.
      'Pásalo enseguida al agua con hielo: el verde se vuelve brillante y ya no cambiará.',
      // FR: Presse le kale fort entre tes mains pour chasser l'eau, et forme des boulettes d'une portion.
      'Prensa el kale con fuerza entre las manos para sacar el agua y forma bolitas de una ración.',
      // FR: Congèle-les 2 heures sur une plaque, puis range-les en sac daté.
      'Congélalas 2 horas sobre una bandeja y guárdalas luego en una bolsa con fecha.',
    ],
  ),
  'chou_kale/Flocons de kale séchés': RecipeText(
    // FR: Flocons de kale séchés
    name: 'Copos de kale secos',
    // FR: Séché tout doucement puis émietté, il se saupoudre dans les soupes, les omelettes et les sauces tout l'hiver.
    description: 'Seco muy despacio y luego desmenuzado, se espolvorea en sopas, tortillas y salsas todo el invierno.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegidos de la luz',
    ingredients: <String>[
      '1 kg de hojas de kale', // FR: 1 kg de feuilles de kale
      'un paño limpio', // FR: un torchon propre
      'tarros bien secos', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Lave les feuilles et **sèche-les complètement** à la centrifugeuse puis au torchon.
      'Lava las hojas y **sécalas por completo** con la centrifugadora y luego con un paño.',
      // FR: Retire les côtes et déchire les feuilles en morceaux de la taille d'une paume.
      'Quita las nervaduras y trocea las hojas del tamaño de una palma.',
      // FR: Étale-les en une seule couche sur des plaques et enfourne à 60 °C, porte entrouverte d'une cuillère en bois.
      'Extiéndelas en una sola capa sobre bandejas y mételas en el horno a 60 °C, con la puerta entreabierta con una cuchara de madera.',
      // FR: Vérifie : une feuille prête se brise net entre tes doigts. Si elle plie encore, continue 30 minutes.
      'Comprueba: una hoja lista se rompe limpiamente entre los dedos. Si aún se dobla, sigue 30 minutos más.',
      // FR: Laisse refroidir puis émiette à la main ou mixe en flocons.
      'Deja enfriar y desmenuza a mano o tritura hasta obtener copos.',
      // FR: Mets en bocaux bien secs, fermés, et range dans un placard sombre.
      'Pásalos a tarros bien secos, cerrados, y guárdalos en un armario oscuro.',
    ],
  ),
  'chou_kale/Pesto de kale en glaçons': RecipeText(
    // FR: Pesto de kale en glaçons
    name: 'Pesto de kale en cubitos',
    // FR: Plus corsé qu'un pesto de basilic, il tient au congélateur sans noircir.
    description: 'Más potente que un pesto de albahaca, aguanta en el congelador sin ennegrecerse.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '300 g de hojas de kale sin nervaduras', // FR: 300 g de feuilles de kale sans côtes
      '50 g de nueces', // FR: 50 g de noix
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '15 cl de aceite de oliva', // FR: 15 cl d'huile d'olive
      'el zumo de medio limón, sal', // FR: le jus d'un demi-citron, sel
    ],
    steps: <String>[
      // FR: Blanchis les feuilles 1 minute à l'eau bouillante salée : ça adoucit leur amertume.
      'Escalda las hojas 1 minuto en agua hirviendo con sal: así se suaviza su amargor.',
      // FR: Refroidis-les dans l'eau glacée, puis presse-les très fort.
      'Enfríalas en agua con hielo y luego prénsalas con mucha fuerza.',
      // FR: Mixe kale, noix, ail et citron par à-coups, en versant l'huile en filet. **Sans fromage**, tu l'ajouteras à table.
      'Tritura el kale, las nueces, el ajo y el limón a golpes, añadiendo el aceite en hilo. **Sin queso**: lo añadirás en la mesa.',
      // FR: Sale et goûte, puis remplis un bac à glaçons et couvre chaque case d'un filet d'huile.
      'Sala y prueba, luego llena una cubitera y cubre cada hueco con un chorrito de aceite.',
      // FR: Démoule quand c'est dur, au bout de 4 heures, et garde les cubes en sac daté.
      'Desmolda cuando esté duro, a las 4 horas, y guarda los cubos en una bolsa con fecha.',
    ],
  ),
  'chou_kale/Chips de kale': RecipeText(
    // FR: Chips de kale
    name: 'Chips de kale',
    // FR: Massées à l'huile, cuites à four doux jusqu'à craquer.
    description: 'Masajeadas con aceite, cocidas a horno suave hasta que crujan.',
  ),
  'chou_kale/Salade de kale massé': RecipeText(
    // FR: Salade de kale massé
    name: 'Ensalada de kale masajeado',
    // FR: Masser les feuilles au citron les attendrit en deux minutes.
    description: 'Masajear las hojas con limón las ablanda en dos minutos.',
  ),
  'chou_kale/Kale sauté à l\'ail et au chorizo': RecipeText(
    // FR: Kale sauté à l'ail et au chorizo
    name: 'Kale salteado con ajo y chorizo',
    // FR: Le gras du chorizo enrobe les feuilles.
    description: 'La grasa del chorizo envuelve las hojas.',
  ),

  // ─────────── chou_pomme (6 recettes) ───────────
  'chou_pomme/Lanières de chou blanchies congelées': RecipeText(
    // FR: Lanières de chou blanchies congelées
    name: 'Tiras de repollo escaldadas y congeladas',
    // FR: Une minute et demie dans l'eau bouillante, et ton chou est prêt pour les potées et les poêlées de l'hiver.
    description: 'Un minuto y medio en agua hirviendo, y tu repollo está listo para los guisos y salteados del invierno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1 repollo grande (unos 2 kg)', // FR: 1 gros chou pommé (environ 2 kg)
      'sal gruesa', // FR: gros sel
      'un bol grande de agua con hielo', // FR: un grand saladier d'eau glacée
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Retire les feuilles extérieures abîmées, coupe le chou en quatre et ôte le trognon.
      'Quita las hojas exteriores estropeadas, corta el repollo en cuatro y quita el troncho.',
      // FR: Émince chaque quartier en lanières d'un centimètre.
      'Corta cada cuarto en tiras de un centímetro.',
      // FR: Rince les lanières dans une bassine d'eau froide pour décoller la terre et les petites bêtes.
      'Enjuaga las tiras en una palangana de agua fría para despegar la tierra y los bichitos.',
      // FR: Plonge-les par grosses poignées dans l'eau bouillante salée et compte **2 minutes**, pas plus.
      'Échalas por buenos puñados en agua hirviendo con sal y cuenta **2 minutos**, no más.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée pour arrêter la cuisson.
      'Escurre y sumérgelas enseguida en agua con hielo para parar la cocción.',
      // FR: Égoutte à fond et essore à la centrifugeuse à salade ou dans un torchon.
      'Escurre a fondo y centrifuga en la centrifugadora de ensalada o en un paño.',
      // FR: Mets en sacs à plat par portions d'un repas, chasse l'air et congèle. Se cuisine sans décongeler.
      'Pásalas a bolsas en plano, en raciones de una comida, saca el aire y congela. Se cocina sin descongelar.',
    ],
  ),
  'chou_pomme/Chou rouge aigre-doux en bocal': RecipeText(
    // FR: Chou rouge aigre-doux en bocal
    name: 'Lombarda agridulce en tarro',
    // FR: Salé une nuit puis noyé de vinaigre épicé, le chou rouge devient un condiment violet qui réveille l'hiver.
    description: 'Salada una noche y luego sumergida en vinagre especiado, la lombarda se convierte en un condimento morado que despierta el invierno.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '1 lombarda (unos 1,5 kg)', // FR: 1 chou rouge (environ 1,5 kg)
      '40 g de sal gruesa', // FR: 40 g de gros sel
      '60 cl de vinagre de sidra al 6 %', // FR: 60 cl de vinaigre de cidre à 6 %
      '40 cl de agua', // FR: 40 cl d'eau
      '80 g de azúcar', // FR: 80 g de sucre
      '1 cucharadita de bayas de enebro y 2 hojas de laurel', // FR: 1 cuillère à café de baies de genièvre et 2 feuilles de laurier
    ],
    steps: <String>[
      // FR: Ôte le trognon et émince le chou très finement, à la mandoline si tu en as une.
      'Quita el troncho y corta la lombarda muy fina, con mandolina si tienes una.',
      // FR: Mélange-le au gros sel dans un saladier, couvre et laisse **une nuit** : il rend son eau et s'assouplit.
      'Mézclala con la sal gruesa en un bol, tapa y deja **una noche**: suelta su agua y se ablanda.',
      // FR: Rince-le soigneusement à l'eau froide et égoutte-le en le pressant.
      'Aclárala con cuidado con agua fría y escúrrela presionándola.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre, le genièvre et le laurier, puis laisse tiédir 10 minutes.
      'Lleva a ebullición el vinagre, el agua, el azúcar, el enebro y el laurel, y deja templar 10 minutos.',
      // FR: Tasse le chou dans des bocaux propres jusqu'à 2 cm du bord.
      'Apelmaza la lombarda en tarros limpios hasta 2 cm del borde.',
      // FR: Verse le vinaigre jusqu'à **recouvrir entièrement** le chou, tasse avec une cuillère pour chasser l'air, ferme.
      'Vierte el vinagre hasta **cubrir por completo** la lombarda, presiona con una cuchara para sacar el aire y cierra.',
      // FR: Range au réfrigérateur et attends une semaine : il devient croquant, rose vif et bien parfumé.
      'Guarda en la nevera y espera una semana: se vuelve crujiente, de un rosa vivo y muy aromática.',
    ],
  ),
  'chou_pomme/Kimchi de chou pommé': RecipeText(
    // FR: Kimchi de chou pommé
    name: 'Kimchi de repollo',
    // FR: Le kimchi se fait aussi avec un chou d'ici : salé, pimenté, fermenté, il vit et s'affine au frais pendant des mois.
    description: 'El kimchi también se hace con una col de aquí: salado, picante, fermentado, vive y se afina en frío durante meses.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 meses en la nevera',
    ingredients: <String>[
      '1 repollo de 1 kg, sin troncho', // FR: 1 chou pommé de 1 kg, sans trognon
      '20 g de sal fina sin yodo', // FR: 20 g de sel fin non iodé
      '4 dientes de ajo', // FR: 4 gousses d'ail
      '1 trozo de jengibre de 3 cm', // FR: 1 morceau de gingembre de 3 cm
      '2 cucharadas de guindilla coreana o de pimiento dulce en copos', // FR: 2 cuillères à soupe de piment coréen ou de piment doux en flocons
      '4 cebolletas', // FR: 4 oignons nouveaux
    ],
    steps: <String>[
      // FR: Coupe le chou en carrés de 3 cm et pèse-le : il te faut **20 g de sel par kilo** de chou.
      'Corta el repollo en cuadrados de 3 cm y pésalo: necesitas **20 g de sal por kilo** de repollo.',
      // FR: Masse le chou avec le sel à pleines mains quelques minutes, puis laisse-le reposer : il va rendre son jus.
      'Masajea el repollo con la sal a manos llenas unos minutos y déjalo reposar: soltará su jugo.',
      // FR: Mixe l'ail, le gingembre et le piment avec 2 cuillères d'eau pour faire une pâte.
      'Tritura el ajo, el jengibre y la guindilla con 2 cucharadas de agua para hacer una pasta.',
      // FR: Mélange la pâte et les oignons nouveaux émincés au chou, avec son jus. Mets des gants, ça pique.
      'Mezcla la pasta y las cebolletas en rodajas con el repollo y su jugo. Ponte guantes, que pica.',
      // FR: Tasse fort dans un bocal propre jusqu'à ce que le jus remonte et **recouvre le chou**. Laisse 3 cm de vide.
      'Apelmaza con fuerza en un tarro limpio hasta que el jugo suba y **cubra el repollo**. Deja 3 cm de vacío.',
      // FR: Pose un poids (un petit sac congélation rempli d'eau) et laisse fermenter 5 à 7 jours vers 20 °C, en appuyant chaque jour.
      'Pon un peso (una bolsita de congelación llena de agua) y deja fermentar de 5 a 7 días a unos 20 °C, presionando cada día.',
      // FR: Quand il est bien acidulé, range-le au réfrigérateur. Il continue de mûrir doucement.
      'Cuando esté bien ácido, guárdalo en la nevera. Sigue madurando despacio.',
    ],
  ),
  'chou_pomme/Choucroute maison': RecipeText(
    // FR: Choucroute maison
    name: 'Chucrut casero',
    // FR: Chou, sel, du temps. La fermentation fait le reste.
    description: 'Col, sal, tiempo. La fermentación hace el resto.',
  ),
  'chou_pomme/Riz gras': RecipeText(
    // FR: Riz gras
    name: 'Riz gras',
    // FR: Le riz mijoté à la tomate du Burkina, avec ses gros morceaux de chou fondant.
    description: 'El arroz cocido a fuego lento con tomate de Burkina, con grandes trozos de repollo tierno.',
  ),
  'chou_pomme/Salade de chou': RecipeText(
    // FR: Salade de chou
    name: 'Ensalada de repollo',
    // FR: Du chou finement émincé avec carottes et vinaigrette, croquant et frais.
    description: 'Repollo finamente cortado con zanahorias y vinagreta, crujiente y fresco.',
  ),

  // ─────────── chou_rave (6 recettes) ───────────
  'chou_rave/Chou-rave fermenté au sel': RecipeText(
    // FR: Chou-rave fermenté au sel
    name: 'Colinabo fermentado en sal',
    // FR: Râpé et salé comme une choucroute, il devient acidulé et se garde des mois sans cuisson.
    description: 'Rallado y salado como un chucrut, se vuelve ácido y se conserva meses sin cocción.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 meses en la nevera',
    ingredients: <String>[
      '2 kg de colinabo', // FR: 2 kg de chou-rave
      '40 g de sal fina sin yodo (20 g por kg)', // FR: 40 g de sel fin non iodé (20 g par kg)
      '1 cucharadita de semillas de alcaravea', // FR: 1 cuillère à café de graines de carvi
      '3 tarros de 75 cl', // FR: 3 bocaux de 75 cl
    ],
    steps: <String>[
      // FR: Épluche les choux-raves en enlevant bien la couche fibreuse, puis râpe-les gros.
      'Pela los colinabos quitando bien la capa fibrosa y rállalos grueso.',
      // FR: Pèse la râpée et ajoute **20 g de sel par kilo**. Mélange avec le carvi.
      'Pesa lo rallado y añade **20 g de sal por kilo**. Mezcla con la alcaravea.',
      // FR: Malaxe à pleines mains 5 minutes : le sel fait sortir le jus, et c'est ce jus qui sera ta saumure.
      'Amasa a manos llenas 5 minutos: la sal hace salir el jugo, y ese jugo será tu salmuera.',
      // FR: Tasse fort dans les bocaux, couche par couche, jusqu'à ce que le jus remonte au-dessus. Laisse 3 cm de vide en haut.
      'Apelmaza con fuerza en los tarros, capa por capa, hasta que el jugo suba por encima. Deja 3 cm de vacío arriba.',
      // FR: Pose un poids (petit pot rempli d'eau, galet ébouillanté) : tout doit rester **sous le jus**. Complète si besoin avec de l'eau salée à 30 g par litre.
      'Pon un peso (un tarrito lleno de agua, un canto rodado escaldado): todo debe quedar **bajo el jugo**. Si hace falta, completa con agua salada a 30 g por litro.',
      // FR: Ferme sans serrer et laisse fermenter à 18–22 °C pendant 2 semaines, sur une assiette : ça déborde parfois les premiers jours.
      'Cierra sin apretar y deja fermentar a 18–22 °C durante 2 semanas, sobre un plato: a veces rebosa los primeros días.',
      // FR: Quand c'est acidulé à ton goût, serre les couvercles et passe les bocaux au réfrigérateur.
      'Cuando esté ácido a tu gusto, aprieta las tapas y pasa los tarros a la nevera.',
    ],
  ),
  'chou_rave/Bâtonnets de chou-rave au vinaigre': RecipeText(
    // FR: Bâtonnets de chou-rave au vinaigre
    name: 'Palitos de colinabo en vinagre',
    // FR: Un quart d'heure, et le chou-rave garde son croquant de pomme dans un bocal au frais.
    description: 'Un cuarto de hora, y el colinabo conserva su crujido de manzana en un tarro en frío.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '600 g de colinabo', // FR: 600 g de chou-rave
      '25 cl de vinagre blanco al 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl de agua', // FR: 25 cl d'eau
      '10 g de sal, 25 g de azúcar', // FR: 10 g de sel, 25 g de sucre
      '1 guindilla pequeña, unas ramitas de eneldo', // FR: 1 petit piment, quelques brins d'aneth
    ],
    steps: <String>[
      // FR: Épluche le chou-rave et coupe-le en bâtonnets de 1 cm d'épaisseur.
      'Pela el colinabo y córtalo en palitos de 1 cm de grosor.',
      // FR: Serre-les debout dans deux bocaux ébouillantés, avec l'aneth et le piment fendu.
      'Colócalos de pie, apretados, en dos tarros escaldados, con el eneldo y la guindilla abierta.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre jusqu'à dissolution.
      'Hierve el vinagre, el agua, la sal y el azúcar hasta que se disuelvan.',
      // FR: Verse bouillant pour **couvrir entièrement** les bâtonnets, ferme aussitôt.
      'Vierte hirviendo para **cubrir por completo** los palitos y cierra enseguida.',
      // FR: Laisse refroidir puis range au réfrigérateur. Ils sont bons au bout de 2 jours.
      'Deja enfriar y guarda en la nevera. Están buenos a los 2 días.',
    ],
  ),
  'chou_rave/Dés de chou-rave blanchis congelés': RecipeText(
    // FR: Dés de chou-rave blanchis congelés
    name: 'Dados de colinabo escaldados y congelados',
    // FR: Coupé en dés et blanchi deux minutes, il file tout droit dans les soupes et les poêlées d'hiver.
    description: 'Cortado en dados y escaldado dos minutos, va directo a las sopas y salteados de invierno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de colinabo', // FR: 1,5 kg de chou-rave
      'sal gruesa', // FR: gros sel
      '1 bol grande de agua con hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche généreusement et coupe en dés de 2 cm, réguliers pour qu'ils blanchissent pareil.
      'Pela generosamente y corta en dados de 2 cm, regulares para que se escalden por igual.',
      // FR: Plonge les dés dans une grande eau bouillante salée, **2 minutes** à la reprise de l'ébullition.
      'Echa los dados en abundante agua hirviendo con sal, **2 minutos** desde que vuelva a hervir.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée pour stopper la cuisson.
      'Escurre y sumérgelos enseguida en agua con hielo para detener la cocción.',
      // FR: Égoutte et sèche bien sur un torchon.
      'Escurre y sécalos bien sobre un paño.',
      // FR: Congèle à plat sur une plaque 2 heures, puis mets en sacs datés : les dés resteront séparés.
      'Congela en plano sobre una bandeja 2 horas y luego pásalos a bolsas con fecha: los dados quedarán sueltos.',
    ],
  ),
  'chou_rave/Chou-rave râpé en rémoulade': RecipeText(
    // FR: Chou-rave râpé en rémoulade
    name: 'Colinabo rallado en remoulade',
    // FR: Cru, il croque comme une pomme et goûte la noisette.
    description: 'Crudo, cruje como una manzana y sabe a avellana.',
  ),
  'chou_rave/Chou-rave sauté au beurre': RecipeText(
    // FR: Chou-rave sauté au beurre
    name: 'Colinabo salteado con mantequilla',
    // FR: En bâtonnets, à peine dorés, avec du persil.
    description: 'En palitos, apenas dorados, con perejil.',
  ),
  'chou_rave/Gratin de chou-rave': RecipeText(
    // FR: Gratin de chou-rave
    name: 'Gratinado de colinabo',
    // FR: En lamelles fines, crème et comté.
    description: 'En láminas finas, nata y comté.',
  ),

  // ─────────── ciboulette (6 recettes) ───────────
  'ciboulette/Ciboulette ciselée en boîte au congélateur': RecipeText(
    // FR: Ciboulette ciselée en boîte au congélateur
    name: 'Cebollino picado en caja en el congelador',
    // FR: Séchée, la ciboulette ne sent plus rien ; congelée, elle garde son piquant d'oignon tout l'hiver.
    description: 'Seco, el cebollino ya no huele a nada; congelado, conserva su sabor a cebolla todo el invierno.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '4 buenos puñados de cebollino', // FR: 4 belles poignées de ciboulette
      'una caja rígida o un tarro de congelación', // FR: une boîte rigide ou un bocal de congélation
    ],
    steps: <String>[
      // FR: Rince les brins à l'eau froide et secoue-les bien.
      'Aclara los tallos con agua fría y sacúdelos bien.',
      // FR: Étale-les sur un torchon et laisse-les **sécher complètement**. Une ciboulette humide gèle en bloc.
      'Extiéndelos sobre un paño y déjalos **secar por completo**. Un cebollino húmedo se congela en bloque.',
      // FR: Cisèle-la finement aux ciseaux, en tronçons de 3 à 5 mm. Retire les bouts jaunis.
      'Pícalo fino con tijeras, en trozos de 3 a 5 mm. Quita las puntas amarillentas.',
      // FR: Verse-la en vrac dans une boîte rigide, sans tasser, et ferme. Note la date.
      'Échalo suelto en una caja rígida, sin apretar, y cierra. Anota la fecha.',
      // FR: Secoue la boîte de temps en temps les premiers jours : elle reste en grains et se pince directement.
      'Agita la caja de vez en cuando los primeros días: se mantiene en granitos y se coge a pellizcos.',
      // FR: À l'usage, jette-la **encore gelée** dans l'omelette ou la sauce. Décongelée, elle devient molle.
      'Al usarlo, échalo **aún congelado** a la tortilla o a la salsa. Descongelado, se queda blando.',
    ],
  ),
  'ciboulette/Vinaigre rose aux fleurs de ciboulette': RecipeText(
    // FR: Vinaigre rose aux fleurs de ciboulette
    name: 'Vinagre rosa de flores de cebollino',
    // FR: Les pompons mauves colorent le vinaigre en rose et lui donnent un doux goût d'oignon.
    description: 'Los pompones morados tiñen el vinagre de rosa y le dan un suave sabor a cebolla.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 año en la despensa, protegido de la luz',
    ingredients: <String>[
      '2 puñados de flores de cebollino bien abiertas', // FR: 2 poignées de fleurs de ciboulette bien ouvertes
      '50 cl de vinagre de vino blanco al 6 % como mínimo', // FR: 50 cl de vinaigre de vin blanc à 6 % minimum
      'un tarro de cristal limpio', // FR: un bocal en verre propre
    ],
    steps: <String>[
      // FR: Coupe les fleurs juste sous le pompon, une fois bien ouvertes et sans rosée.
      'Corta las flores justo debajo del pompón, cuando estén bien abiertas y sin rocío.',
      // FR: Plonge-les dans l'eau froide et secoue : de petites bêtes se cachent entre les fleurettes. Sèche-les sur un torchon.
      'Sumérgelas en agua fría y sacúdelas: entre las florecillas se esconden bichitos. Sécalas sobre un paño.',
      // FR: Remplis le bocal aux deux tiers de fleurs, sans tasser.
      'Llena el tarro hasta dos tercios con las flores, sin apretar.',
      // FR: Verse le vinaigre pur jusqu'en haut : les fleurs doivent être **entièrement couvertes**, sinon elles moisissent.
      'Vierte el vinagre puro hasta arriba: las flores deben quedar **totalmente cubiertas**, o se enmohecen.',
      // FR: Ferme et laisse infuser deux semaines à l'ombre, en secouant le bocal tous les deux ou trois jours.
      'Cierra y deja infusionar dos semanas a la sombra, agitando el tarro cada dos o tres días.',
      // FR: Filtre dans une passoire fine, mets en bouteille propre et jette les fleurs fatiguées.
      'Filtra con un colador fino, pasa a una botella limpia y tira las flores cansadas.',
    ],
  ),
  'ciboulette/Sel vert à la ciboulette': RecipeText(
    // FR: Sel vert à la ciboulette
    name: 'Sal verde de cebollino',
    // FR: Mixée au gros sel puis séchée au four, la ciboulette se garde un an dans une salière.
    description: 'Triturado con sal gruesa y luego secado al horno, el cebollino se conserva un año en un salero.',
    // FR: 1 an au placard, en bocal fermé
    keeps: '1 año en la despensa, en tarro cerrado',
    ingredients: <String>[
      '100 g de cebollino', // FR: 100 g de ciboulette
      '300 g de sal gruesa marina', // FR: 300 g de gros sel de mer
      'una bandeja y papel de horno', // FR: une plaque et du papier cuisson
    ],
    steps: <String>[
      // FR: Lave et **sèche à fond** la ciboulette, puis coupe-la en tronçons.
      'Lava y **seca a fondo** el cebollino, luego córtalo en trozos.',
      // FR: Mixe-la par à-coups avec le gros sel jusqu'à un sable vert humide.
      'Tritúralo a golpes con la sal gruesa hasta obtener una arena verde húmeda.',
      // FR: Étale en couche fine sur la plaque et enfourne à 50 °C, porte entrouverte avec une cuillère en bois.
      'Extiéndelo en capa fina sobre la bandeja y mételo al horno a 50 °C, con la puerta entreabierta con una cuchara de madera.',
      // FR: Émiette et remue toutes les demi-heures : le sel est prêt quand il coule entre les doigts sans coller.
      'Desmenuza y remueve cada media hora: la sal está lista cuando se desliza entre los dedos sin pegarse.',
      // FR: Laisse refroidir complètement sur la plaque, sinon la condensation le refait prendre en bloc.
      'Deja enfriar por completo sobre la bandeja, o la condensación la hará cuajar de nuevo en bloque.',
      // FR: Mets en pot bien sec. Il perd un peu de vert avec les mois, pas son goût.
      'Pásala a un tarro bien seco. Pierde un poco de verde con los meses, pero no su sabor.',
    ],
  ),
  'ciboulette/Fromage blanc aux herbes': RecipeText(
    // FR: Fromage blanc aux herbes
    name: 'Queso fresco con hierbas',
    // FR: Ciboulette, échalote, ail : la cervelle de canut.
    description: 'Cebollino, chalota, ajo: la clásica cervelle de canut de Lyon.',
  ),
  'ciboulette/Omelette à la ciboulette': RecipeText(
    // FR: Omelette à la ciboulette
    name: 'Tortilla de cebollino',
    // FR: Ajoutée hors du feu pour garder sa couleur.
    description: 'Añadido fuera del fuego para conservar su color.',
  ),
  'ciboulette/Beurre à la ciboulette': RecipeText(
    // FR: Beurre à la ciboulette
    name: 'Mantequilla de cebollino',
    // FR: En rouleau au congélateur, à trancher sur une viande.
    description: 'En rollo en el congelador, para cortar en rodajas sobre una carne.',
  ),

  // ─────────── citronnelle (6 recettes) ───────────
  'citronnelle/Tiges de citronnelle congelées': RecipeText(
    // FR: Tiges de citronnelle congelées
    name: 'Tallos de hierba limón congelados',
    // FR: La citronnelle se congèle presque sans perdre d'arôme : un quart d'heure, et tu en as pour toute l'année.
    description: 'La hierba limón se congela casi sin perder aroma: un cuarto de hora, y tienes para todo el año.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '20 tallos de hierba limón', // FR: 20 tiges de citronnelle
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe la base racinaire et la partie verte et sèche du haut : garde les 15 cm du bas, blancs et tendres.
      'Corta la base de las raíces y la parte verde y seca de arriba: quédate con los 15 cm de abajo, blancos y tiernos.',
      // FR: Retire la première feuille dure, rince et sèche bien les tiges.
      'Quita la primera hoja dura, enjuaga y seca bien los tallos.',
      // FR: Laisse-les entières pour parfumer les bouillons, ou émince-en une partie en rondelles fines pour les sautés.
      'Déjalos enteros para aromatizar caldos, o corta una parte en rodajas finas para los salteados.',
      // FR: Mets-les en sac à plat, chasse l'air et congèle. Elles se coupent **encore gelées**, plus facilement que fraîches.
      'Ponlos en una bolsa en plano, saca el aire y congela. Se cortan **aún congelados**, más fácilmente que frescos.',
    ],
  ),
  'citronnelle/Pâte de citronnelle au gingembre': RecipeText(
    // FR: Pâte de citronnelle au gingembre
    name: 'Pasta de hierba limón y jengibre',
    // FR: La base de tous les currys d'Asie du Sud-Est, mixée une fois et congelée en cubes prêts à jeter dans la poêle.
    description: 'La base de todos los currys del sudeste asiático, triturada una vez y congelada en cubitos listos para echar a la sartén.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '10 tallos de hierba limón', // FR: 10 tiges de citronnelle
      '1 trozo de jengibre de 6 cm', // FR: 1 morceau de gingembre de 6 cm
      '4 dientes de ajo', // FR: 4 gousses d'ail
      '2 chalotas', // FR: 2 échalotes
      '5 cl de aceite neutro', // FR: 5 cl d'huile neutre
    ],
    steps: <String>[
      // FR: Garde la partie blanche et tendre des tiges, retire la feuille extérieure et émince en fines rondelles.
      'Quédate con la parte blanca y tierna de los tallos, quita la hoja exterior y córtala en rodajas finas.',
      // FR: Épluche le gingembre, l'ail et les échalotes, et coupe-les grossièrement.
      'Pela el jengibre, el ajo y las chalotas, y trocéalos toscamente.',
      // FR: Mixe le tout avec l'huile jusqu'à obtenir une pâte fine. Racle les bords plusieurs fois, la citronnelle est fibreuse.
      'Tritura todo con el aceite hasta obtener una pasta fina. Rasca los bordes varias veces: la hierba limón es fibrosa.',
      // FR: Remplis un bac à glaçons, un cube par plat, et congèle jusqu'à ce qu'ils soient durs.
      'Llena una cubitera, un cubo por plato, y congela hasta que estén duros.',
      // FR: Démoule et garde en sac au congélateur. Avec l'ail cru dedans, **jamais à température ambiante** : utilise les cubes gelés, directement dans la poêle chaude.
      'Desmolda y guarda en una bolsa en el congelador. Con el ajo crudo dentro, **nunca a temperatura ambiente**: usa los cubos congelados, directamente en la sartén caliente.',
    ],
  ),
  'citronnelle/Feuilles de citronnelle séchées pour tisane': RecipeText(
    // FR: Feuilles de citronnelle séchées pour tisane
    name: 'Hojas de hierba limón secas para tisana',
    // FR: Les longues feuilles vertes, trop dures pour la cuisine, font une tisane citronnée tout l'hiver.
    description: 'Las largas hojas verdes, demasiado duras para la cocina, dan una tisana con sabor a limón todo el invierno.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegidas de la luz',
    ingredients: <String>[
      'las hojas verdes de 20 tallos de hierba limón', // FR: les feuilles vertes de 20 tiges de citronnelle
      'unas tijeras', // FR: des ciseaux
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Rince les feuilles et sèche-les à fond dans un torchon.
      'Enjuaga las hojas y sécalas a fondo con un paño.',
      // FR: Coupe-les aux ciseaux en tronçons de 2 à 3 cm.
      'Córtalas con tijeras en trozos de 2 a 3 cm.',
      // FR: Étale-les en couche fine sur une plaque et sèche au four à **40 °C**, porte entrouverte, ou à l'air dans un endroit sec et ombragé pendant une semaine.
      'Extiéndelas en capa fina sobre una bandeja y sécalas en el horno a **40 °C**, con la puerta entreabierta, o al aire en un lugar seco y sombreado durante una semana.',
      // FR: Elles sont prêtes quand elles cassent sous les doigts et ne sont plus souples du tout.
      'Están listas cuando se rompen entre los dedos y ya no son nada flexibles.',
      // FR: Range-les en bocal fermé, dans un placard sombre. Une cuillère à soupe pour une tasse d'eau frémissante, 5 minutes.
      'Guárdalas en un tarro cerrado, en un armario oscuro. Una cucharada por taza de agua a punto de hervir, 5 minutos.',
    ],
  ),
  'citronnelle/Sirop de citronnelle': RecipeText(
    // FR: Sirop de citronnelle
    name: 'Sirope de hierba limón',
    // FR: Tiges froissées infusées dans un sirop, pour une limonade.
    description: 'Tallos machacados infusionados en un almíbar, para una limonada.',
  ),
  'citronnelle/Poulet à la citronnelle': RecipeText(
    // FR: Poulet à la citronnelle
    name: 'Pollo a la hierba limón',
    // FR: Mariné au citron vert, à l'ail et à la citronnelle hachée.
    description: 'Marinado con lima, ajo y hierba limón picada.',
  ),
  'citronnelle/Infusion de citronnelle': RecipeText(
    // FR: Infusion de citronnelle
    name: 'Infusión de hierba limón',
    // FR: Quelques feuilles fraîches infusées, un parfum citronné qui apaise le soir.
    description: 'Unas hojas frescas infusionadas, un aroma cítrico que calma por la noche.',
  ),

  // ─────────── concombre (6 recettes) ───────────
  'concombre/Pickles de concombre à l\'aneth': RecipeText(
    // FR: Pickles de concombre à l'aneth
    name: 'Encurtidos de pepino al eneldo',
    // FR: La meilleure façon d'écouler une vague de concombres : en tranches croquantes, à l'aneth et à l'ail.
    description: 'La mejor forma de dar salida a una oleada de pepinos: en rodajas crujientes, con eneldo y ajo.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '1,5 kg de pepinos firmes', // FR: 1,5 kg de concombres fermes
      '30 g de sal', // FR: 30 g de sel
      '50 cl de vinagre blanco al 6 %', // FR: 50 cl de vinaigre blanc à 6 %
      '50 cl de agua', // FR: 50 cl d'eau
      '2 cucharadas de azúcar', // FR: 2 cuillères à soupe de sucre
      '1 manojo de eneldo y 3 dientes de ajo', // FR: 1 bouquet d'aneth et 3 gousses d'ail
    ],
    steps: <String>[
      // FR: Lave les concombres et coupe un fin bout côté fleur : il contient une enzyme qui ramollit les pickles.
      'Lava los pepinos y corta un trocito fino por el lado de la flor: contiene una enzima que ablanda los encurtidos.',
      // FR: Coupe-les en rondelles épaisses ou en quartiers dans la longueur.
      'Córtalos en rodajas gruesas o en cuartos a lo largo.',
      // FR: Sale-les et laisse-les dégorger avec quelques glaçons par-dessus : c'est le secret du **croquant**.
      'Sálalos y déjalos sudar con unos cubitos de hielo por encima: es el secreto del **crujiente**.',
      // FR: Rince-les à l'eau froide et égoutte-les bien.
      'Aclara con agua fría y escurre bien.',
      // FR: Tasse-les dans des bocaux propres avec l'aneth et l'ail en lamelles.
      'Apelmázalos en tarros limpios con el eneldo y el ajo en láminas.',
      // FR: Porte à ébullition vinaigre, eau et sucre jusqu'à ce que le sucre soit fondu.
      'Lleva a ebullición el vinagre, el agua y el azúcar hasta que el azúcar se disuelva.',
      // FR: Verse le vinaigre chaud jusqu'à **couvrir entièrement** les concombres, ferme et range au réfrigérateur après refroidissement. Prêts en 2 jours.
      'Vierte el vinagre caliente hasta **cubrir por completo** los pepinos, cierra y guarda en la nevera una vez fríos. Listos en 2 días.',
    ],
  ),
  'concombre/Concombres lacto-fermentés': RecipeText(
    // FR: Concombres lacto-fermentés
    name: 'Pepinos lactofermentados',
    // FR: Les vrais « malossols » d'Europe de l'Est : juste une saumure, de l'aneth, et la fermentation fait le reste.
    description: 'Los verdaderos «malossol» de Europa del Este: solo una salmuera, eneldo, y la fermentación hace el resto.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 meses en la nevera',
    ingredients: <String>[
      '1 kg de pepinos pequeños y firmes', // FR: 1 kg de petits concombres fermes
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '4 dientes de ajo', // FR: 4 gousses d'ail
      'unas cabezuelas de eneldo', // FR: quelques têtes d'aneth
      '2 hojas de parra o de roble', // FR: 2 feuilles de vigne ou de chêne
    ],
    steps: <String>[
      // FR: Lave les concombres à l'eau froide sans frotter fort et coupe le bout côté fleur.
      'Lava los pepinos con agua fría sin frotar fuerte y corta la punta del lado de la flor.',
      // FR: Dissous **30 g de sel dans 1 litre d'eau** pour faire la saumure.
      'Disuelve **30 g de sal en 1 litro de agua** para hacer la salmuera.',
      // FR: Mets les feuilles de vigne au fond du bocal : leurs tanins gardent les concombres fermes.
      'Pon las hojas de parra en el fondo del tarro: sus taninos mantienen los pepinos firmes.',
      // FR: Range les concombres debout et serrés, avec l'ail écrasé et l'aneth entre eux.
      'Coloca los pepinos de pie y apretados, con el ajo aplastado y el eneldo entre ellos.',
      // FR: Couvre de saumure et pose un poids : **tout doit rester sous le liquide**, sinon ça moisit.
      'Cubre con salmuera y pon un peso: **todo debe quedar bajo el líquido**, o se enmohece.',
      // FR: Laisse 1 à 2 semaines vers 20 °C. Retire l'éventuelle mousse blanche en surface, c'est normal.
      'Deja de 1 a 2 semanas a unos 20 °C. Quita la posible espuma blanca de la superficie, es normal.',
      // FR: Quand ils sont vert olive et acidulés jusqu'au cœur, range-les au réfrigérateur.
      'Cuando estén verde oliva y ácidos hasta el centro, guárdalos en la nevera.',
    ],
  ),
  'concombre/Glaçons de concombre et menthe': RecipeText(
    // FR: Glaçons de concombre et menthe
    name: 'Cubitos de pepino y menta',
    // FR: Un concombre ne se congèle pas en tranches, mais mixé il fait des glaçons parfaits pour les gaspachos et l'eau fraîche.
    description: 'Un pepino no se congela en rodajas, pero triturado hace cubitos perfectos para los gazpachos y el agua fresca.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 kg de pepinos', // FR: 1 kg de concombres
      'el zumo de un limón', // FR: le jus d'un citron
      'unas diez hojas de menta', // FR: une dizaine de feuilles de menthe
      'cubiteras', // FR: des bacs à glaçons
    ],
    steps: <String>[
      // FR: Lave les concombres ; épluche-les une bande sur deux si la peau est épaisse.
      'Lava los pepinos; pélalos a franjas alternas si la piel es gruesa.',
      // FR: Coupe-les en tronçons et retire les graines à la cuillère si elles sont grosses.
      'Córtalos en trozos y quita las semillas con una cuchara si son grandes.',
      // FR: Mixe finement avec le citron et la menthe : le citron empêche le jus de **griser au froid**.
      'Tritura fino con el limón y la menta: el limón evita que el zumo **se ponga gris con el frío**.',
      // FR: Verse dans les bacs à glaçons et congèle jusqu'à ce qu'ils soient bien durs.
      'Vierte en las cubiteras y congela hasta que estén bien duros.',
      // FR: Démoule et garde les cubes en sac. Trois cubes dans un yaourt mixé, et voilà une soupe froide.
      'Desmolda y guarda los cubos en una bolsa. Tres cubos en un yogur triturado, y ya tienes una sopa fría.',
    ],
  ),
  'concombre/Tzatziki': RecipeText(
    // FR: Tzatziki
    name: 'Tzatziki',
    // FR: Concombre râpé, yaourt grec, ail et menthe — frais et franc.
    description: 'Pepino rallado, yogur griego, ajo y menta: fresco y franco.',
    ingredients: <String>[
      '1 pepino', // FR: 1 concombre
      '400 g de yogur griego', // FR: 400 g de yaourt grec
      '1 diente de ajo', // FR: 1 gousse d'ail
      'menta fresca', // FR: menthe fraîche
      '1 cucharada de aceite de oliva, sal', // FR: 1 cuillère à soupe d'huile d'olive, sel
    ],
    steps: <String>[
      // FR: Râpe le concombre avec sa peau si elle est fine.
      'Ralla el pepino con su piel si es fina.',
      // FR: Sale-le et laisse-le dégorger 15 minutes dans une passoire. C'est l'étape qu'on saute et qui donne un tzatziki liquide.
      'Sálalo y déjalo sudar 15 minutos en un colador. Es el paso que se salta y que da un tzatziki líquido.',
      // FR: Presse-le fort entre tes mains.
      'Exprímelo con fuerza entre las manos.',
      // FR: Mélange au yaourt avec l'ail écrasé, l'huile et la menthe ciselée.
      'Mézclalo con el yogur, el ajo aplastado, el aceite y la menta picada.',
      // FR: Au frais une heure avant de servir.
      'En frío una hora antes de servir.',
    ],
  ),
  'concombre/Soupe froide de concombre': RecipeText(
    // FR: Soupe froide de concombre
    name: 'Sopa fría de pepino',
    // FR: Mixée crue, servie glacée : l'entrée des jours de canicule.
    description: 'Triturada cruda, servida helada: el entrante de los días de ola de calor.',
    ingredients: <String>[
      '2 pepinos', // FR: 2 concombres
      '20 cl de queso fresco', // FR: 20 cl de fromage blanc
      '1 diente de ajo', // FR: 1 gousse d'ail
      'cebollino, menta', // FR: ciboulette, menthe
      'sal, pimienta, 1 chorrito de vinagre', // FR: sel, poivre, 1 trait de vinaigre
    ],
    steps: <String>[
      // FR: Pèle les concombres et retire les graines du centre.
      'Pela los pepinos y quita las semillas del centro.',
      // FR: Mixe avec le fromage blanc, l'ail, le vinaigre, sel et poivre.
      'Tritura con el queso fresco, el ajo, el vinagre, sal y pimienta.',
      // FR: Au réfrigérateur **2 heures** : tiède, cette soupe ne vaut rien.
      'En la nevera **2 horas**: tibia, esta sopa no vale nada.',
      // FR: Herbes ciselées au moment de servir.
      'Hierbas picadas en el momento de servir.',
    ],
  ),
  'concombre/Salade de concombre au yaourt': RecipeText(
    // FR: Salade de concombre au yaourt
    name: 'Ensalada de pepino con yogur',
    // FR: En rondelles fines, à peine habillées — on garde le croquant.
    description: 'En rodajas finas, apenas aliñadas: se conserva el crujiente.',
    ingredients: <String>[
      '1 pepino', // FR: 1 concombre
      '3 cucharadas de yogur', // FR: 3 cuillères à soupe de yaourt
      '1 chalota', // FR: 1 échalote
      'eneldo o cebollino', // FR: aneth ou ciboulette
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Coupe le concombre en rondelles très fines, à l'économe si tu veux.
      'Corta el pepino en rodajas muy finas, con el pelador si quieres.',
      // FR: Sale légèrement et laisse 10 minutes, puis égoutte sans presser : on veut qu'il reste croquant.
      'Sala ligeramente y deja 10 minutos, luego escurre sin apretar: queremos que siga crujiente.',
      // FR: Mélange yaourt, échalote hachée, herbes, poivre.
      'Mezcla el yogur, la chalota picada, las hierbas y la pimienta.',
      // FR: Assemble juste avant de passer à table.
      'Monta justo antes de ir a la mesa.',
    ],
  ),

  // ─────────── corete (6 recettes) ───────────
  'corete/Corète hachée crue en portions': RecipeText(
    // FR: Corète hachée crue en portions
    name: 'Yute picado crudo en raciones',
    // FR: Hachée fin et congelée crue, elle garde toute sa bave : tu la jettes directement dans la sauce.
    description: 'Picado fino y congelado crudo, conserva todo su mucílago: lo echas directamente a la salsa.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 kg de hojas de yute', // FR: 1 kg de feuilles de corète
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Effeuille les tiges et garde seulement les feuilles tendres.
      'Deshoja los tallos y quédate solo con las hojas tiernas.',
      // FR: Lave-les dans plusieurs eaux, puis **sèche-les bien** : mouillées, elles collent en bloc.
      'Lávalas en varias aguas y luego **sécalas bien**: mojadas, se pegan en bloque.',
      // FR: Hache-les fin, au couteau ou au hachoir, comme pour la sauce.
      'Pícalas fino, con cuchillo o con picadora, como para la salsa.',
      // FR: Répartis en sacs à plat, une portion par sac. Mets-la gelée dans le bouillon chaud et fouette.
      'Reparte en bolsas en plano, una ración por bolsa. Échala congelada al caldo caliente y bate.',
    ],
  ),
  'corete/Feuilles de corète séchées': RecipeText(
    // FR: Feuilles de corète séchées
    name: 'Hojas de yute secas',
    // FR: Séchée à l'ombre, la corète se garde des mois et retrouve sa texture filante dès qu'elle touche l'eau chaude.
    description: 'Seco a la sombra, el yute se conserva meses y recupera su textura viscosa en cuanto toca el agua caliente.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegidas de la luz',
    ingredients: <String>[
      'tallos de yute con muchas hojas', // FR: des tiges de corète feuillues
      'rejillas o una sábana limpia', // FR: des claies ou un drap propre
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Effeuille les tiges et écarte les feuilles abîmées.
      'Deshoja los tallos y aparta las hojas estropeadas.',
      // FR: Rince rapidement et étale sur un torchon pour égoutter.
      'Aclara rápidamente y extiende sobre un paño para escurrir.',
      // FR: Étale en couche mince à l'ombre, dans un endroit aéré, 2 à 3 jours en remuant chaque jour.
      'Extiende en capa fina a la sombra, en un lugar ventilado, 2 o 3 días, removiendo cada día.',
      // FR: Quand elles s'émiettent sous les doigts, c'est sec. Molles, elles noircissent en bocal.
      'Cuando se desmenuzan entre los dedos, están secas. Blandas, se ennegrecen en el tarro.',
      // FR: Mets en bocaux hermétiques. Pour cuisiner, émiette-les dans le bouillon frémissant et fouette.
      'Guárdalas en tarros herméticos. Para cocinar, desmenúzalas en el caldo a fuego lento y bate.',
    ],
  ),
  'corete/Corète blanchie congelée': RecipeText(
    // FR: Corète blanchie congelée
    name: 'Yute escaldado congelado',
    // FR: Une minute de blanchiment, et la corète garde un vert vif pour les sauces de l'hiver.
    description: 'Un minuto de escaldado, y el yute conserva un verde vivo para las salsas del invierno.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 kg de hojas de yute', // FR: 1 kg de feuilles de corète
      '1 bol grande de agua con cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Effeuille et lave les feuilles dans plusieurs eaux.
      'Deshoja y lava las hojas en varias aguas.',
      // FR: Plonge-les dans une grande eau bouillante, à gros bouillons.
      'Sumérgelas en abundante agua hirviendo, a borbotones.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée pour fixer la couleur.
      'Escurre y sumerge enseguida en agua con hielo para fijar el color.',
      // FR: Égoutte et presse doucement : elles sont gluantes, pas besoin d'essorer à fond.
      'Escurre y prensa suavemente: son viscosas, no hace falta escurrir a fondo.',
      // FR: Répartis en portions dans des sacs à plat et congèle.
      'Reparte en raciones en bolsas en plano y congela.',
    ],
  ),
  'corete/Corète à l\'arachide': RecipeText(
    // FR: Corète à l'arachide
    name: 'Yute con cacahuete',
    // FR: La sauce longue, liée à la pâte d'arachide.
    description: 'La salsa larga, ligada con pasta de cacahuete.',
  ),
  'corete/Sauce adémè': RecipeText(
    // FR: Sauce adémè
    name: 'Salsa adémè',
    // FR: La sauce gluante et savoureuse du Togo et du Bénin, à base de feuilles de corète.
    description: 'La salsa viscosa y sabrosa de Togo y Benín, a base de hojas de yute.',
  ),
  'corete/Ewédu': RecipeText(
    // FR: Ewédu
    name: 'Ewédu',
    // FR: La soupe de corète yoruba, mixée bien lisse, servie avec un ragoût de tomate.
    description: 'La sopa de yute yoruba, triturada hasta quedar bien lisa, servida con un guiso de tomate.',
  ),

  // ─────────── coriandre (6 recettes) ───────────
  'coriandre/Glaçons de coriandre à l\'huile': RecipeText(
    // FR: Glaçons de coriandre à l'huile
    name: 'Cubitos de cilantro en aceite',
    // FR: La coriandre séchée n'a plus de goût : dans l'huile, au congélateur, elle reste vive.
    description: 'El cilantro seco ya no sabe a nada: en aceite, en el congelador, se mantiene vivo.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 manojos grandes de cilantro', // FR: 2 gros bouquets de coriandre
      '10 cl de aceite neutro o de oliva', // FR: 10 cl d'huile neutre ou d'olive
      'una cubitera', // FR: un bac à glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave la coriandre dans plusieurs eaux, le sable reste collé au pied.
      'Lava el cilantro en varias aguas: la arena se queda pegada al pie.',
      // FR: Essore-la puis sèche-la sur un torchon. Garde les tiges tendres : elles ont autant de goût.
      'Centrifúgalo y sécalo sobre un paño. Guarda los tallos tiernos: tienen tanto sabor como las hojas.',
      // FR: Hache-la grossièrement au couteau.
      'Pícalo toscamente con cuchillo.',
      // FR: Remplis le bac à glaçons aux trois quarts de coriandre, puis couvre **juste à ras** d'huile.
      'Llena la cubitera hasta tres cuartos de cilantro y cubre **justo a ras** con aceite.',
      // FR: Congèle jusqu'à ce que les cubes soient durs, démoule et garde-les en sac.
      'Congela hasta que los cubos estén duros, desmolda y guárdalos en una bolsa.',
      // FR: Jette un cube **directement dans la poêle** ou le curry en fin de cuisson. Ne le laisse pas dégeler à température ambiante.
      'Echa un cubo **directamente a la sartén** o al curry al final de la cocción. No lo dejes descongelar a temperatura ambiente.',
    ],
  ),
  'coriandre/Pâte verte coriandre-gingembre': RecipeText(
    // FR: Pâte verte coriandre-gingembre
    name: 'Pasta verde de cilantro y jengibre',
    // FR: Une base toute prête pour les currys, soupes et marinades, en portions dans le congélateur.
    description: 'Una base lista para currys, sopas y adobos, en raciones en el congelador.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '200 g de cilantro con los tallos', // FR: 200 g de coriandre avec les tiges
      '40 g de jengibre fresco', // FR: 40 g de gingembre frais
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '1 guindilla verde', // FR: 1 piment vert
      'el zumo de una lima', // FR: le jus d'un citron vert
      '8 cl de aceite neutro, 1 cucharadita de sal', // FR: 8 cl d'huile neutre, 1 cuillère à café de sel
    ],
    steps: <String>[
      // FR: Lave et sèche la coriandre, coupe-la en tronçons, tiges comprises.
      'Lava y seca el cilantro, córtalo en trozos, tallos incluidos.',
      // FR: Épluche le gingembre à la cuillère et l'ail. Épépine le piment si tu veux une pâte douce.
      'Pela el jengibre con una cuchara y el ajo. Quita las semillas de la guindilla si quieres una pasta suave.',
      // FR: Mixe tout avec le citron vert, l'huile et le sel jusqu'à une pâte lisse. Racle les parois deux fois.
      'Tritura todo con la lima, el aceite y la sal hasta obtener una pasta lisa. Rasca las paredes dos veces.',
      // FR: Remplis un bac à glaçons : un cube, c'est une poêlée pour quatre.
      'Llena una cubitera: un cubo da para un salteado para cuatro.',
      // FR: Congèle jusqu'à ce que ce soit dur, puis démoule en sac **bien fermé**, sinon tout le congélateur sent la coriandre.
      'Congela hasta que esté duro y luego desmolda en una bolsa **bien cerrada**, o todo el congelador huele a cilantro.',
      // FR: À l'usage, fais revenir le cube encore gelé 1 minute dans un peu d'huile avant d'ajouter le reste.
      'Al usarlo, rehoga el cubo aún congelado 1 minuto en un poco de aceite antes de añadir el resto.',
    ],
  ),
  'coriandre/Graines de coriandre séchées': RecipeText(
    // FR: Graines de coriandre séchées
    name: 'Semillas de cilantro secas',
    // FR: Laisse quelques pieds monter en graines : tu récoltes une épice citronnée gratuite pour un an.
    description: 'Deja que algunas plantas suban a semilla: cosechas una especia cítrica gratis para un año.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegidas de la luz',
    ingredients: <String>[
      'tallos de cilantro espigados', // FR: des tiges de coriandre montées en graines
      'una bolsa grande de papel', // FR: un grand sac en papier
      'cordel', // FR: de la ficelle
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges quand les graines **virent au beige**, avant qu'elles ne tombent toutes seules.
      'Corta los tallos cuando las semillas **viren a beige**, antes de que caigan solas.',
      // FR: Fais de petites bottes de cinq ou six tiges et lie-les à la ficelle.
      'Haz pequeños manojos de cinco o seis tallos y átalos con el cordel.',
      // FR: Suspends-les tête en bas dans un sac en papier, dans un endroit sec et aéré, deux semaines. Le sac recueille ce qui tombe.
      'Cuélgalos cabeza abajo dentro de una bolsa de papel, en un lugar seco y ventilado, dos semanas. La bolsa recoge lo que cae.',
      // FR: Secoue et frotte les ombelles dans le sac : les graines se détachent seules.
      'Sacude y frota las umbelas dentro de la bolsa: las semillas se sueltan solas.',
      // FR: Souffle doucement dessus au-dessus d'un saladier pour chasser les débris, ou passe-les au tamis.
      'Sopla suavemente sobre ellas encima de un bol para quitar los restos, o pásalas por el tamiz.',
      // FR: Mets-les en bocal **entières**, et mouds-les ou écrase-les seulement au moment de cuisiner.
      'Guárdalas en el tarro **enteras**, y muélelas o májalas solo en el momento de cocinar.',
    ],
  ),
  'coriandre/Chermoula': RecipeText(
    // FR: Chermoula
    name: 'Chermoula',
    // FR: Coriandre, cumin, paprika, citron — la marinade du poisson.
    description: 'Cilantro, comino, pimentón, limón: el adobo del pescado.',
  ),
  'coriandre/Guacamole à la coriandre': RecipeText(
    // FR: Guacamole à la coriandre
    name: 'Guacamole con cilantro',
    // FR: Écrasé à la fourchette, jamais mixé.
    description: 'Machacado con tenedor, nunca triturado.',
  ),
  'coriandre/Salade thaïe à la coriandre': RecipeText(
    // FR: Salade thaïe à la coriandre
    name: 'Ensalada tailandesa con cilantro',
    // FR: Avec de la menthe, du citron vert et du piment.
    description: 'Con menta, lima y guindilla.',
  ),

  // ─────────── cornichon (6 recettes) ───────────
  'cornichon/Cornichons à l\'ancienne au vinaigre blanc': RecipeText(
    // FR: Cornichons à l'ancienne au vinaigre blanc
    name: 'Pepinillos a la antigua en vinagre blanco',
    // FR: Dégorgés une nuit au gros sel puis couverts de vinaigre pur : la méthode des grands-mères, qui tient toute l'année.
    description: 'Sudados una noche con sal gruesa y cubiertos de vinagre puro: el método de las abuelas, que aguanta todo el año.',
    // FR: 1 an au placard, au réfrigérateur une fois ouvert
    keeps: '1 año en la despensa, en la nevera una vez abiertos',
    ingredients: <String>[
      '1 kg de pepinillos firmes, cogidos pequeños', // FR: 1 kg de cornichons fermes, cueillis petits
      '100 g de sal gruesa', // FR: 100 g de gros sel
      '1 litro de vinagre blanco al 8 %', // FR: 1 litre de vinaigre blanc à 8 %
      '10 cebollitas', // FR: 10 petits oignons grelots
      'unas ramas de estragón', // FR: quelques branches d'estragon
      '1 cucharada de granos de pimienta', // FR: 1 cuillère à soupe de grains de poivre
    ],
    steps: <String>[
      // FR: Brosse les cornichons sous l'eau pour retirer les petits picots et la fleur séchée. Coupe le bout de la queue.
      'Cepilla los pepinillos bajo el agua para quitar las pequeñas púas y la flor seca. Corta la punta del rabito.',
      // FR: Roule-les dans le gros sel et laisse-les dégorger une nuit : c'est ce qui les rend **croquants**.
      'Rebózalos en la sal gruesa y déjalos sudar una noche: eso es lo que los hace **crujientes**.',
      // FR: Rince-les à l'eau vinaigrée pour retirer le sel, puis sèche-les un par un dans un torchon.
      'Acláralos con agua avinagrada para quitar la sal y sécalos uno a uno con un paño.',
      // FR: Tasse-les dans des bocaux ébouillantés avec les oignons épluchés, l'estragon et le poivre.
      'Apelmázalos en tarros escaldados con las cebollitas peladas, el estragón y la pimienta.',
      // FR: Verse le vinaigre froid jusqu'à **couvrir largement**, 1 cm au-dessus des cornichons, et ferme.
      'Vierte el vinagre frío hasta **cubrir con generosidad**, 1 cm por encima de los pepinillos, y cierra.',
      // FR: Attends au moins 4 semaines avant d'ouvrir, au frais et à l'abri de la lumière. S'il baisse, recomplète de vinaigre.
      'Espera al menos 4 semanas antes de abrir, en un lugar fresco y protegido de la luz. Si baja, completa con vinagre.',
    ],
  ),
  'cornichon/Cornichons fermentés à la russe': RecipeText(
    // FR: Cornichons fermentés à la russe
    name: 'Pepinillos fermentados a la rusa',
    // FR: Sans vinaigre, juste une saumure : des cornichons aigres et parfumés comme en Europe de l'Est.
    description: 'Sin vinagre, solo una salmuera: pepinillos agrios y aromáticos como en Europa del Este.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 meses en la nevera',
    ingredients: <String>[
      '1,5 kg de pepinillos firmes', // FR: 1,5 kg de cornichons fermes
      '1,5 litros de agua sin cloro', // FR: 1,5 litre d'eau non chlorée
      '45 g de sal sin yodo', // FR: 45 g de sel non iodé
      '4 dientes de ajo', // FR: 4 gousses d'ail
      '2 umbelas de eneldo', // FR: 2 ombelles d'aneth
      '2 hojas de parra o de laurel', // FR: 2 feuilles de vigne ou de laurier
    ],
    steps: <String>[
      // FR: Prépare la saumure : **30 g de sel par litre d'eau**, soit 45 g pour 1,5 litre.
      'Prepara la salmuera: **30 g de sal por litro de agua**, es decir, 45 g para 1,5 litros.',
      // FR: Brosse les cornichons et coupe un millimètre du bout de la fleur : il contient une enzyme qui ramollit.
      'Cepilla los pepinillos y corta un milímetro de la punta de la flor: contiene una enzima que los ablanda.',
      // FR: Tasse-les debout dans le bocal avec l'ail écrasé, l'aneth et les feuilles de vigne, qui les gardent fermes.
      'Colócalos de pie en el tarro con el ajo aplastado, el eneldo y las hojas de parra, que los mantienen firmes.',
      // FR: Verse la saumure et pose un poids : tout doit rester **sous la saumure**, à 3 cm du bord.
      'Vierte la salmuera y pon un peso: todo debe quedar **bajo la salmuera**, a 3 cm del borde.',
      // FR: Laisse fermenter 10 jours à 18–22 °C, couvercle posé sans serrer. La saumure se trouble, c'est normal.
      'Deja fermentar 10 días a 18–22 °C, con la tapa puesta sin apretar. La salmuera se enturbia, es normal.',
      // FR: Quand ils sont aigres à cœur, ferme et range au réfrigérateur. Un cornichon mou ou visqueux, jette-le.
      'Cuando estén agrios hasta el centro, cierra y guarda en la nevera. Un pepinillo blando o viscoso, tíralo.',
    ],
  ),
  'cornichon/Rondelles de cornichons aigres-douces': RecipeText(
    // FR: Rondelles de cornichons aigres-douces
    name: 'Rodajas de pepinillo agridulces',
    // FR: Pour les cornichons qui ont trop grossi : en rondelles sucrées-acides, ils font la garniture idéale des burgers.
    description: 'Para los pepinillos que han crecido demasiado: en rodajas dulces y ácidas, son la guarnición ideal de las hamburguesas.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '800 g de pepinillos grandes', // FR: 800 g de gros cornichons
      '1 cebolla', // FR: 1 oignon
      '30 cl de vinagre de sidra al 6 %', // FR: 30 cl de vinaigre de cidre à 6 %
      '30 cl de agua', // FR: 30 cl d'eau
      '80 g de azúcar', // FR: 80 g de sucre
      '1 cucharada de sal, 1 cucharadita de semillas de mostaza', // FR: 1 cuillère à soupe de sel, 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Lave les cornichons et coupe les deux bouts.
      'Lava los pepinillos y corta los dos extremos.',
      // FR: Tranche-les en rondelles de 5 mm et émince l'oignon finement.
      'Córtalos en rodajas de 5 mm y la cebolla en láminas finas.',
      // FR: Tasse rondelles et oignon dans des bocaux propres avec la moutarde.
      'Apelmaza las rodajas y la cebolla en tarros limpios con la mostaza.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Lleva a ebullición el vinagre, el agua, el azúcar y la sal.',
      // FR: Verse bouillant jusqu'à **couvrir entièrement**, ferme et laisse refroidir, puis range au réfrigérateur.
      'Vierte hirviendo hasta **cubrir por completo**, cierra y deja enfriar, luego guarda en la nevera.',
    ],
  ),
  'cornichon/Cornichons au vinaigre': RecipeText(
    // FR: Cornichons au vinaigre
    name: 'Pepinillos en vinagre',
    // FR: Brossés au gros sel, séchés une nuit, couverts de vinaigre bouillant.
    description: 'Cepillados con sal gruesa, secados una noche, cubiertos de vinagre hirviendo.',
  ),
  'cornichon/Cornichons à l\'aneth': RecipeText(
    // FR: Cornichons à l'aneth
    name: 'Pepinillos al eneldo',
    // FR: À la lacto-fermentation, en saumure : croquants et vivants.
    description: 'Por lactofermentación, en salmuera: crujientes y vivos.',
  ),
  'cornichon/Sauce tartare': RecipeText(
    // FR: Sauce tartare
    name: 'Salsa tártara',
    // FR: Hachés dans la mayonnaise avec câpres et estragon.
    description: 'Picados en la mayonesa con alcaparras y estragón.',
  ),

  // ─────────── courge_butternut (6 recettes) ───────────
  'courge_butternut/Butternut rôtie en cubes à congeler': RecipeText(
    // FR: Butternut rôtie en cubes à congeler
    name: 'Calabaza cacahuete asada en cubos para congelar',
    // FR: Rôtie avant de geler, elle garde son goût de noisette caramélisée et ressort en dix minutes au four.
    description: 'Asada antes de congelar, conserva su sabor a avellana caramelizada y sale en diez minutos del horno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 calabazas cacahuete', // FR: 2 courges butternut
      '3 cucharadas de aceite de oliva', // FR: 3 cuillères à soupe d'huile d'olive
      '1 cucharadita de sal', // FR: 1 cuillère à café de sel
      'papel de horno', // FR: du papier cuisson
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe le haut et le bas, épluche à l'économe, ouvre en deux et retire les graines.
      'Corta la parte de arriba y la de abajo, pela con el pelador, abre por la mitad y quita las semillas.',
      // FR: Coupe la chair en cubes de 2 cm.
      'Corta la pulpa en cubos de 2 cm.',
      // FR: Mélange-les à l'huile et au sel, puis étale-les sur des plaques couvertes de papier, sans les entasser.
      'Mézclalos con el aceite y la sal, y extiéndelos sobre bandejas cubiertas con papel, sin amontonarlos.',
      // FR: Rôtis 25 minutes à 200 °C, jusqu'à ce que les bords dorent mais que les cubes **tiennent encore**.
      'Asa 25 minutos a 200 °C, hasta que los bordes se doren pero los cubos **aún aguanten**.',
      // FR: Laisse refroidir complètement sur la plaque.
      'Deja enfriar por completo sobre la bandeja.',
      // FR: Congèle la plaque 2 heures, puis verse en sac. Pour risottos, salades tièdes et veloutés minute.
      'Congela la bandeja 2 horas y luego pásalos a una bolsa. Para risottos, ensaladas templadas y cremas al instante.',
    ],
  ),
  'courge_butternut/Butternut râpée crue au congélateur': RecipeText(
    // FR: Butternut râpée crue au congélateur
    name: 'Calabaza cacahuete rallada cruda en el congelador',
    // FR: Râpée crue en sachets, elle va directement dans les galettes, les cakes et les gratins, sans éplucher une courge un soir de semaine.
    description: 'Rallada cruda en bolsitas, va directamente a las tortitas, los bizcochos y los gratinados, sin pelar una calabaza una noche entre semana.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 calabaza cacahuete grande', // FR: 1 grosse courge butternut
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche la courge à l'économe, coupe-la en deux et retire les graines.
      'Pela la calabaza con el pelador, pártela por la mitad y quita las semillas.',
      // FR: Coupe-la en gros morceaux qui tiennent en main, puis râpe-les côté gros trous ou au robot.
      'Córtala en trozos grandes que se sujeten con la mano y rállalos por el lado de los agujeros grandes o con el robot.',
      // FR: Répartis la râpée en sachets de 250 g, aplatis-les en galettes fines pour qu'ils gèlent et dégèlent vite.
      'Reparte lo rallado en bolsitas de 250 g y aplánalas en tortitas finas para que se congelen y descongelen rápido.',
      // FR: Chasse l'air, ferme et congèle à plat. Note la date et le poids : **utilise-la encore gelée**, elle rend moins d'eau.
      'Saca el aire, cierra y congela en plano. Anota la fecha y el peso: **úsala aún congelada**, suelta menos agua.',
    ],
  ),
  'courge_butternut/Chips de butternut séchées': RecipeText(
    // FR: Chips de butternut séchées
    name: 'Chips de calabaza cacahuete secas',
    // FR: Tranchées très fin et séchées doucement, elles se croquent comme des chips et se gardent des mois.
    description: 'Cortadas muy finas y secadas con suavidad, se comen crujientes como patatas fritas y se guardan meses.',
    // FR: 3 mois au sec, en bocal hermétique
    keeps: '3 meses en seco, en tarro hermético',
    ingredients: <String>[
      '1 calabaza cacahuete', // FR: 1 courge butternut
      '1 cucharada de aceite de oliva', // FR: 1 cuillère à soupe d'huile d'olive
      '1 cucharadita de sal fina', // FR: 1 cuillère à café de sel fin
      'papel de horno', // FR: du papier cuisson
    ],
    steps: <String>[
      // FR: Épluche le col de la courge (la partie pleine, sans graines) et tranche-le à la mandoline, **2 mm** d'épaisseur.
      'Pela el cuello de la calabaza (la parte maciza, sin semillas) y córtalo con la mandolina, a **2 mm** de grosor.',
      // FR: Mélange les tranches avec l'huile et le sel, juste de quoi les faire briller.
      'Mezcla las rodajas con el aceite y la sal, solo lo justo para que brillen.',
      // FR: Étale-les en une seule couche sur des plaques couvertes de papier, sans qu'elles se chevauchent.
      'Extiéndelas en una sola capa sobre bandejas cubiertas con papel, sin que se solapen.',
      // FR: Sèche au four à **90 °C**, porte entrouverte, en les retournant à mi-temps.
      'Seca en el horno a **90 °C**, con la puerta entreabierta, dándoles la vuelta a mitad de tiempo.',
      // FR: Elles sont prêtes quand elles cassent net. Les molles du milieu repassent une demi-heure.
      'Están listas cuando se rompen limpiamente. Las blandas del centro vuelven media hora.',
      // FR: Laisse-les refroidir complètement sur la plaque avant de les mettre en bocal, sinon la vapeur les ramollit.
      'Déjalas enfriar por completo sobre la bandeja antes de ponerlas en el tarro, o el vapor las ablanda.',
    ],
  ),
  'courge_butternut/Butternut rôtie entière': RecipeText(
    // FR: Butternut rôtie entière
    name: 'Calabaza cacahuete asada entera',
    // FR: Coupée en deux, côté chair sur la plaque, une heure.
    description: 'Partida por la mitad, con la pulpa hacia la bandeja, una hora.',
  ),
  'courge_butternut/Risotto à la butternut': RecipeText(
    // FR: Risotto à la butternut
    name: 'Risotto de calabaza cacahuete',
    // FR: Moitié en cubes, moitié en purée dans le bouillon.
    description: 'Mitad en cubos, mitad en puré en el caldo.',
  ),
  'courge_butternut/Velouté de butternut': RecipeText(
    // FR: Velouté de butternut
    name: 'Crema de calabaza cacahuete',
    // FR: Une soupe soyeuse au petit goût de noisette, douce comme un câlin.
    description: 'Una sopa sedosa con un toque a avellana, suave como un abrazo.',
  ),


  // ─────────── courgette (6 recettes) ───────────
  'courgette/Courgettes râpées en portions': RecipeText(
    // FR: Courgettes râpées en portions
    name: 'Calabacín rallado en porciones',
    // FR: Râpées, blanchies une minute et pressées : la réponse aux courgettes géantes, prête pour les cakes, galettes et soupes.
    description: 'Rallado, escaldado un minuto y exprimido: la respuesta a los calabacines gigantes, listo para bizcochos salados, tortitas y sopas.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de calabacines', // FR: 2 kg de courgettes
      'sal gruesa', // FR: gros sel
      'un bol grande de agua con hielo', // FR: un grand saladier d'eau glacée
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les extrémités et, sur les très grosses, retire le cœur plein de graines à la cuillère.
      'Corta los extremos y, en los muy grandes, quita con una cuchara el corazón lleno de semillas.',
      // FR: Râpe-les avec la peau, côté gros trous.
      'Rállalos con piel, por el lado de los agujeros grandes.',
      // FR: Plonge la râpée dans l'eau bouillante salée, dans un panier ou une passoire, et compte **1 minute**.
      'Echa el rallado en agua hirviendo con sal, en una cesta o un colador, y cuenta **1 minuto**.',
      // FR: Plonge-la aussitôt dans l'eau glacée, puis égoutte.
      'Pásalo enseguida al agua con hielo y escurre.',
      // FR: Presse-la par poignées dans un torchon, **vraiment fort** : une courgette, c'est surtout de l'eau.
      'Exprímelo por puñados en un paño, **de verdad con fuerza**: un calabacín es sobre todo agua.',
      // FR: Mets en sacs plats de 250 g, chasse l'air et congèle. Note la date et le poids sur le sac.
      'Ponlo en bolsas planas de 250 g, saca el aire y congela. Anota la fecha y el peso en la bolsa.',
    ],
  ),
  'courgette/Pickles de courgettes au curcuma': RecipeText(
    // FR: Pickles de courgettes au curcuma
    name: 'Pickles de calabacín con cúrcuma',
    // FR: Sucrés-acidulés et jaune soleil, ces « bread and butter » américains font disparaître une brouette de courgettes.
    description: 'Agridulces y amarillos como el sol, estos «bread and butter» americanos hacen desaparecer una carretilla de calabacines.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '1,5 kg de calabacines', // FR: 1,5 kg de courgettes
      '2 cebollas', // FR: 2 oignons
      '40 g de sal gruesa', // FR: 40 g de gros sel
      '60 cl de vinagre de sidra al 6 %', // FR: 60 cl de vinaigre de cidre à 6 %
      '40 cl de agua y 200 g de azúcar', // FR: 40 cl d'eau et 200 g de sucre
      '1 cucharadita de cúrcuma y 2 de semillas de mostaza', // FR: 1 cuillère à café de curcuma et 2 de graines de moutarde
    ],
    steps: <String>[
      // FR: Coupe les courgettes en rondelles de 5 mm et les oignons en fines lamelles.
      'Corta los calabacines en rodajas de 5 mm y las cebollas en láminas finas.',
      // FR: Mélange-les au gros sel, couvre de glaçons et laisse dégorger une heure.
      'Mézclalos con la sal gruesa, cúbrelos de cubitos de hielo y déjalos soltar agua durante una hora.',
      // FR: Rince deux fois à l'eau froide et égoutte bien, en pressant doucement.
      'Enjuaga dos veces con agua fría y escurre bien, apretando con suavidad.',
      // FR: Porte à ébullition vinaigre, eau, sucre, curcuma et moutarde, puis jette les légumes dedans pour **1 minute** seulement.
      'Lleva a ebullición el vinagre, el agua, el azúcar, la cúrcuma y la mostaza, y echa dentro las verduras durante solo **1 minuto**.',
      // FR: Remplis des bocaux propres jusqu'à 2 cm du bord avec les légumes.
      'Llena tarros limpios con las verduras hasta 2 cm del borde.',
      // FR: Verse le liquide chaud pour **tout recouvrir**, ferme, laisse refroidir et range au réfrigérateur. Bons dès le lendemain.
      'Vierte el líquido caliente para **cubrirlo todo**, cierra, deja enfriar y guarda en la nevera. Buenos desde el día siguiente.',
    ],
  ),
  'courgette/Courgettes grillées à l\'huile et au citron': RecipeText(
    // FR: Courgettes grillées à l'huile et au citron
    name: 'Calabacines a la plancha en aceite y limón',
    // FR: Des lamelles grillées marinées au citron, à piocher pour les tartines et les salades de pâtes.
    description: 'Láminas a la plancha maceradas con limón, para picotear en tostadas y en ensaladas de pasta.',
    // FR: 2 semaines au réfrigérateur
    keeps: '2 semanas en la nevera',
    ingredients: <String>[
      '1,5 kg de calabacines', // FR: 1,5 kg de courgettes
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      '1 cucharadita de sal', // FR: 1 cuillère à café de sel
      '40 cl de aceite de oliva', // FR: 40 cl d'huile d'olive
      '1 cucharadita de tomillo seco', // FR: 1 cuillère à café de thym séché
    ],
    steps: <String>[
      // FR: Lave les courgettes et coupe-les en lamelles de 5 mm dans la longueur.
      'Lava los calabacines y córtalos en láminas de 5 mm a lo largo.',
      // FR: Grille-les à sec sur une poêle-gril bien chaude, 2 à 3 minutes par face, jusqu'à de belles marques.
      'Hazlas en seco en una sartén grill bien caliente, de 2 a 3 minutos por cada lado, hasta que queden bien marcadas.',
      // FR: Arrose-les encore chaudes de citron et sale-les : l'acidité aide à les garder.
      'Rocíalas aún calientes con limón y sálalas: la acidez ayuda a conservarlas.',
      // FR: Range-les à plat dans des bocaux propres avec le thym **séché**, jamais d'herbes fraîches ni d'ail cru.
      'Colócalas planas en tarros limpios con el tomillo **seco**, nunca hierbas frescas ni ajo crudo.',
      // FR: Couvre d'huile d'olive jusqu'à 1 cm au-dessus, tasse pour chasser l'air, ferme et mets au réfrigérateur.
      'Cubre con aceite de oliva hasta 1 cm por encima, presiona para sacar el aire, cierra y guarda en la nevera.',
      // FR: Sors-les 20 minutes avant de manger pour que l'huile redevienne liquide. Toujours une fourchette propre.
      'Sácalas 20 minutos antes de comer para que el aceite vuelva a estar líquido. Siempre con un tenedor limpio.',
    ],
  ),
  'courgette/Beignets de fleurs de courgette': RecipeText(
    // FR: Beignets de fleurs de courgette
    name: 'Buñuelos de flores de calabacín',
    // FR: Les fleurs mâles, en pâte légère, deux minutes dans l'huile.
    description: 'Las flores macho, en una masa ligera, dos minutos en el aceite.',
    ingredients: <String>[
      '12 flores de calabacín macho', // FR: 12 fleurs de courgette mâles
      '150 g de harina', // FR: 150 g de farine
      '20 cl de agua helada o de cerveza', // FR: 20 cl d'eau glacée ou de bière
      '1 pizca de sal', // FR: 1 pincée de sel
      'aceite para freír', // FR: huile de friture
    ],
    steps: <String>[
      // FR: Cueille les fleurs mâles le matin, celles au bout d'une tige fine — les femelles portent la courgette.
      'Corta las flores macho por la mañana, las que están al final de un tallo fino: las hembras llevan el calabacín.',
      // FR: Ouvre-les, retire le pistil, secoue-les sans les laver si elles sont propres.
      'Ábrelas, quita el pistilo y sacúdelas sin lavarlas si están limpias.',
      // FR: Mélange farine, eau glacée et sel. La pâte doit napper, pas coller.
      'Mezcla la harina, el agua helada y la sal. La masa debe cubrir la flor, no quedar pegajosa.',
      // FR: Chauffe l'huile à 180 °C.
      'Calienta el aceite a 180 °C.',
      // FR: Trempe chaque fleur, plonge-la 2 minutes, retourne à mi-cuisson.
      'Reboza cada flor, sumérgela 2 minutos y dale la vuelta a mitad de cocción.',
      // FR: Égoutte sur du papier, sale tout de suite, mange tout de suite.
      'Escurre sobre papel, sala enseguida y cómelas enseguida.',
    ],
  ),
  'courgette/Courgettes farcies': RecipeText(
    // FR: Courgettes farcies
    name: 'Calabacines rellenos',
    // FR: Tes courgettes garnies de riz et de viande hachée, gratinées au four.
    description: 'Tus calabacines rellenos de arroz y carne picada, gratinados al horno.',
    ingredients: <String>[
      '4 calabacines redondos o medianos', // FR: 4 courgettes rondes ou moyennes
      '300 g de carne picada', // FR: 300 g de viande hachée
      '100 g de arroz', // FR: 100 g de riz
      '1 cebolla, 1 diente de ajo', // FR: 1 oignon, 1 gousse d'ail
      '1 huevo, 50 g de parmesano', // FR: 1 oeuf, 50 g de parmesan
      'sal, pimienta, hierbas', // FR: sel, poivre, herbes
    ],
    steps: <String>[
      // FR: Préchauffe le four à 190 °C.
      'Precalienta el horno a 190 °C.',
      // FR: Coupe les courgettes en deux, évide-les à la cuillère. Garde la chair.
      'Corta los calabacines por la mitad y vacíalos con una cuchara. Guarda la pulpa.',
      // FR: Cuis le riz 10 minutes, il finira au four.
      'Cuece el arroz 10 minutos, terminará de hacerse en el horno.',
      // FR: Fais revenir oignon, ail et la chair hachée, puis la viande.
      'Sofríe la cebolla, el ajo y la pulpa picada, y luego añade la carne.',
      // FR: Hors du feu, mélange avec le riz, l'oeuf, le parmesan, sel et poivre.
      'Fuera del fuego, mézclalo con el arroz, el huevo, el parmesano, sal y pimienta.',
      // FR: Garnis les demi-courgettes, tasse bien.
      'Rellena las mitades de calabacín, apretando bien.',
      // FR: Au four 40 minutes, à couvert les 20 premières.
      'Al horno 40 minutos, tapado los primeros 20.',
    ],
  ),
  'courgette/Gratin de courgettes': RecipeText(
    // FR: Gratin de courgettes
    name: 'Gratinado de calabacín',
    // FR: Des tranches fondantes sous une croûte dorée, le plat familial par excellence.
    description: 'Rodajas melosas bajo una costra dorada, el plato familiar por excelencia.',
    ingredients: <String>[
      '1 kg de calabacines', // FR: 1 kg de courgettes
      '20 cl de nata', // FR: 20 cl de crème
      '2 huevos', // FR: 2 oeufs
      '100 g de gruyer rallado', // FR: 100 g de gruyère râpé
      '1 diente de ajo, sal, pimienta, nuez moscada', // FR: 1 gousse d'ail, sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Coupe les courgettes en rondelles de 5 mm, sans les peler.
      'Corta los calabacines en rodajas de 5 mm, sin pelarlos.',
      // FR: Sale-les et laisse-les dégorger 20 minutes : c'est ce qui évite le gratin à l'eau.
      'Sálalos y déjalos soltar agua 20 minutos: así evitas un gratinado aguado.',
      // FR: Presse-les dans un torchon, puis fais-les suer 10 minutes à la poêle.
      'Exprímelos en un paño y luego rehógalos 10 minutos en la sartén.',
      // FR: Bats crème, oeufs, muscade, l'ail écrasé, sel et poivre.
      'Bate la nata, los huevos, la nuez moscada, el ajo machacado, sal y pimienta.',
      // FR: Dans le plat : courgettes, appareil, fromage par-dessus.
      'En la fuente: los calabacines, la mezcla y el queso por encima.',
      // FR: Four à 180 °C, 30 minutes jusqu'à la croûte dorée.
      'Horno a 180 °C, 30 minutos hasta que la costra quede dorada.',
    ],
  ),

  // ─────────── cresson (6 recettes) ───────────
  'cresson/Pesto de cresson en glaçons': RecipeText(
    // FR: Pesto de cresson en glaçons
    name: 'Pesto de berros en cubitos',
    // FR: Poivré et vert vif, il se congèle en cubes à faire fondre sur des pâtes, un poisson ou dans une soupe.
    description: 'Picante y de un verde vivo, se congela en cubos que se derriten sobre pasta, un pescado o en una sopa.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '250 g de berros', // FR: 250 g de cresson
      '50 g de nueces', // FR: 50 g de noix
      '1 diente de ajo', // FR: 1 gousse d'ail
      '12 cl de aceite de oliva', // FR: 12 cl d'huile d'olive
      'sal', // FR: sel
    ],
    steps: <String>[
      // FR: Lave le cresson dans plusieurs eaux, à l'eau froide, puis **sèche-le très bien** à l'essoreuse.
      'Lava los berros en varias aguas, con agua fría, y luego **sécalos muy bien** en la centrifugadora de ensalada.',
      // FR: Retire les plus grosses tiges, qui sont filandreuses.
      'Quita los tallos más gruesos, que son fibrosos.',
      // FR: Mixe cresson, noix et ail par à-coups, en versant l'huile en filet, sans faire chauffer le mixeur.
      'Tritura los berros, las nueces y el ajo a golpes, añadiendo el aceite en un hilo, sin que se caliente la batidora.',
      // FR: Sale et goûte. **Sans fromage** : il devient granuleux au congélateur.
      'Sala y prueba. **Sin queso**: se vuelve granuloso en el congelador.',
      // FR: Remplis un bac à glaçons et couvre chaque case d'un filet d'huile pour garder le vert.
      'Llena una cubitera y cubre cada hueco con un hilo de aceite para conservar el verde.',
      // FR: Démoule les cubes une fois durs, au bout de 4 heures, et garde-les en sac daté.
      'Desmolda los cubos cuando estén duros, pasadas 4 horas, y guárdalos en una bolsa con fecha.',
    ],
  ),
  'cresson/Cresson blanchi en boulettes': RecipeText(
    // FR: Cresson blanchi en boulettes
    name: 'Berros escaldados en bolitas',
    // FR: Trente secondes d'eau bouillante, et une récolte de cresson attend en boulettes vertes la prochaine soupe.
    description: 'Treinta segundos de agua hirviendo, y una cosecha de berros espera en bolitas verdes la próxima sopa.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 kg de berros', // FR: 1 kg de cresson
      'sal gruesa', // FR: gros sel
      '1 bol grande de agua con hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave le cresson dans plusieurs eaux et retire les tiges dures et les feuilles jaunies.
      'Lava los berros en varias aguas y quita los tallos duros y las hojas amarillentas.',
      // FR: Plonge-le dans une grande eau bouillante salée **30 secondes**, pas plus : il cuit en un instant.
      'Échalos en una olla grande de agua hirviendo con sal **30 segundos**, no más: se cuecen en un instante.',
      // FR: Transfère-le aussitôt dans l'eau glacée pour fixer le vert.
      'Pásalos enseguida al agua con hielo para fijar el verde.',
      // FR: Presse-le fort en boule entre tes mains pour chasser toute l'eau.
      'Apriétalos fuerte entre las manos formando una bola para sacar toda el agua.',
      // FR: Forme des boulettes d'une portion, congèle-les 2 heures sur une plaque, puis mets-les en sac.
      'Forma bolitas del tamaño de una ración, congélalas 2 horas en una bandeja y luego pásalas a una bolsa.',
    ],
  ),
  'cresson/Sel vert au cresson': RecipeText(
    // FR: Sel vert au cresson
    name: 'Sal verde de berros',
    // FR: Mixé avec du gros sel et séché, le cresson devient un sel poivré à garder dans un pot près des fourneaux.
    description: 'Triturados con sal gruesa y secados, los berros se convierten en una sal picante para guardar en un tarro junto a los fogones.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      '150 g de hojas de berro', // FR: 150 g de feuilles de cresson
      '300 g de sal gruesa gris', // FR: 300 g de gros sel gris
      '3 tarros pequeños de cristal', // FR: 3 petits pots en verre
    ],
    steps: <String>[
      // FR: Lave le cresson et **sèche-le parfaitement** au torchon.
      'Lava los berros y **sécalos perfectamente** con un paño.',
      // FR: Mixe les feuilles avec le gros sel jusqu'à obtenir un sable vert et humide.
      'Tritura las hojas con la sal gruesa hasta obtener una arena verde y húmeda.',
      // FR: Étale-le en couche fine sur une plaque garnie de papier cuisson et enfourne à 60 °C, porte entrouverte.
      'Extiéndela en capa fina sobre una bandeja con papel de horno y mete al horno a 60 °C, con la puerta entreabierta.',
      // FR: Émiette-le à la fourchette toutes les heures pour casser les grumeaux. Il est prêt quand il coule entre les doigts.
      'Desmenúzala con un tenedor cada hora para deshacer los grumos. Está lista cuando se desliza entre los dedos.',
      // FR: Laisse refroidir complètement, puis mets en pots fermés, à l'abri de la lumière qui le fait pâlir.
      'Deja enfriar del todo y pásala a tarros cerrados, lejos de la luz, que le hace perder el color.',
    ],
  ),
  'cresson/Potage au cresson': RecipeText(
    // FR: Potage au cresson
    name: 'Crema de berros',
    // FR: Le classique : cresson, pomme de terre, crème.
    description: 'El clásico: berros, patata, nata.',
  ),
  'cresson/Salade de cresson aux agrumes': RecipeText(
    // FR: Salade de cresson aux agrumes
    name: 'Ensalada de berros con cítricos',
    // FR: Le poivré du cresson contre l'acidité de l'orange.
    description: 'El picante del berro frente a la acidez de la naranja.',
  ),
  'cresson/Beurre de cresson': RecipeText(
    // FR: Beurre de cresson
    name: 'Mantequilla de berros',
    // FR: Haché dans du beurre pommade, sur un poisson chaud.
    description: 'Picados en mantequilla pomada, sobre un pescado caliente.',
  ),

  // ─────────── echalote (6 recettes) ───────────
  'echalote/Échalotes séchées en filet': RecipeText(
    // FR: Échalotes séchées en filet
    name: 'Chalotas secas en red',
    // FR: Bien ressuyées après la récolte, les échalotes grises tiennent souvent jusqu'au printemps suivant.
    description: 'Bien secas tras la cosecha, las chalotas grises suelen aguantar hasta la primavera siguiente.',
    // FR: 8 mois au sec, à l'abri de la lumière
    keeps: '8 meses en seco, protegidas de la luz',
    ingredients: <String>[
      '3 kg de chalotas recién arrancadas', // FR: 3 kg d'échalotes fraîchement arrachées
      'redes o cajas con rejilla', // FR: des filets ou des cagettes ajourées
    ],
    steps: <String>[
      // FR: Arrache les touffes quand le feuillage jaunit et se couche. Laisse-les sur le sol un jour ou deux s'il fait sec.
      'Arranca las matas cuando el follaje amarillea y se tumba. Déjalas en el suelo uno o dos días si hace seco.',
      // FR: Rentre-les dans un abri aéré et laisse-les sécher **2 semaines** en une seule couche, sans les entasser.
      'Llévalas a un cobertizo ventilado y déjalas secar **2 semanas** en una sola capa, sin amontonarlas.',
      // FR: Sépare les bulbes, coupe les fanes sèches à 2 cm et les racines au ras.
      'Separa los bulbos, corta las hojas secas a 2 cm y las raíces a ras.',
      // FR: Brosse la terre à sec, sans jamais les laver : l'humidité est leur pire ennemie.
      'Cepilla la tierra en seco, sin lavarlas nunca: la humedad es su peor enemiga.',
      // FR: Range-les en filets suspendus ou en cagettes, au frais et au sec. Trie-les tous les mois et utilise vite celles qui germent.
      'Guárdalas en redes colgadas o en cajas, en un sitio fresco y seco. Revísalas cada mes y usa pronto las que broten.',
    ],
  ),
  'echalote/Échalotes ciselées congelées': RecipeText(
    // FR: Échalotes ciselées congelées
    name: 'Chalotas picadas congeladas',
    // FR: Un quart d'heure de larmes une bonne fois, et tu as des échalotes ciselées prêtes pour chaque sauce.
    description: 'Un cuarto de hora de lágrimas de una vez, y tienes chalotas picadas listas para cada salsa.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '500 g de chalotas', // FR: 500 g d'échalotes
      'una cubitera o bolsitas pequeñas', // FR: un bac à glaçons ou des petits sachets
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les échalotes : 5 minutes au réfrigérateur avant, et elles piquent moins les yeux.
      'Pela las chalotas: 5 minutos en la nevera antes, y pican menos en los ojos.',
      // FR: Cisèle-les finement, à la main ou au hachoir par à-coups pour ne pas en faire une purée.
      'Pícalas finas, a mano o con la picadora a golpes para no hacer un puré.',
      // FR: Répartis en petits tas sur une plaque, une cuillère à soupe par tas, et congèle 2 heures.
      'Reparte en montoncitos sobre una bandeja, una cucharada sopera por montón, y congela 2 horas.',
      // FR: Passe-les dans un bocal ou un sac double, bien fermé : l'odeur voyage dans le congélateur.
      'Pásalas a un tarro o a una bolsa doble, bien cerrado: el olor viaja por el congelador.',
      // FR: Utilise-les gelées, directement dans la poêle. Pour une vinaigrette crue, prends plutôt de l'échalote fraîche.
      'Úsalas congeladas, directamente en la sartén. Para una vinagreta cruda, mejor chalota fresca.',
    ],
  ),
  'echalote/Chutney d\'échalotes au balsamique': RecipeText(
    // FR: Chutney d'échalotes au balsamique
    name: 'Chutney de chalotas al balsámico',
    // FR: Cuites longuement avec sucre et vinaigre, elles font un condiment brun et brillant pour les fromages et les terrines.
    description: 'Cocidas largo rato con azúcar y vinagre, dan un condimento marrón y brillante para quesos y patés.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      '1 kg de chalotas', // FR: 1 kg d'échalotes
      '150 g de azúcar moreno', // FR: 150 g de sucre roux
      '15 cl de vinagre balsámico', // FR: 15 cl de vinaigre balsamique
      '15 cl de vinagre de vino tinto al 6 %', // FR: 15 cl de vinaigre de vin rouge à 6 %
      '2 cucharadas de aceite de oliva', // FR: 2 cuillères à soupe d'huile d'olive
      '1 rama de tomillo', // FR: 1 branche de thym
    ],
    steps: <String>[
      // FR: Épluche les échalotes et émince-les en fines lamelles.
      'Pela las chalotas y córtalas en láminas finas.',
      // FR: Fais-les fondre à feu doux dans l'huile, à couvert, en remuant souvent. Elles doivent devenir translucides, pas brunes.
      'Póchalas a fuego suave en el aceite, tapadas, removiendo a menudo. Deben quedar translúcidas, no doradas.',
      // FR: Ajoute le sucre, les deux vinaigres et le thym, mélange bien.
      'Añade el azúcar, los dos vinagres y el tomillo, y mezcla bien.',
      // FR: Laisse cuire à découvert, à petits bouillons, en remuant de plus en plus souvent vers la fin.
      'Deja cocer sin tapar, a fuego lento, removiendo cada vez más a menudo hacia el final.',
      // FR: C'est prêt quand la cuillère laisse **un sillon** au fond de la casserole. Retire le thym.
      'Está listo cuando la cuchara deja **un surco** en el fondo del cazo. Quita el tomillo.',
      // FR: Mets en pots ébouillantés, ferme, laisse refroidir et range au réfrigérateur.
      'Pásalo a tarros escaldados, cierra, deja enfriar y guarda en la nevera.',
    ],
  ),
  'echalote/Sauce échalote au vin rouge': RecipeText(
    // FR: Sauce échalote au vin rouge
    name: 'Salsa de chalota al vino tinto',
    // FR: La sauce des steaks : des échalotes fondues dans le vin réduit.
    description: 'La salsa de los filetes: chalotas fundidas en vino reducido.',
    ingredients: <String>[
      '6 chalotas', // FR: 6 échalotes
      '25 cl de vino tinto', // FR: 25 cl de vin rouge
      '40 g de mantequilla fría', // FR: 40 g de beurre froid
      '1 cucharadita de azúcar', // FR: 1 cuillère à café de sucre
      'tomillo, sal, pimienta', // FR: thym, sel, poivre
    ],
    steps: <String>[
      // FR: Hache les échalotes très finement.
      'Pica las chalotas muy finas.',
      // FR: Fais-les fondre dans un peu de beurre, 8 minutes, sans colorer.
      'Póchalas en un poco de mantequilla, 8 minutos, sin que cojan color.',
      // FR: Verse le vin, le sucre, le thym, et laisse réduire des deux tiers.
      'Vierte el vino, el azúcar, el tomillo, y deja que se reduzca en dos tercios.',
      // FR: Hors du feu, incorpore le beurre **froid** en morceaux, en tournant : c'est ce qui lie et fait briller.
      'Fuera del fuego, incorpora la mantequilla **fría** en trozos, removiendo: eso es lo que liga y da brillo.',
      // FR: Sel, poivre, et sers aussitôt.
      'Sal, pimienta y sirve enseguida.',
    ],
  ),
  'echalote/Échalotes confites': RecipeText(
    // FR: Échalotes confites
    name: 'Chalotas confitadas',
    // FR: Entières, au four, avec du vinaigre balsamique et du thym.
    description: 'Enteras, al horno, con vinagre balsámico y tomillo.',
    ingredients: <String>[
      '500 g de chalotas', // FR: 500 g d'échalotes
      '2 cucharadas de miel', // FR: 2 cuillères à soupe de miel
      '3 cucharadas de vinagre balsámico', // FR: 3 cuillères à soupe de vinaigre balsamique
      '2 cucharadas de aceite', // FR: 2 cuillères à soupe d'huile
      'tomillo, sal gruesa', // FR: thym, gros sel
    ],
    steps: <String>[
      // FR: Pèle les échalotes en les gardant entières, racine coupée court.
      'Pela las chalotas dejándolas enteras, con la raíz cortada al ras.',
      // FR: Mélange-les à l'huile, au miel, au vinaigre.
      'Mézclalas con el aceite, la miel y el vinagre.',
      // FR: Four à 180 °C, 45 minutes, en remuant deux fois.
      'Horno a 180 °C, 45 minutos, removiendo dos veces.',
      // FR: Elles doivent être tendres au couteau et luisantes. Bon chaud ou froid, avec une viande ou un fromage.
      'Deben quedar tiernas al pincharlas con el cuchillo y brillantes. Buenas calientes o frías, con una carne o un queso.',
    ],
  ),
  'echalote/Vinaigrette à l\'échalote': RecipeText(
    // FR: Vinaigrette à l'échalote
    name: 'Vinagreta de chalota',
    // FR: L'échalote hachée adoucie par le vinaigre : la base de tout.
    description: 'La chalota picada, suavizada por el vinagre: la base de todo.',
    ingredients: <String>[
      '2 chalotas', // FR: 2 échalotes
      '3 cucharadas de vinagre de vino', // FR: 3 cuillères à soupe de vinaigre de vin
      '1 cucharadita de mostaza', // FR: 1 cuillère à café de moutarde
      '8 cucharadas de aceite', // FR: 8 cuillères à soupe d'huile
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Hache les échalotes le plus fin possible.
      'Pica las chalotas lo más fino posible.',
      // FR: Laisse-les macérer 10 minutes dans le vinaigre salé : elles perdent leur agressivité.
      'Déjalas macerar 10 minutos en el vinagre con sal: pierden su agresividad.',
      // FR: Ajoute la moutarde, mélange.
      'Añade la mostaza y mezcla.',
      // FR: Huile en filet en fouettant. Se garde une semaine au frais.
      'Aceite en hilo mientras bates. Se conserva una semana en la nevera.',
    ],
  ),

  // ─────────── endive (6 recettes) ───────────
  'endive/Pickles d\'endives au cidre': RecipeText(
    // FR: Pickles d'endives au cidre
    name: 'Pickles de endibias a la sidra',
    // FR: Ses feuilles croquantes et amères adorent le vinaigre doux : un condiment surprenant pour une raclette.
    description: 'Sus hojas crujientes y amargas adoran el vinagre suave: un condimento sorprendente para una raclette.',
    // FR: 3 semaines au réfrigérateur
    keeps: '3 semanas en la nevera',
    ingredients: <String>[
      '6 endibias', // FR: 6 endives
      '25 cl de vinagre de sidra al 6 %', // FR: 25 cl de vinaigre de cidre à 6 %
      '25 cl de agua', // FR: 25 cl d'eau
      '2 cucharadas de azúcar', // FR: 2 cuillères à soupe de sucre
      '1 cucharadita de sal fina', // FR: 1 cuillère à café de sel fin
      '1 cucharadita de granos de pimienta', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Retire les feuilles abîmées et creuse le petit cône amer à la base avec la pointe d'un couteau.
      'Quita las hojas estropeadas y vacía con la punta de un cuchillo el pequeño cono amargo de la base.',
      // FR: Coupe les endives en quartiers dans la longueur, ou en tronçons de 3 cm.
      'Corta las endibias en cuartos a lo largo, o en trozos de 3 cm.',
      // FR: Tasse-les dans les bocaux avec le poivre.
      'Apriétalas en los tarros con la pimienta.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Lleva a ebullición el vinagre, el agua, el azúcar y la sal.',
      // FR: Verse bouillant jusqu'à **couvrir entièrement**, ferme et laisse refroidir, puis range au réfrigérateur.
      'Vierte hirviendo hasta **cubrirlas por completo**, cierra y deja enfriar, y luego guarda en la nevera.',
    ],
  ),
  'endive/Endives fondantes au beurre à congeler': RecipeText(
    // FR: Endives fondantes au beurre à congeler
    name: 'Endibias melosas con mantequilla para congelar',
    // FR: Cuites doucement à couvert, elles se congèlent très bien et finissent en gratin ou en tarte en un rien de temps.
    description: 'Cocidas despacio y tapadas, se congelan muy bien y acaban en gratinado o en tarta en un abrir y cerrar de ojos.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 kg de endibias', // FR: 2 kg d'endives
      '40 g de mantequilla', // FR: 40 g de beurre
      'el zumo de medio limón', // FR: le jus d'un demi-citron
      '1 cucharadita de azúcar', // FR: 1 cuillère à café de sucre
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Retire le cône amer à la base et coupe les endives en deux dans la longueur.
      'Quita el cono amargo de la base y corta las endibias por la mitad a lo largo.',
      // FR: Fais fondre le beurre dans une grande cocotte et pose les endives à plat, face coupée dessous.
      'Derrite la mantequilla en una cacerola grande y coloca las endibias planas, con la cara cortada hacia abajo.',
      // FR: Arrose du jus de citron, saupoudre de sucre, sale. Le citron les garde blanches.
      'Rocía con el zumo de limón, espolvorea azúcar y sala. El limón las mantiene blancas.',
      // FR: Couvre et laisse fondre à feu doux, sans ajouter d'eau : elles rendent la leur.
      'Tapa y deja que se ablanden a fuego suave, sin añadir agua: sueltan la suya.',
      // FR: Laisse refroidir dans leur jus, cocotte posée dans l'eau froide.
      'Deja enfriar en su jugo, con la cacerola metida en agua fría.',
      // FR: Répartis en boîtes avec le jus, à 2 cm du bord, et congèle. Elles iront tout droit au four sous une béchamel.
      'Reparte en recipientes con el jugo, a 2 cm del borde, y congela. Irán directas al horno bajo una bechamel.',
    ],
  ),
  'endive/Endives blanchies au citron': RecipeText(
    // FR: Endives blanchies au citron
    name: 'Endibias escaldadas con limón',
    // FR: Blanchies dans une eau citronnée, elles restent claires et prêtes à braiser sans repasser par la planche.
    description: 'Escaldadas en agua con limón, se quedan claras y listas para estofar sin volver a pasar por la tabla.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '2 kg de endibias', // FR: 2 kg d'endives
      'el zumo de un limón', // FR: le jus d'un citron
      'sal gruesa', // FR: gros sel
      'un bol grande de agua con hielo', // FR: un grand saladier d'eau et de glaçons
    ],
    steps: <String>[
      // FR: Retire le cône amer et coupe les endives en deux dans la longueur.
      'Quita el cono amargo y corta las endibias por la mitad a lo largo.',
      // FR: Ajoute le jus de citron et le gros sel à une grande casserole d'eau et porte à gros bouillons.
      'Añade el zumo de limón y la sal gruesa a una olla grande de agua y llévala a ebullición fuerte.',
      // FR: Plonge les demi-endives **3 minutes**.
      'Sumerge las medias endibias **3 minutos**.',
      // FR: Transfère-les dans l'eau glacée, puis égoutte-les tête en bas dans une passoire.
      'Pásalas enseguida al agua con hielo y luego escúrrelas boca abajo en un colador.',
      // FR: Presse-les doucement dans un torchon : une endive garde beaucoup d'eau entre ses feuilles.
      'Exprímelas con suavidad en un paño: una endibia retiene mucha agua entre las hojas.',
      // FR: Congèle-les à plat sur une plaque, puis mets-les en sacs.
      'Congélalas planas en una bandeja y luego pásalas a bolsas.',
    ],
  ),
  'endive/Endives au jambon': RecipeText(
    // FR: Endives au jambon
    name: 'Endibias con jamón',
    // FR: Braisées, roulées dans le jambon, nappées de béchamel.
    description: 'Estofadas, enrolladas en jamón, cubiertas de bechamel.',
  ),
  'endive/Salade d\'endives aux noix et bleu': RecipeText(
    // FR: Salade d'endives aux noix et bleu
    name: 'Ensalada de endibias con nueces y queso azul',
    // FR: L'amertume, le gras et le croquant : l'accord fonctionne toujours.
    description: 'El amargor, la grasa y lo crujiente: la combinación funciona siempre.',
  ),
  'endive/Endives braisées au miel': RecipeText(
    // FR: Endives braisées au miel
    name: 'Endibias estofadas con miel',
    // FR: Le miel contre l'amertume, un filet de citron pour trancher.
    description: 'La miel contra el amargor, un chorrito de limón para cortar.',
  ),

  // ─────────── epinard (6 recettes) ───────────
  'epinard/Palets d\'épinards blanchis': RecipeText(
    // FR: Palets d'épinards blanchis
    name: 'Discos de espinacas escaldadas',
    // FR: Une minute dans l'eau bouillante, pressés en palets : tes épinards sont prêts pour une omelette ou un gratin.
    description: 'Un minuto en agua hirviendo, prensadas en discos: tus espinacas están listas para una tortilla o un gratinado.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de espinacas', // FR: 1,5 kg d'épinards
      'sal gruesa', // FR: gros sel
      '1 bol grande de agua con hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Équeute les épinards en tirant sur la tige pour enlever la nervure.
      'Quita los rabillos de las espinacas tirando del tallo para sacar el nervio.',
      // FR: Lave-les dans plusieurs eaux : le sable reste collé au revers des feuilles.
      'Lávalas en varias aguas: la arena se queda pegada al envés de las hojas.',
      // FR: Plonge-les par grosses poignées dans une grande eau bouillante salée.
      'Échalas por buenos puñados en una olla grande de agua hirviendo con sal.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée : c'est ce qui **fixe le vert**.
      'Escurre y pásalas enseguida al agua con hielo: eso es lo que **fija el verde**.',
      // FR: Presse-les en boule entre tes mains, vraiment fort, pour chasser l'eau.
      'Apriétalas en bola entre las manos, de verdad fuerte, para sacar el agua.',
      // FR: Forme des palets d'une portion, congèle 2 heures sur une plaque, puis mets-les en sac.
      'Forma discos del tamaño de una ración, congela 2 horas en una bandeja y luego pásalos a una bolsa.',
    ],
  ),
  'epinard/Velouté d\'épinards à congeler': RecipeText(
    // FR: Velouté d'épinards à congeler
    name: 'Crema de espinacas para congelar',
    // FR: Quand la planche monte en graines, tout finit en velouté vert : six portions prêtes pour l'hiver.
    description: 'Cuando las espinacas se espigan, todo acaba en una crema verde: seis raciones listas para el invierno.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '700 g de espinacas', // FR: 700 g d'épinards
      '3 patatas', // FR: 3 pommes de terre
      '1 cebolla', // FR: 1 oignon
      '1,2 litros de caldo', // FR: 1,2 litre de bouillon
      'sal, pimienta, nuez moscada', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Équeute et lave les épinards dans plusieurs eaux.
      'Quita los rabillos y lava las espinacas en varias aguas.',
      // FR: Épluche et coupe en dés pommes de terre et oignon.
      'Pela y corta en dados las patatas y la cebolla.',
      // FR: Cuis-les dans le bouillon jusqu'à ce que les pommes de terre s'écrasent.
      'Cuécelas en el caldo hasta que las patatas se deshagan al aplastarlas.',
      // FR: Ajoute les épinards et compte **2 minutes**, pas plus : au-delà, le vert tourne au kaki.
      'Añade las espinacas y cuenta **2 minutos**, no más: pasado ese tiempo el verde vira a color caqui.',
      // FR: Mixe aussitôt hors du feu, sans crème. Tu l'ajouteras dans l'assiette.
      'Tritura enseguida, fuera del fuego, sin nata. La añadirás en el plato.',
      // FR: Refroidis vite, casserole dans l'eau froide.
      'Enfría rápido, con la cacerola metida en agua fría.',
      // FR: Répartis en portions en laissant 2 cm de vide : ça gonfle en gelant. Note la date.
      'Reparte en raciones dejando 2 cm de vacío: se expande al congelarse. Anota la fecha.',
    ],
  ),
  'epinard/Poudre d\'épinards': RecipeText(
    // FR: Poudre d'épinards
    name: 'Espinacas en polvo',
    // FR: Séchés puis moulus, les épinards colorent pâtes fraîches, crêpes et purées tout l'hiver.
    description: 'Secas y molidas, las espinacas colorean pasta fresca, crepes y purés todo el invierno.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegido de la luz',
    ingredients: <String>[
      '1 kg de espinacas', // FR: 1 kg d'épinards
      'un tarro hermético bien seco', // FR: un bocal hermétique bien sec
    ],
    steps: <String>[
      // FR: Équeute les épinards et garde les feuilles saines.
      'Quita los rabillos de las espinacas y quédate con las hojas sanas.',
      // FR: Lave-les et **sèche-les complètement** à l'essoreuse puis dans un torchon.
      'Lávalas y **sécalas por completo** con la centrifugadora y luego con un paño.',
      // FR: Étale-les en une couche et sèche à **50 °C**, porte entrouverte, jusqu'à ce qu'elles s'émiettent.
      'Extiéndelas en una capa y sécalas a **50 °C**, con la puerta entreabierta, hasta que se desmenucen.',
      // FR: Laisse refroidir complètement avant de mixer.
      'Deja enfriar del todo antes de triturar.',
      // FR: Mixe en poudre fine et passe au tamis.
      'Tritura hasta obtener un polvo fino y pásalo por el tamiz.',
      // FR: Mets en bocal hermétique, à l'abri de la lumière : elle perd sa couleur au jour.
      'Guárdalo en un tarro hermético, lejos de la luz: pierde el color a la luz del día.',
    ],
  ),
  'epinard/Épinards à la crème': RecipeText(
    // FR: Épinards à la crème
    name: 'Espinacas a la nata',
    // FR: Fondus en deux minutes, liés à la crème : l'accompagnement de base.
    description: 'Rehogadas en dos minutos y ligadas con nata: la guarnición de base.',
    ingredients: <String>[
      '1 kg de espinacas frescas', // FR: 1 kg d'épinards frais
      '20 cl de nata', // FR: 20 cl de crème
      '20 g de mantequilla', // FR: 20 g de beurre
      '1 diente de ajo', // FR: 1 gousse d'ail
      'sal, pimienta, nuez moscada', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Lave les épinards dans beaucoup d'eau, deux fois, et équeute les grosses tiges.
      'Lava las espinacas en mucha agua, dos veces, y quita los tallos gruesos.',
      // FR: Jette-les dans la sauteuse beurrée, par poignées : ils réduisent des trois quarts.
      'Échalas por puñados en la sartén honda con la mantequilla: reducen tres cuartas partes.',
      // FR: Quand ils sont tombés, presse-les pour en sortir l'eau — sinon la crème ne tient pas.
      'Cuando se hayan ablandado, exprímelas para sacar el agua; si no, la nata no liga.',
      // FR: Remets-les avec la crème, l'ail écrasé, sel, poivre, muscade.
      'Devuélvelas a la sartén con la nata, el ajo machacado, sal, pimienta y nuez moscada.',
      // FR: Laisse épaissir 5 minutes à feu doux.
      'Deja espesar 5 minutos a fuego suave.',
    ],
  ),
  'epinard/Tarte aux épinards et feta': RecipeText(
    // FR: Tarte aux épinards et feta
    name: 'Tarta de espinacas y feta',
    // FR: Le sel de la feta contre le vert des épinards, dans une pâte croustillante.
    description: 'La sal de la feta frente al verde de las espinacas, en una masa crujiente.',
    ingredients: <String>[
      '1 masa de hojaldre', // FR: 1 pâte feuilletée
      '800 g de espinacas', // FR: 800 g d'épinards
      '200 g de feta', // FR: 200 g de feta
      '2 huevos, 15 cl de nata', // FR: 2 oeufs, 15 cl de crème
      '1 cebolla, sal, pimienta, nuez moscada', // FR: 1 oignon, sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Fais tomber les épinards à la poêle, puis presse-les.
      'Rehoga las espinacas en la sartén hasta que se ablanden y luego exprímelas.',
      // FR: Fais blondir l'oignon émincé et mélange-le dedans.
      'Dora la cebolla en láminas y mézclala con ellas.',
      // FR: Bats oeufs et crème, muscade, poivre. Pas de sel : la feta suffit.
      'Bate los huevos y la nata, la nuez moscada y la pimienta. Sin sal: la feta basta.',
      // FR: Garnis la pâte des épinards, émiette la feta, verse l'appareil.
      'Cubre la masa con las espinacas, desmenuza la feta y vierte la mezcla.',
      // FR: Four à 190 °C, 30 minutes.
      'Horno a 190 °C, 30 minutos.',
    ],
  ),
  'epinard/Épinards sautés à l\'ail': RecipeText(
    // FR: Épinards sautés à l'ail
    name: 'Espinacas salteadas con ajo',
    // FR: Trois minutes à feu vif : la cuisson qui garde la couleur.
    description: 'Tres minutos a fuego fuerte: la cocción que conserva el color.',
    ingredients: <String>[
      '800 g de espinacas', // FR: 800 g d'épinards
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '2 cucharadas de aceite de oliva', // FR: 2 cuillères à soupe d'huile d'olive
      'sal, guindilla, limón', // FR: sel, piment, citron
    ],
    steps: <String>[
      // FR: Fais blondir l'ail émincé dans l'huile, sans le brûler.
      'Dora el ajo laminado en el aceite, sin quemarlo.',
      // FR: Monte le feu, jette les épinards essorés et remue sans arrêt.
      'Sube el fuego, echa las espinacas escurridas y remueve sin parar.',
      // FR: 3 minutes, pas plus : dès qu'ils sont tombés, c'est cuit.
      '3 minutos, no más: en cuanto se ablandan, están hechas.',
      // FR: Sel, une pointe de piment, un trait de citron.
      'Sal, una pizca de guindilla, un chorrito de limón.',
    ],
  ),

  // ─────────── estragon (6 recettes) ───────────
  'estragon/Beurre d\'estragon en rouleau': RecipeText(
    // FR: Beurre d'estragon en rouleau
    name: 'Rulo de mantequilla de estragón',
    // FR: L'estragon perd son anis au séchage ; enfermé dans le beurre et congelé, il le garde intact.
    description: 'El estragón pierde su anís al secarse; encerrado en mantequilla y congelado, lo conserva intacto.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '250 g de mantequilla blanda', // FR: 250 g de beurre mou
      '1 manojo grande de estragón', // FR: 1 gros bouquet d'estragon
      '1 chalota', // FR: 1 échalote
      '1 pizca de flor de sal', // FR: 1 pincée de fleur de sel
      'film transparente', // FR: du film alimentaire
    ],
    steps: <String>[
      // FR: Lave et sèche l'estragon, puis effeuille-le : les tiges sont dures et amères.
      'Lava y seca el estragón y luego deshójalo: los tallos son duros y amargos.',
      // FR: Hache finement les feuilles et l'échalote.
      'Pica finamente las hojas y la chalota.',
      // FR: Écrase le beurre mou à la fourchette avec l'estragon, l'échalote et le sel.
      'Aplasta la mantequilla blanda con un tenedor junto con el estragón, la chalota y la sal.',
      // FR: Pose-le sur le film, roule en boudin de 4 cm de diamètre et **serre bien les extrémités**.
      'Ponla sobre el film, enrolla formando un cilindro de 4 cm de diámetro y **aprieta bien los extremos**.',
      // FR: Congèle à plat. Tu couperas une rondelle encore gelée à poser sur une viande, un poisson ou des légumes vapeur.
      'Congela en horizontal. Cortarás una rodaja aún congelada para poner sobre una carne, un pescado o verduras al vapor.',
    ],
  ),
  'estragon/Moutarde à l\'estragon': RecipeText(
    // FR: Moutarde à l'estragon
    name: 'Mostaza al estragón',
    // FR: Des graines, du vinaigre et ton estragon : une moutarde à l'ancienne qui pique juste ce qu'il faut.
    description: 'Semillas, vinagre y tu estragón: una mostaza a la antigua que pica justo lo necesario.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '100 g de semillas de mostaza amarillas y marrones', // FR: 100 g de graines de moutarde jaunes et brunes
      '15 cl de vinagre de sidra al 6 % como mínimo', // FR: 15 cl de vinaigre de cidre à 6 % minimum
      '5 cl de agua', // FR: 5 cl d'eau
      '1 manojito de estragón', // FR: 1 petit bouquet d'estragon
      '1 cucharadita de sal, 1 cucharada de miel', // FR: 1 cuillère à café de sel, 1 cuillère à soupe de miel
    ],
    steps: <String>[
      // FR: Mets les graines dans un bocal et couvre-les du vinaigre et de l'eau. **Pas plus d'eau que de vinaigre.**
      'Pon las semillas en un tarro y cúbrelas con el vinagre y el agua. **No más agua que vinagre.**',
      // FR: Ferme et laisse gonfler 24 heures au réfrigérateur. Les graines boivent presque tout le liquide.
      'Cierra y deja que se hinchen 24 horas en la nevera. Las semillas absorben casi todo el líquido.',
      // FR: Effeuille et hache finement l'estragon.
      'Deshoja y pica finamente el estragón.',
      // FR: Mixe la moitié des graines avec le sel et le miel, garde l'autre moitié entière pour le grain.
      'Tritura la mitad de las semillas con la sal y la miel, y deja la otra mitad entera para que quede con grano.',
      // FR: Mélange tout avec l'estragon. Si c'est trop épais, ajoute un trait de vinaigre, jamais d'eau seule.
      'Mezcla todo con el estragón. Si queda demasiado espesa, añade un chorrito de vinagre, nunca agua sola.',
      // FR: Tasse dans un pot propre, ferme et range au frais. Elle est très forte au début, puis s'adoucit en une semaine.
      'Aprieta en un tarro limpio, cierra y guarda en la nevera. Es muy fuerte al principio y se suaviza en una semana.',
    ],
  ),
  'estragon/Estragon séché en bottes': RecipeText(
    // FR: Estragon séché en bottes
    name: 'Estragón seco en manojos',
    // FR: Pour la fin de saison, quand tu en as trop : moins parfumé que frais, mais parfait dans les sauces mijotées.
    description: 'Para el final de temporada, cuando te sobra: menos aromático que fresco, pero perfecto en salsas guisadas.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegido de la luz',
    ingredients: <String>[
      'tallos de estragón cortados antes de la floración', // FR: des tiges d'estragon coupées avant la floraison
      'cordel', // FR: de la ficelle
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges en fin de matinée, rosée évaporée, juste avant que la plante ne fleurisse.
      'Corta los tallos a media mañana, cuando se haya evaporado el rocío, justo antes de que la planta florezca.',
      // FR: Ne les lave pas si elles sont propres. Lie-les en petites bottes lâches, l'air doit circuler au milieu.
      'No los laves si están limpios. Átalos en manojos pequeños y sueltos: el aire debe circular por el centro.',
      // FR: Suspends-les tête en bas dans un endroit **sombre, sec et aéré**, une dizaine de jours. Au soleil, elles perdent leur parfum.
      'Cuélgalos boca abajo en un lugar **oscuro, seco y ventilado**, unos diez días. Al sol pierden su aroma.',
      // FR: Les feuilles sont prêtes quand elles cassent net sous les doigts.
      'Las hojas están listas cuando se parten limpiamente entre los dedos.',
      // FR: Égrène-les entières dans un bocal, et émiette-les seulement au moment de cuisiner.
      'Desgránalas enteras en un tarro y desmenúzalas solo en el momento de cocinar.',
    ],
  ),
  'estragon/Sauce béarnaise': RecipeText(
    // FR: Sauce béarnaise
    name: 'Salsa bearnesa',
    // FR: Réduction au vinaigre et à l'estragon, montée au beurre.
    description: 'Reducción de vinagre y estragón, montada con mantequilla.',
  ),
  'estragon/Poulet à l\'estragon': RecipeText(
    // FR: Poulet à l'estragon
    name: 'Pollo al estragón',
    // FR: Crème et estragon, un classique qui ne vieillit pas.
    description: 'Nata y estragón, un clásico que no pasa de moda.',
  ),
  'estragon/Vinaigre à l\'estragon': RecipeText(
    // FR: Vinaigre à l'estragon
    name: 'Vinagre de estragón',
    // FR: Une branche dans la bouteille, trois semaines.
    description: 'Una rama en la botella, tres semanas.',
  ),

  // ─────────── fenouil (6 recettes) ───────────
  'fenouil/Pickles de fenouil à l\'orange': RecipeText(
    // FR: Pickles de fenouil à l'orange
    name: 'Pickles de hinojo a la naranja',
    // FR: Tranché fin et mariné, le fenouil garde son croquant anisé et devient un condiment frais pour le poisson.
    description: 'Cortado fino y macerado, el hinojo conserva su crujiente sabor anisado y se vuelve un condimento fresco para el pescado.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      '3 bulbos de hinojo', // FR: 3 bulbes de fenouil
      'la piel de una naranja', // FR: le zeste d'une orange
      '25 cl de vinagre de sidra al 6 %', // FR: 25 cl de vinaigre de cidre à 6 %
      '25 cl de agua', // FR: 25 cl d'eau
      '2 cucharadas de azúcar', // FR: 2 cuillères à soupe de sucre
      '1 cucharadita de sal fina', // FR: 1 cuillère à café de sel fin
    ],
    steps: <String>[
      // FR: Rince les bulbes, retire la première couche si elle est fibreuse et garde les plumets.
      'Enjuaga los bulbos, quita la primera capa si es fibrosa y guarda las frondas.',
      // FR: Coupe le fenouil en deux et tranche-le très finement, à la mandoline si tu en as une.
      'Corta el hinojo por la mitad y lamínalo muy fino, con mandolina si tienes una.',
      // FR: Tasse les lamelles dans les bocaux avec le zeste d'orange en rubans et quelques plumets.
      'Aprieta las láminas en los tarros con la piel de naranja en tiras y unas cuantas frondas.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Lleva a ebullición el vinagre, el agua, el azúcar y la sal.',
      // FR: Verse bouillant pour **couvrir entièrement** le fenouil, ferme et laisse refroidir avant de mettre au réfrigérateur.
      'Vierte hirviendo para **cubrir por completo** el hinojo, cierra y deja enfriar antes de guardar en la nevera.',
    ],
  ),
  'fenouil/Lamelles de fenouil blanchies': RecipeText(
    // FR: Lamelles de fenouil blanchies
    name: 'Láminas de hinojo escaldadas',
    // FR: Blanchi trois minutes, il est prêt pour un braisé ou un gratin, même hors saison.
    description: 'Escaldado tres minutos, está listo para un estofado o un gratinado, incluso fuera de temporada.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '6 bulbos de hinojo', // FR: 6 bulbes de fenouil
      'sal gruesa', // FR: gros sel
      'un bol grande de agua con hielo', // FR: un grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les tiges et la base, puis taille les bulbes en lamelles d'un centimètre ou en huit quartiers.
      'Corta los tallos y la base, y luego corta los bulbos en láminas de un centímetro o en ocho cuartos.',
      // FR: Plonge-les dans une grande eau salée bouillante, **3 minutes**.
      'Sumérgelas en una olla grande de agua con sal hirviendo, **3 minutos**.',
      // FR: Transfère-les aussitôt dans l'eau glacée, jusqu'à ce qu'elles soient froides à cœur.
      'Pásalas enseguida al agua con hielo, hasta que estén frías por dentro.',
      // FR: Égoutte et sèche-les dans un torchon, en les tamponnant bien.
      'Escurre y sécalas con un paño, dándoles toquecitos.',
      // FR: Étale sur une plaque, congèle 2 heures, puis mets en sacs. Décongelé, il est tendre : à cuire, pas à croquer cru.
      'Extiende en una bandeja, congela 2 horas y luego pásalas a bolsas. Descongelado está tierno: para cocinar, no para comer crudo y crujiente.',
    ],
  ),
  'fenouil/Fenouil fermenté au citron': RecipeText(
    // FR: Fenouil fermenté au citron
    name: 'Hinojo fermentado con limón',
    // FR: En saumure, le fenouil prend une acidité douce qui calme son anis, avec un parfum de citron.
    description: 'En salmuera, el hinojo adquiere una acidez suave que calma su anís, con aroma a limón.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '3 bulbos de hinojo', // FR: 3 bulbes de fenouil
      '1 limón sin tratar', // FR: 1 citron non traité
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '1 cucharadita de granos de pimienta', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Prépare la saumure : **30 g de sel dans 1 litre d'eau**, remue jusqu'à dissolution.
      'Prepara la salmuera: **30 g de sal en 1 litro de agua**, remueve hasta que se disuelva.',
      // FR: Taille le fenouil en lamelles épaisses de 5 mm et le citron en fines rondelles.
      'Corta el hinojo en láminas gruesas de 5 mm y el limón en rodajas finas.',
      // FR: Tasse les lamelles dans un bocal en glissant les rondelles de citron et le poivre, jusqu'à 3 cm du bord.
      'Aprieta las láminas en un tarro, intercalando las rodajas de limón y la pimienta, hasta 3 cm del borde.',
      // FR: Verse la saumure pour couvrir et pose un poids : **rien ne doit dépasser**, c'est ce qui dépasse qui moisit.
      'Vierte la salmuera para cubrir y pon un peso: **nada debe sobresalir**, lo que sobresale es lo que se enmohece.',
      // FR: Laisse fermenter 2 semaines à 18–22 °C, couvercle posé sans serrer. Goûte à partir du dixième jour.
      'Deja fermentar 2 semanas a 18–22 °C, con la tapa puesta sin apretar. Prueba a partir del décimo día.',
      // FR: Quand l'acidité te plaît, ferme bien et range au réfrigérateur.
      'Cuando la acidez te guste, cierra bien y guarda en la nevera.',
    ],
  ),
  'fenouil/Fenouil braisé à l\'orange': RecipeText(
    // FR: Fenouil braisé à l'orange
    name: 'Hinojo estofado a la naranja',
    // FR: L'orange contre l'anis du fenouil : un accord évident.
    description: 'La naranja contra el anís del hinojo: una combinación evidente.',
    ingredients: <String>[
      '4 bulbos de hinojo', // FR: 4 bulbes de fenouil
      '2 naranjas', // FR: 2 oranges
      '2 cucharadas de aceite de oliva', // FR: 2 cuillères à soupe d'huile d'olive
      '1 cucharadita de miel', // FR: 1 cuillère à café de miel
      'sal, pimienta, semillas de hinojo', // FR: sel, poivre, graines de fenouil
    ],
    steps: <String>[
      // FR: Coupe les bulbes en quartiers, garde un peu de coeur pour les tenir.
      'Corta los bulbos en cuartos, dejando un poco de corazón para que se sostengan.',
      // FR: Fais-les colorer à l'huile sur les deux faces.
      'Dóralos en el aceite por las dos caras.',
      // FR: Verse le jus des oranges, le miel, les graines, sale.
      'Vierte el zumo de las naranjas, la miel, las semillas y sala.',
      // FR: Couvre et braise 30 minutes à feu doux.
      'Tapa y estofa 30 minutos a fuego suave.',
      // FR: Découvre 5 minutes pour faire réduire le jus en sirop.
      'Destapa 5 minutos para que el jugo reduzca hasta quedar como un almíbar.',
    ],
  ),
  'fenouil/Salade de fenouil cru': RecipeText(
    // FR: Salade de fenouil cru
    name: 'Ensalada de hinojo crudo',
    // FR: Tranché à la mandoline, citron et huile : croquant et net.
    description: 'Cortado con mandolina, limón y aceite: crujiente y limpio.',
    ingredients: <String>[
      '2 bulbos de hinojo', // FR: 2 bulbes de fenouil
      '1 limón', // FR: 1 citron
      '4 cucharadas de aceite de oliva', // FR: 4 cuillères à soupe d'huile d'olive
      'parmesano en lascas', // FR: parmesan en copeaux
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Tranche le fenouil le plus fin possible, en travers du bulbe.
      'Lamina el hinojo lo más fino posible, a lo ancho del bulbo.',
      // FR: Arrose aussitôt de citron : il noircit sinon, comme une pomme.
      'Rocía enseguida con limón: si no, se ennegrece, como una manzana.',
      // FR: Huile, sel, poivre, mélange.
      'Aceite, sal, pimienta, mezcla.',
      // FR: Copeaux de parmesan dessus, et les petites plumes du fenouil.
      'Lascas de parmesano por encima, y las plumitas del hinojo.',
    ],
  ),
  'fenouil/Fenouil gratiné': RecipeText(
    // FR: Fenouil gratiné
    name: 'Hinojo gratinado',
    // FR: Précuit puis gratiné à la crème : il devient tout doux.
    description: 'Precocido y luego gratinado con nata: queda tierno y suave.',
    ingredients: <String>[
      '4 bulbos de hinojo', // FR: 4 bulbes de fenouil
      '20 cl de nata', // FR: 20 cl de crème
      '80 g de parmesano', // FR: 80 g de parmesan
      '2 cucharadas de pan rallado', // FR: 2 cuillères à soupe de chapelure
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Cuis les bulbes coupés en deux 20 minutes à l'eau salée.
      'Cuece los bulbos cortados por la mitad 20 minutos en agua con sal.',
      // FR: Égoutte-les bien, pose-les dans le plat.
      'Escúrrelos bien y colócalos en la fuente.',
      // FR: Nappe de crème, sel, poivre.
      'Cubre con la nata, sal, pimienta.',
      // FR: Parmesan et chapelure par-dessus.
      'Parmesano y pan rallado por encima.',
      // FR: Four à 200 °C, 25 minutes.
      'Horno a 200 °C, 25 minutos.',
    ],
  ),

  // ─────────── feve (6 recettes) ───────────
  'feve/Fèves écossées blanchies': RecipeText(
    // FR: Fèves écossées blanchies
    name: 'Habas desgranadas escaldadas',
    // FR: Blanchies trois minutes et congelées, elles se dérobent en un geste quand tu les sors en hiver.
    description: 'Escaldadas tres minutos y congeladas, salen de la bolsa de un solo gesto cuando las sacas en invierno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '3 kg de habas con vaina (alrededor de 1 kg desgranadas)', // FR: 3 kg de fèves en cosses (environ 1 kg écossées)
      'sal gruesa', // FR: gros sel
      'un bol grande de agua con hielo', // FR: un grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Écosse les fèves. Garde les petites et les moyennes, les grosses farineuses iront en purée.
      'Desgrana las habas. Quédate con las pequeñas y las medianas; las grandes y harinosas irán a puré.',
      // FR: Plonge-les dans une grande eau salée bouillante, **3 minutes**.
      'Sumérgelas en una olla grande de agua con sal hirviendo, **3 minutos**.',
      // FR: Transfère-les dans l'eau glacée, puis égoutte.
      'Pásalas al agua con hielo y luego escurre.',
      // FR: Si tu as le temps, retire la peau maintenant en pinçant le bout. Sinon, congèle-les avec, elle partira encore mieux après.
      'Si tienes tiempo, quita ahora la piel pellizcando la punta. Si no, congélalas con ella: saldrá aún mejor después.',
      // FR: Sèche-les, étale-les sur une plaque, congèle, puis mets en sacs.
      'Sécalas, extiéndelas en una bandeja, congela y luego pásalas a bolsas.',
    ],
  ),
  'feve/Fèves sèches pour l\'hiver': RecipeText(
    // FR: Fèves sèches pour l'hiver
    name: 'Habas secas para el invierno',
    // FR: Laissées mûrir sur pied, elles se gardent au placard et font une soupe épaisse ou des falafels en plein hiver.
    description: 'Dejadas madurar en la planta, se guardan en la despensa y dan una sopa espesa o falafels en pleno invierno.',
    // FR: 2 ans au sec, à l'abri de la lumière
    keeps: '2 años en seco, protegidas de la luz',
    ingredients: <String>[
      'las vainas de final de temporada, ennegrecidas en la planta', // FR: les cosses de fin de saison, noircies sur pied
      'tarros bien secos', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Laisse les dernières cosses sur les pieds jusqu'à ce qu'elles soient **noires et sèches**.
      'Deja las últimas vainas en las plantas hasta que estén **negras y secas**.',
      // FR: Cueille-les par temps sec et écosse-les. Écarte les graines percées ou moisies.
      'Recógelas en tiempo seco y desgránalas. Aparta las semillas agujereadas o enmohecidas.',
      // FR: Étale les fèves en une couche sur un plateau, à l'air et à l'abri, et laisse-les finir de sécher 2 semaines.
      'Extiende las habas en una sola capa sobre una bandeja, al aire y a cubierto, y déjalas acabar de secar 2 semanas.',
      // FR: Passe-les 48 heures au congélateur pour tuer les éventuels œufs de bruches.
      'Pásalas 48 horas por el congelador para matar los posibles huevos de gorgojo.',
      // FR: Mets-les en bocaux fermés. Pour les manger : trempage une nuit, puis cuisson 1 h 30 environ, **toujours bien cuites**.
      'Guárdalas en tarros cerrados. Para comerlas: remojo de una noche y luego cocción de 1 h 30 aproximadamente, **siempre bien cocidas**.',
    ],
  ),
  'feve/Falafels de fèves crus à congeler': RecipeText(
    // FR: Falafels de fèves crus à congeler
    name: 'Falafels de habas crudos para congelar',
    // FR: Les ta'ameya égyptiens : formés crus et congelés, ils vont tout droit du congélateur à la friture.
    description: 'Los ta\'ameya egipcios: formados crudos y congelados, van directos del congelador a la fritura.',
    // FR: 4 mois au congélateur
    keeps: '4 meses en el congelador',
    ingredients: <String>[
      '500 g de habas secas partidas y peladas', // FR: 500 g de fèves sèches cassées et pelées
      '1 cebolla', // FR: 1 oignon
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '1 manojo de perejil y 1 de cilantro', // FR: 1 bouquet de persil et 1 de coriandre
      '1 cucharada de comino, 1 cucharadita de sal', // FR: 1 cuillère à soupe de cumin, 1 cuillère à café de sel
    ],
    steps: <String>[
      // FR: La veille, fais tremper les fèves sèches dans un grand volume d'eau froide, 12 heures. Égoutte-les bien.
      'La víspera, deja las habas secas en remojo en abundante agua fría, 12 horas. Escúrrelas bien.',
      // FR: Mixe-les crues avec l'oignon, l'ail, les herbes, le cumin et le sel, jusqu'à une pâte granuleuse qui se tient.
      'Tritúralas crudas con la cebolla, el ajo, las hierbas, el comino y la sal, hasta obtener una pasta granulosa que se sostenga.',
      // FR: Laisse reposer la pâte au réfrigérateur, elle se raffermit.
      'Deja reposar la masa en la nevera: se endurece.',
      // FR: Forme des boulettes aplaties avec deux cuillères ou les mains mouillées.
      'Forma bolitas aplastadas con dos cucharas o con las manos mojadas.',
      // FR: Congèle-les sur une plaque sans qu'elles se touchent, puis mets-les en sac.
      'Congélalas en una bandeja sin que se toquen y luego pásalas a una bolsa.',
      // FR: Fais-les frire **encore gelées** à 170 °C, 5 à 6 minutes, jusqu'à ce qu'elles soient bien brunes et cuites à cœur.
      'Fríelas **aún congeladas** a 170 °C, de 5 a 6 minutos, hasta que estén bien doradas y hechas por dentro.',
    ],
  ),
  'feve/Fèves à la croque-sel': RecipeText(
    // FR: Fèves à la croque-sel
    name: 'Habas tiernas con sal',
    // FR: Jeunes et tendres, écossées et croquées crues. Le printemps.
    description: 'Jóvenes y tiernas, desgranadas y comidas crudas. La primavera.',
  ),
  'feve/Purée de fèves au cumin': RecipeText(
    // FR: Purée de fèves au cumin
    name: 'Puré de habas al comino',
    // FR: Épluchées deux fois, écrasées à l'huile d'olive.
    description: 'Peladas dos veces, aplastadas con aceite de oliva.',
  ),
  'feve/Fèves au chorizo': RecipeText(
    // FR: Fèves au chorizo
    name: 'Habas con chorizo',
    // FR: Mijotées avec du chorizo et des oignons nouveaux.
    description: 'Guisadas con chorizo y cebolletas.',
  ),

  // ─────────── figuier (6 recettes) ───────────
  'figuier/Figues séchées au four': RecipeText(
    // FR: Figues séchées au four
    name: 'Higos secos al horno',
    // FR: Un figuier donne tout en trois semaines : séchées, les figues durent jusqu'à Noël et au-delà.
    description: 'Una higuera da todo en tres semanas: secos, los higos duran hasta Navidad y más allá.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 meses en tarro, en lugar seco',
    ingredients: <String>[
      '2 kg de higos bien maduros pero no reventados', // FR: 2 kg de figues bien mûres mais pas éclatées
      'rejillas de horno', // FR: des grilles de four
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Rince les figues délicatement et sèche-les sur un torchon.
      'Enjuaga los higos con delicadeza y sécalos con un paño.',
      // FR: Coupe la queue et ouvre chaque figue en deux dans la hauteur.
      'Corta el rabillo y abre cada higo por la mitad a lo alto.',
      // FR: Pose-les côté chair vers le haut sur des grilles et sèche au four à **60 °C**, porte entrouverte.
      'Colócalos con la pulpa hacia arriba sobre rejillas y sécalos en el horno a **60 °C**, con la puerta entreabierta.',
      // FR: Teste : la figue est souple, un peu collante, et la chair ne rend plus de jus quand tu la presses.
      'Prueba: el higo está blando, un poco pegajoso, y la pulpa ya no suelta jugo al apretarla.',
      // FR: Laisse refroidir et mets en bocal. Secoue chaque jour une semaine : de la buée, et c'est retour au four.
      'Deja enfriar y pásalos a un tarro. Agítalo cada día durante una semana: si ves vaho, vuelven al horno.',
    ],
  ),
  'figuier/Figues entières congelées': RecipeText(
    // FR: Figues entières congelées
    name: 'Higos enteros congelados',
    // FR: Dix minutes et c'est fait : elles ressortent parfaites pour une compote, un gâteau ou un chutney.
    description: 'Diez minutos y listo: salen perfectos para una compota, un bizcocho o un chutney.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de higos maduros', // FR: 2 kg de figues mûres
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Rince les figues délicatement et sèche-les bien sur un torchon.
      'Enjuaga los higos con delicadeza y sécalos bien con un paño.',
      // FR: Coupe juste le bout de la queue. Garde-les entières, ou en deux si elles sont grosses.
      'Corta solo la punta del rabillo. Déjalos enteros, o por la mitad si son grandes.',
      // FR: Pose-les sur une plaque sans qu'elles se touchent et congèle 3 heures.
      'Colócalos en una bandeja sin que se toquen y congela 3 horas.',
      // FR: Verse-les en sac une fois dures. Décongelées elles sont molles : **à cuire**, pas à servir crues.
      'Pásalos a una bolsa cuando estén duros. Descongelados quedan blandos: **para cocinar**, no para servir crudos.',
    ],
  ),
  'figuier/Chutney de figues aux oignons': RecipeText(
    // FR: Chutney de figues aux oignons
    name: 'Chutney de higos y cebolla',
    // FR: Sucré, acidulé, un peu épicé : le pot qui accompagne le fromage et les terrines tout l'hiver.
    description: 'Dulce, ácido, algo especiado: el tarro que acompaña al queso y a los patés todo el invierno.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierto en la nevera',
    ingredients: <String>[
      '1 kg de higos', // FR: 1 kg de figues
      '2 cebollas', // FR: 2 oignons
      '250 g de azúcar moreno', // FR: 250 g de sucre roux
      '25 cl de vinagre de sidra', // FR: 25 cl de vinaigre de cidre
      '1 cucharadita de jengibre rallado, 1 cucharadita de sal', // FR: 1 cuillère à café de gingembre râpé, 1 cuillère à café de sel
      '5 tarros con tapas nuevas', // FR: 5 pots avec couvercles neufs
    ],
    steps: <String>[
      // FR: Coupe les figues en quatre et émince finement les oignons.
      'Corta los higos en cuatro y lamina finamente las cebollas.',
      // FR: Mets tout dans une casserole à fond épais : figues, oignons, sucre, vinaigre, gingembre et sel.
      'Pon todo en un cazo de fondo grueso: higos, cebollas, azúcar, vinagre, jengibre y sal.',
      // FR: Laisse cuire à petit feu, à découvert, en remuant souvent : le chutney est prêt quand la cuillère laisse un sillon au fond.
      'Deja cocer a fuego lento, sin tapar, removiendo a menudo: el chutney está listo cuando la cuchara deja un surco en el fondo.',
      // FR: Remplis les pots propres de chutney bouillant **jusqu'à 2 cm du bord** et ferme avec des couvercles neufs.
      'Llena los tarros limpios con el chutney hirviendo **hasta 2 cm del borde** y cierra con tapas nuevas.',
      // FR: Stérilise les pots couverts d'eau, 20 minutes à partir de l'ébullition, et vérifie le vide en refroidissant.
      'Esteriliza los tarros cubiertos de agua, 20 minutos desde que hierva, y comprueba el vacío al enfriarse.',
      // FR: Attends au moins 3 semaines avant d'ouvrir : le vinaigre s'adoucit et les goûts se marient.
      'Espera al menos 3 semanas antes de abrir: el vinagre se suaviza y los sabores se funden.',
    ],
  ),
  'figuier/Figues rôties au miel': RecipeText(
    // FR: Figues rôties au miel
    name: 'Higos asados con miel',
    // FR: Ouvertes en croix, dix minutes de four, avec du chèvre.
    description: 'Abiertos en cruz, diez minutos de horno, con queso de cabra.',
  ),
  'figuier/Confiture de figues': RecipeText(
    // FR: Confiture de figues
    name: 'Mermelada de higos',
    // FR: Avec un citron entier confit dedans.
    description: 'Con un limón entero confitado dentro.',
  ),
  'figuier/Tarte aux figues et romarin': RecipeText(
    // FR: Tarte aux figues et romarin
    name: 'Tarta de higos y romero',
    // FR: Le romarin du jardin, posé entier sur la tarte.
    description: 'El romero del huerto, puesto entero sobre la tarta.',
  ),

  // ─────────── fonio (6 recettes) ───────────
  'fonio/Fonio séché et battu': RecipeText(
    // FR: Fonio séché et battu
    name: 'Fonio seco y trillado',
    // FR: Ce tout petit grain se garde des années s'il est bien sec : c'est la première chose à faire après la récolte.
    description: 'Este granito diminuto se conserva años si está bien seco: es lo primero que hay que hacer tras la cosecha.',
    // FR: 2 ans au sec, à l'abri des insectes
    keeps: '2 años en seco, a salvo de los insectos',
    ingredients: <String>[
      'los manojos de fonio cortados en su punto', // FR: les bottes de fonio coupées à maturité
      'una lona o una sábana limpia', // FR: une bâche ou un drap propre
      'sacos o bidones herméticos', // FR: des sacs ou fûts hermétiques
    ],
    steps: <String>[
      // FR: Fauche le fonio quand les épillets sont dorés et que le grain se détache sous le doigt. Fais des bottes.
      'Siega el fonio cuando las espiguillas estén doradas y el grano se desprenda al roce del dedo. Haz manojos.',
      // FR: Laisse sécher les bottes debout ou étalées au soleil une semaine, rentrées le soir.
      'Deja secar los manojos de pie o extendidos al sol una semana, y recógelos por la noche.',
      // FR: Teste : le grain sonne sec et s'égrène facilement entre les doigts.
      'Prueba: el grano suena seco y se desgrana fácilmente entre los dedos.',
      // FR: Bats les bottes sur la bâche ou foule-les au pied pour faire tomber le grain.
      'Golpea los manojos sobre la lona o písalos para que caiga el grano.',
      // FR: Vanne doucement : le grain est si léger qu'il faut verser de peu haut, par vent faible.
      'Aventa con suavidad: el grano es tan ligero que hay que verterlo desde poca altura, con viento flojo.',
      // FR: Stocke le grain vêtu dans des sacs hermétiques, au frais et au sec. Tu le décortiqueras au fur et à mesure.
      'Guarda el grano con cáscara en sacos herméticos, en un lugar fresco y seco. Lo descascarillarás poco a poco.',
    ],
  ),
  'fonio/Fonio précuit séché': RecipeText(
    // FR: Fonio précuit séché
    name: 'Fonio precocido y seco',
    // FR: Lavé, cuit une fois à la vapeur puis séché : il se prépare ensuite en cinq minutes, comme le fonio du commerce.
    description: 'Lavado, cocido una vez al vapor y luego secado: después se prepara en cinco minutos, como el fonio del súper.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegido de la luz',
    ingredients: <String>[
      '1 kg de fonio descascarillado', // FR: 1 kg de fonio décortiqué
      'agua', // FR: de l'eau
      'una olla de cuscús', // FR: un couscoussier
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Lave le fonio dans un grand saladier, au moins **trois eaux**, en le laissant décanter : le sable reste au fond, verse le grain par-dessus.
      'Lava el fonio en un bol grande, al menos **tres aguas**, dejándolo decantar: la arena se queda en el fondo, vierte el grano por encima.',
      // FR: Égoutte-le dans un tissu fin et laisse-le gonfler 15 minutes.
      'Escúrrelo en un paño fino y déjalo hincharse 15 minutos.',
      // FR: Cuis-le à la vapeur dans le haut du couscoussier, sans couvercle.
      'Cuécelo al vapor en la parte alta de la olla de cuscús, sin tapa.',
      // FR: Égrène-le à la fourchette pour casser toutes les mottes.
      'Desgránalo con un tenedor para deshacer todos los grumos.',
      // FR: Étale-le en couche fine et sèche au four à 50 °C, porte entrouverte, en remuant de temps en temps.
      'Extiéndelo en capa fina y sécalo en el horno a 50 °C, con la puerta entreabierta, removiendo de vez en cuando.',
      // FR: Quand il coule entre les doigts comme du sable sec, mets-le en bocal hermétique.
      'Cuando se deslice entre los dedos como arena seca, pásalo a un tarro hermético.',
    ],
  ),
  'fonio/Fonio vapeur en portions congelées': RecipeText(
    // FR: Fonio vapeur en portions congelées
    name: 'Fonio al vapor en porciones congeladas',
    // FR: Une grande vapeur le dimanche, et tout le mois des portions qui se réchauffent en trois minutes.
    description: 'Un buen vapor el domingo, y todo el mes tendrás porciones que se recalientan en tres minutos.',
    // FR: 4 mois au congélateur
    keeps: '4 meses en el congelador',
    ingredients: <String>[
      '500 g de fonio descascarillado', // FR: 500 g de fonio décortiqué
      '1 cucharada de aceite', // FR: 1 cuillère à soupe d'huile
      '1 pizca de sal', // FR: 1 pincée de sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave le fonio dans au moins trois eaux, en le laissant décanter pour laisser le sable au fond.
      'Lava el fonio en al menos tres aguas, dejándolo decantar para que la arena se quede en el fondo.',
      // FR: Cuis-le à la vapeur dans le couscoussier, sans couvercle.
      'Cuécelo al vapor en la olla de cuscús, sin tapa.',
      // FR: Verse-le dans un plat, ajoute l'huile et le sel, et égrène à la fourchette.
      'Viértelo en una fuente, añade el aceite y la sal, y desgrana con un tenedor.',
      // FR: Laisse refroidir complètement à plat, en remuant pour qu'il ne colle pas.
      'Deja enfriar del todo extendido, removiendo para que no se pegue.',
      // FR: Répartis en sacs à plat, une portion par sac, et chasse l'air.
      'Reparte en bolsas planas, una ración por bolsa, y saca el aire.',
      // FR: Réchauffe-le encore gelé 3 minutes à la vapeur ou à la poêle avec une cuillère d'eau.
      'Recaliéntalo aún congelado 3 minutos al vapor o en la sartén con una cucharada de agua.',
    ],
  ),
  'fonio/Fonio aux légumes': RecipeText(
    // FR: Fonio aux légumes
    name: 'Fonio con verduras',
    // FR: Cuit à la vapeur, grains détachés, avec les légumes du jour.
    description: 'Cocido al vapor, con los granos sueltos, con las verduras del día.',
  ),
  'fonio/Couscous de fonio': RecipeText(
    // FR: Couscous de fonio
    name: 'Cuscús de fonio',
    // FR: La petite graine dorée cuite vapeur, légère et délicate, fierté du Fouta.
    description: 'La pequeña semilla dorada cocida al vapor, ligera y delicada, orgullo del Fouta.',
  ),
  'fonio/Djouka de fonio': RecipeText(
    // FR: Djouka de fonio
    name: 'Djouka de fonio',
    // FR: Le fonio à la poudre d'arachide, un délice malien simple et parfumé.
    description: 'El fonio con polvo de cacahuete, un manjar maliense sencillo y aromático.',
  ),

  // ─────────── fraise (5 recettes) ───────────
  'fraise/Confiture de fraises': RecipeText(
    // FR: Confiture de fraises
    name: 'Mermelada de fresas',
    // FR: 700 g de sucre par kilo de fruits, un citron, et la cuisine sent l'été.
    description: '700 g de azúcar por kilo de fruta, un limón, y la cocina huele a verano.',
    // FR: 2 ans au placard
    keeps: '2 años en la despensa',
    ingredients: <String>[
      '1 kg de fresas sin rabillo', // FR: 1 kg de fraises équeutées
      '700 g de azúcar', // FR: 700 g de sucre
      'el zumo de un limón', // FR: le jus d'un citron
    ],
    steps: <String>[
      // FR: Coupe les grosses fraises en deux, laisse les petites entières.
      'Corta por la mitad las fresas grandes y deja enteras las pequeñas.',
      // FR: Mélange-les au sucre et au citron, laisse macérer au frais. Le jus sort tout seul.
      'Mézclalas con el azúcar y el limón, déjalas macerar en un sitio fresco. El jugo sale solo.',
      // FR: Porte à ébullition et cuis à feu vif en écumant.
      'Lleva a ebullición y cuece a fuego fuerte espumando.',
      // FR: Teste sur une assiette froide : une goutte qui se fige est prête. Le citron apporte la pectine qui fait prendre.
      'Prueba en un plato frío: una gota que cuaja está lista. El limón aporta la pectina que hace que cuaje.',
      // FR: Mets en pots chauds, ferme et retourne jusqu'à refroidissement.
      'Pasa a tarros calientes, cierra y ponlos boca abajo hasta que se enfríen.',
    ],
  ),
  'fraise/Fraises congelées sur plaque': RecipeText(
    // FR: Fraises congelées sur plaque
    name: 'Fresas congeladas en bandeja',
    // FR: Un quart d'heure, et tu as des fraises qui ne forment pas un bloc.
    description: 'Un cuarto de hora, y tienes fresas que no forman un bloque.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      'fresas bien maduras pero firmes', // FR: des fraises bien mûres mais fermes
      'bolsas o recipientes de congelación', // FR: des sacs ou boîtes de congélation
    ],
    steps: <String>[
      // FR: Lave les fraises **avant** de les équeuter : par la blessure, elles se gorgent d'eau.
      'Lava las fresas **antes** de quitarles el rabillo: por la herida se empapan de agua.',
      // FR: Sèche-les une par une sur un torchon. Toute goutte restée devient du givre.
      'Sécalas una a una con un paño. Cada gota que quede se convierte en escarcha.',
      // FR: Équeute-les, laisse-les entières.
      'Quítales el rabillo y déjalas enteras.',
      // FR: Étale-les sur une plaque **sans qu'elles se touchent**, et congèle 3 heures.
      'Extiéndelas en una bandeja **sin que se toquen**, y congela 3 horas.',
      // FR: Verse-les en sac une fois dures. C'est la congélation en deux temps qui évite la motte de fraises soudées.
      'Pásalas a una bolsa cuando estén duras. La congelación en dos tiempos es lo que evita la masa de fresas pegadas.',
      // FR: À l'usage : décongelées elles sont molles, donc pour les smoothies, coulis et gâteaux — pas pour une tarte crue.
      'Al usarlas: descongeladas están blandas, así que sirven para batidos, coulis y pasteles, no para una tarta cruda.',
    ],
  ),
  'fraise/Sirop de fraises': RecipeText(
    // FR: Sirop de fraises
    name: 'Sirope de fresa',
    // FR: Le jus pressé, cuit au sucre et mis en bouteille : tout l'été dans un verre d'eau.
    description: 'El jugo prensado, cocido con azúcar y embotellado: todo el verano en un vaso de agua.',
    // FR: 1 an au placard, 3 semaines ouvert
    keeps: '1 año en la despensa, 3 semanas abierto',
    ingredients: <String>[
      '1,5 kg de fresas', // FR: 1,5 kg de fraises
      '1 kg de azúcar', // FR: 1 kg de sucre
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      'unas hojas de menta', // FR: quelques feuilles de menthe
    ],
    steps: <String>[
      // FR: Équeute les fraises, écrase-les grossièrement à la fourchette.
      'Quita el rabillo a las fresas y aplástalas bastamente con un tenedor.',
      // FR: Laisse-les rendre leur jus 2 heures avec le citron, à température ambiante.
      'Déjalas soltar su jugo 2 horas con el limón, a temperatura ambiente.',
      // FR: Verse dans un torchon propre et presse. Ne filtre pas au mixeur : le sirop deviendrait trouble.
      'Viértelo en un paño limpio y exprime. No lo pases por la batidora: el sirope quedaría turbio.',
      // FR: Pèse le jus, ajoute autant de sucre que de jus, et porte doucement à ébullition.
      'Pesa el jugo, añade tanto azúcar como jugo y lleva despacio a ebullición.',
      // FR: Cuis 10 minutes en écumant. Le sirop doit napper légèrement.
      'Cuece 10 minutos espumando. El sirope debe cubrir ligeramente la cuchara.',
      // FR: Jette la menthe dedans hors du feu, 5 minutes.
      'Echa la menta dentro fuera del fuego, 5 minutos.',
      // FR: Mets en bouteilles ébouillantées, remplies à ras, et ferme aussitôt. Debout, au frais et à l'ombre.
      'Pasa a botellas escaldadas, llénalas hasta el borde y cierra enseguida. De pie, en un sitio fresco y a la sombra.',
    ],
  ),
  'fraise/Tarte aux fraises': RecipeText(
    // FR: Tarte aux fraises
    name: 'Tarta de fresas',
    // FR: Pâte sablée, crème pâtissière, fraises crues rangées dessus.
    description: 'Masa sablée, crema pastelera, fresas crudas colocadas encima.',
    ingredients: <String>[
      '1 masa sablée', // FR: 1 pâte sablée
      '600 g de fresas', // FR: 600 g de fraises
      '50 cl de leche', // FR: 50 cl de lait
      '4 yemas de huevo, 100 g de azúcar', // FR: 4 jaunes d'oeufs, 100 g de sucre
      '50 g de maicena, 1 vaina de vainilla', // FR: 50 g de maïzena, 1 gousse de vanille
      '2 cucharadas de jalea de grosella', // FR: 2 cuillères à soupe de gelée de groseille
    ],
    steps: <String>[
      // FR: Étale la pâte, pique-la, couvre-la de papier et de légumes secs.
      'Extiende la masa, pínchala y cúbrela con papel y legumbres secas.',
      // FR: Cuis-la **à blanc** 25 minutes à 180 °C : une pâte crue sous la crème détrempe en une heure.
      'Cuécela **en blanco** 25 minutos a 180 °C: una masa cruda bajo la crema se empapa en una hora.',
      // FR: Fais chauffer le lait avec la vanille fendue.
      'Calienta la leche con la vainilla abierta por la mitad.',
      // FR: Fouette jaunes, sucre et maïzena, puis verse le lait chaud dessus en remuant.
      'Bate las yemas, el azúcar y la maicena, y vierte encima la leche caliente removiendo.',
      // FR: Remets sur le feu et fouette **sans arrêt** jusqu'à ce que ça épaississe. Dès les premiers bouillons, c'est prêt.
      'Vuelve a ponerla al fuego y bate **sin parar** hasta que espese. En cuanto rompa a hervir, está lista.',
      // FR: Verse la crème sur une assiette, filme au contact, et laisse refroidir complètement.
      'Vierte la crema en un plato, cúbrela con film a ras y déjala enfriar del todo.',
      // FR: Garnis le fond de crème lissée, range les fraises coupées en deux, pointe vers le haut.
      'Cubre el fondo con la crema alisada, coloca las fresas cortadas por la mitad con la punta hacia arriba.',
      // FR: Fais fondre la gelée avec une cuillère d'eau et badigeonne les fraises : c'est ce qui les fait briller.
      'Derrite la jalea con una cucharada de agua y pinta las fresas: eso es lo que las hace brillar.',
    ],
  ),
  'fraise/Fraises au sucre et menthe': RecipeText(
    // FR: Fraises au sucre et menthe
    name: 'Fresas con azúcar y menta',
    // FR: Coupées une heure avant, elles rendent un sirop qu'on sauce au pain.
    description: 'Cortadas una hora antes, sueltan un almíbar para mojar pan.',
    ingredients: <String>[
      '500 g de fresas', // FR: 500 g de fraises
      '2 cucharadas de azúcar', // FR: 2 cuillères à soupe de sucre
      'unas diez hojas de menta', // FR: une dizaine de feuilles de menthe
      '1/2 limón', // FR: 1/2 citron
    ],
    steps: <String>[
      // FR: Lave les fraises **avant** de les équeuter, sinon elles se gorgent d'eau par la blessure.
      'Lava las fresas **antes** de quitarles el rabillo; si no, se empapan de agua por la herida.',
      // FR: Équeute-les et coupe-les en deux ou en quatre.
      'Quítales el rabillo y córtalas en dos o en cuatro.',
      // FR: Sucre-les, ajoute un trait de citron, mélange une fois.
      'Ponles azúcar, un chorrito de limón, mezcla una vez.',
      // FR: Laisse-les une heure à température ambiante : le sucre tire le jus et fait le sirop. Au réfrigérateur, ça ne marche qu'à moitié.
      'Déjalas una hora a temperatura ambiente: el azúcar saca el jugo y hace el almíbar. En la nevera solo funciona a medias.',
      // FR: Déchire la menthe à la main juste avant de servir.
      'Rompe la menta con la mano justo antes de servir.',
    ],
  ),

  // ─────────── framboisier (6 recettes) ───────────
  'framboisier/Framboises congelées une à une': RecipeText(
    // FR: Framboises congelées une à une
    name: 'Frambuesas congeladas una a una',
    // FR: Fragiles comme tout, les framboises tiennent un an au froid si on les congèle sans les laver.
    description: 'Frágiles como pocas, las frambuesas aguantan un año en frío si las congelas sin lavarlas.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '1 kg de frambuesas', // FR: 1 kg de framboises
      'bolsas o recipientes de congelación', // FR: des sacs ou boîtes de congélation
    ],
    steps: <String>[
      // FR: Trie les framboises et écarte celles qui sont moisies ou écrasées.
      'Selecciona las frambuesas y aparta las enmohecidas o aplastadas.',
      // FR: **Ne les lave pas** : elles boivent l'eau comme une éponge et deviennent de la bouillie au dégel.
      '**No las laves**: absorben el agua como una esponja y se vuelven papilla al descongelarse.',
      // FR: Étale-les sur une plaque, sans qu'elles se touchent, et congèle 2 heures.
      'Extiéndelas en una bandeja, sin que se toquen, y congela 2 horas.',
      // FR: Verse-les délicatement en boîte une fois dures, elles se cassent moins qu'en sac.
      'Pásalas con delicadeza a un recipiente cuando estén duras, se rompen menos que en bolsa.',
    ],
  ),
  'framboisier/Gelée de framboises sans pépins': RecipeText(
    // FR: Gelée de framboises sans pépins
    name: 'Jalea de frambuesa sin pepitas',
    // FR: Tout le goût de la framboise, sans un seul pépin sous la dent : la reine des tartines.
    description: 'Todo el sabor de la frambuesa, sin una sola pepita entre los dientes: la reina de las tostadas.',
    // FR: 1 an au placard, 3 semaines ouvert au réfrigérateur
    keeps: '1 año en la despensa, 3 semanas abierto en la nevera',
    ingredients: <String>[
      '1,5 kg de frambuesas', // FR: 1,5 kg de framboises
      '800 g de azúcar por kilo de puré', // FR: 800 g de sucre par kilo de purée
      'el zumo de un limón', // FR: le jus d'un citron
      '5 tarros de mermelada', // FR: 5 pots de confiture
    ],
    steps: <String>[
      // FR: Fais éclater les framboises à feu doux, à couvert, en remuant.
      'Haz que las frambuesas se abran a fuego suave, tapadas, removiendo.',
      // FR: Passe-les au moulin à légumes grille fine, ou presse-les à travers un tamis : les pépins restent dedans.
      'Pásalas por el pasapurés de rejilla fina, o exprímelas a través de un tamiz: las pepitas se quedan dentro.',
      // FR: Pèse la purée, ajoute 800 g de sucre par kilo et le jus de citron, puis porte à ébullition.
      'Pesa el puré, añade 800 g de azúcar por kilo y el zumo de limón, y lleva a ebullición.',
      // FR: Cuis à gros bouillons en écumant. La framboise manque de pectine, c'est le **citron** qui fait prendre.
      'Cuece a borbotones espumando. A la frambuesa le falta pectina, es el **limón** el que hace que cuaje.',
      // FR: Teste sur une assiette froide : une goutte qui se fige est prête.
      'Prueba en un plato frío: una gota que cuaja está lista.',
      // FR: Mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pasa a tarros escaldados, cierra y ponlos boca abajo hasta que se enfríen.',
    ],
  ),
  'framboisier/Vinaigre de framboise': RecipeText(
    // FR: Vinaigre de framboise
    name: 'Vinagre de frambuesa',
    // FR: Les framboises un peu fatiguées font le meilleur vinaigre : un trait suffit à réveiller une salade.
    description: 'Las frambuesas algo pasadas hacen el mejor vinagre: un chorrito basta para despertar una ensalada.',
    // FR: 1 an au placard
    keeps: '1 año en la despensa',
    ingredients: <String>[
      '300 g de frambuesas', // FR: 300 g de framboises
      '50 cl de vinagre de vino blanco o de sidra al 6 % como mínimo', // FR: 50 cl de vinaigre de vin blanc ou de cidre à 6 % minimum
      '1 tarro limpio', // FR: 1 bocal propre
      '2 botellas de 25 cl', // FR: 2 bouteilles de 25 cl
    ],
    steps: <String>[
      // FR: Trie les framboises et écarte celles qui sont moisies. Celles qui sont abîmées mais saines font très bien l'affaire.
      'Selecciona las frambuesas y aparta las enmohecidas. Las estropeadas pero sanas valen perfectamente.',
      // FR: Mets-les dans le bocal et écrase-les légèrement à la fourchette.
      'Ponlas en el tarro y aplástalas ligeramente con un tenedor.',
      // FR: Verse le vinaigre dessus : les fruits doivent être **entièrement couverts**. Ferme.
      'Vierte el vinagre encima: la fruta debe quedar **totalmente cubierta**. Cierra.',
      // FR: Laisse macérer 2 semaines à l'abri de la lumière, en secouant le bocal tous les deux jours.
      'Deja macerar 2 semanas protegido de la luz, agitando el tarro cada dos días.',
      // FR: Filtre à travers un linge fin, sans presser trop fort pour garder un vinaigre clair.
      'Filtra con un paño fino, sin apretar demasiado para conservar un vinagre claro.',
      // FR: Mets en bouteilles propres, bouche et garde à l'abri de la lumière : elle fait passer la couleur.
      'Pasa a botellas limpias, tapa y guarda lejos de la luz, que le hace perder el color.',
    ],
  ),
  'framboisier/Coulis de framboises': RecipeText(
    // FR: Coulis de framboises
    name: 'Coulis de frambuesa',
    // FR: Mixées crues, passées au tamis. Rien ne se perd du parfum.
    description: 'Trituradas en crudo, pasadas por el tamiz. No se pierde nada del aroma.',
  ),
  'framboisier/Confiture de framboises': RecipeText(
    // FR: Confiture de framboises
    name: 'Mermelada de frambuesa',
    // FR: Cuisson courte, pour garder le goût de la cueillette.
    description: 'Cocción corta, para conservar el sabor de la recolección.',
  ),
  'framboisier/Framboisier': RecipeText(
    // FR: Framboisier
    name: 'Framboisier (pastel de frambuesas)',
    // FR: Génoise, crème mousseline, framboises debout sur le pourtour.
    description: 'Bizcocho genovés, crema mousselina, frambuesas de pie por todo el borde.',
  ),

  // ─────────── gingembre (6 recettes) ───────────
  'gingembre/Gingembre entier au congélateur': RecipeText(
    // FR: Gingembre entier au congélateur
    name: 'Jengibre entero en el congelador',
    // FR: Dix minutes, et tu râpes ton gingembre gelé sans même l'éplucher : plus fin, plus parfumé, plus de fibres.
    description: 'Diez minutos, y ralla tu jengibre congelado sin siquiera pelarlo: más fino, más aromático, sin fibras.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      'raíces de jengibre bien firmes', // FR: des racines de gingembre bien fermes
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Brosse les racines sous l'eau pour enlever la terre entre les doigts du rhizome.
      'Cepilla las raíces bajo el agua para quitar la tierra entre los dedos del rizoma.',
      // FR: Sèche-les parfaitement dans un torchon.
      'Sécalas perfectamente con un paño.',
      // FR: Coupe en morceaux de 4 cm, la taille d'une utilisation.
      'Corta en trozos de 4 cm, el tamaño de un uso.',
      // FR: Mets-les en sac, chasse l'air et congèle. Râpe-les **encore gelés** avec la peau, à la râpe fine.
      'Ponlos en una bolsa, saca el aire y congela. Ralla **aún congelados**, con la piel, con el rallador fino.',
    ],
  ),
  'gingembre/Gingembre mariné au vinaigre': RecipeText(
    // FR: Gingembre mariné au vinaigre
    name: 'Jengibre en vinagre',
    // FR: Tranché très fin et mariné, le jeune gingembre devient rose pâle et croquant, comme celui des sushis.
    description: 'Cortado muy fino y macerado, el jengibre joven se vuelve rosa pálido y crujiente, como el del sushi.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 meses en la nevera',
    ingredients: <String>[
      '250 g de jengibre joven, de piel fina', // FR: 250 g de gingembre jeune, à peau fine
      '1 cucharadita de sal', // FR: 1 cuillère à café de sel
      '20 cl de vinagre blanco o de sidra al 6 %', // FR: 20 cl de vinaigre blanc ou de cidre à 6 %
      '60 g de azúcar', // FR: 60 g de sucre
    ],
    steps: <String>[
      // FR: Gratte la peau avec une cuillère et coupe le gingembre en lamelles très fines, à l'économe ou à la mandoline.
      'Raspa la piel con una cuchara y corta el jengibre en láminas muy finas, con pelador o con mandolina.',
      // FR: Mélange avec le sel et laisse dégorger.
      'Mezcla con la sal y deja que suelte agua.',
      // FR: Blanchis les lamelles 30 secondes dans l'eau bouillante, puis égoutte bien en pressant.
      'Escalda las láminas 30 segundos en agua hirviendo y luego escurre bien apretando.',
      // FR: Fais chauffer le vinaigre et le sucre jusqu'à ce que le sucre fonde.
      'Calienta el vinagre y el azúcar hasta que el azúcar se disuelva.',
      // FR: Tasse le gingembre dans un bocal ébouillanté et verse le vinaigre chaud jusqu'à **le couvrir entièrement**.
      'Aprieta el jengibre en un tarro escaldado y vierte el vinagre caliente hasta **cubrirlo por completo**.',
      // FR: Ferme, laisse refroidir, puis au réfrigérateur. Il est prêt au bout de 3 jours.
      'Cierra, deja enfriar y guarda en la nevera. Está listo al cabo de 3 días.',
    ],
  ),
  'gingembre/Gingembre séché en poudre': RecipeText(
    // FR: Gingembre séché en poudre
    name: 'Jengibre seco en polvo',
    // FR: Séché puis moulu, il se garde un an au placard et parfume biscuits, épices et boissons chaudes.
    description: 'Seco y molido, se conserva un año en la despensa y perfuma galletas, especias y bebidas calientes.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      '500 g de jengibre', // FR: 500 g de gingembre
      'un tarro hermético bien seco', // FR: un bocal hermétique bien sec
    ],
    steps: <String>[
      // FR: Brosse le gingembre sous l'eau et sèche-le.
      'Cepilla el jengibre bajo el agua y sécalo.',
      // FR: Gratte la peau à la cuillère et coupe en tranches de 2 mm, toutes de la même épaisseur.
      'Raspa la piel con una cuchara y corta en rodajas de 2 mm, todas del mismo grosor.',
      // FR: Étale en une couche et sèche à **50 °C**, porte entrouverte, jusqu'à ce que les tranches cassent net.
      'Extiéndelo en una capa y sécalo a **50 °C**, con la puerta entreabierta, hasta que las rodajas se partan limpiamente.',
      // FR: Laisse refroidir complètement : chaudes, elles reprennent l'humidité et collent au mixeur.
      'Deja enfriar del todo: calientes, recuperan la humedad y se pegan a la batidora.',
      // FR: Mixe en poudre fine et passe au tamis.
      'Tritura hasta obtener un polvo fino y pásalo por el tamiz.',
      // FR: Mets en bocal hermétique, à l'abri de la lumière.
      'Guárdalo en un tarro hermético, lejos de la luz.',
    ],
  ),
  'gingembre/Gingembre confit': RecipeText(
    // FR: Gingembre confit
    name: 'Jengibre confitado',
    // FR: En lamelles, cuites dans un sirop, puis roulées au sucre.
    description: 'En láminas, cocidas en un almíbar y luego rebozadas en azúcar.',
  ),
  'gingembre/Gnamakoudji': RecipeText(
    // FR: Gnamakoudji
    name: 'Gnamakoudji',
    // FR: Le jus de gingembre frais qui pique et réveille, incontournable des marchés.
    description: 'El zumo de jengibre fresco que pica y despierta, imprescindible en los mercados.',
  ),
  'gingembre/Tisane gingembre-citron': RecipeText(
    // FR: Tisane gingembre-citron
    name: 'Infusión de jengibre y limón',
    // FR: Une infusion chaude et tonique, parfaite quand la gorge gratte un peu.
    description: 'Una infusión caliente y tonificante, perfecta cuando pica un poco la garganta.',
  ),

  // ─────────── gombo (6 recettes) ───────────
  'gombo/Gombos blanchis entiers au congélateur': RecipeText(
    // FR: Gombos blanchis entiers au congélateur
    name: 'Okras escaldadas enteras para congelar',
    // FR: Blanchis entiers, ils gardent leur bave à l'intérieur : tu retrouves en hiver le gombo de la sauce, pas une purée.
    description: 'Escaldadas enteras, conservan su baba dentro: en invierno recuperas la okra de la salsa, no un puré.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1 kg de okras jóvenes, no más largas que un dedo', // FR: 1 kg de gombos jeunes, pas plus longs qu'un doigt
      '1 bol grande de agua con hielo', // FR: 1 grand saladier d'eau et de glaçons
      'sal gruesa', // FR: gros sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les gombos et frotte-les doucement entre tes mains pour enlever le duvet.
      'Lava las okras y frótalas suavemente entre las manos para quitarles la pelusilla.',
      // FR: Coupe juste le bout du pédoncule **sans ouvrir la capsule** : fermée, elle garde la bave dedans.
      'Corta solo la punta del pedúnculo **sin abrir la cápsula**: cerrada, mantiene la baba dentro.',
      // FR: Plonge-les dans une grande casserole d'eau bouillante salée. 3 minutes pour les petits, 4 pour les gros.
      'Sumérgelas en una olla grande de agua hirviendo con sal. 3 minutos las pequeñas, 4 las grandes.',
      // FR: Transfère-les aussitôt dans l'eau glacée, le même temps que la cuisson. C'est ce qui fixe le vert.
      'Pásalas enseguida al agua con hielo, el mismo tiempo que la cocción. Eso es lo que fija el verde.',
      // FR: Égoutte-les et sèche-les sur un torchon. Chaque goutte qui reste devient du givre.
      'Escúrrelas y sécalas con un paño. Cada gota que quede se convierte en escarcha.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent et congèle 2 heures, puis verse-les en sac.
      'Extiéndelas en una bandeja sin que se toquen y congela 2 horas, y luego pásalas a una bolsa.',
      // FR: À l'usage, coupe-les encore gelés en rondelles et jette-les directement dans la sauce chaude.
      'Al usarlas, córtalas aún congeladas en rodajas y échalas directamente a la salsa caliente.',
    ],
  ),
  'gombo/Gombos séchés en rondelles': RecipeText(
    // FR: Gombos séchés en rondelles
    name: 'Okras secas en rodajas',
    // FR: La façon sahélienne de garder le gombo toute l'année : séché, il se pile et épaissit les sauces comme du frais.
    description: 'La forma saheliana de conservar la okra todo el año: seca, se machaca y espesa las salsas como la fresca.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      '1 kg de okras jóvenes y tiernas', // FR: 1 kg de gombos jeunes et tendres
      'un tarro hermético bien seco', // FR: un bocal hermétique bien sec
    ],
    steps: <String>[
      // FR: Lave les gombos et **sèche-les complètement** avant de les couper, sinon ils collent au couteau.
      'Lava las okras y **sécalas por completo** antes de cortarlas; si no, se pegan al cuchillo.',
      // FR: Coupe-les en rondelles de 5 mm, pas plus épaisses : le centre doit sécher aussi vite que le bord.
      'Córtalas en rodajas de 5 mm, no más gruesas: el centro debe secarse tan rápido como el borde.',
      // FR: Étale-les en une seule couche sur des plaques et sèche à **60 °C**, porte du four entrouverte d'une cuillère en bois.
      'Extiéndelas en una sola capa sobre bandejas y sécalas a **60 °C**, con la puerta del horno entreabierta con una cuchara de madera.',
      // FR: Retourne-les à mi-séchage. Au soleil, compte 3 à 4 jours sous un voile, rentrés chaque soir.
      'Dales la vuelta a mitad del secado. Al sol, cuenta de 3 a 4 días bajo un velo, recogidas cada noche.',
      // FR: Teste : une rondelle refroidie doit casser net. Si elle plie, remets 1 heure.
      'Prueba: una rodaja ya fría debe partirse limpiamente. Si se dobla, vuelve a ponerla 1 hora.',
      // FR: Laisse refroidir et mets en bocal hermétique. Pile ou mixe une poignée au moment de faire la sauce.
      'Deja enfriar y pasa a un tarro hermético. Machaca o tritura un puñado en el momento de hacer la salsa.',
    ],
  ),
  'gombo/Petits gombos au vinaigre': RecipeText(
    // FR: Petits gombos au vinaigre
    name: 'Okras pequeñas en vinagre',
    // FR: Croquants et pas du tout baveux : le vinaigre les tient. Un pickle surprenant pour l'apéro.
    description: 'Crujientes y nada babosas: el vinagre las sujeta. Un pickle sorprendente para el aperitivo.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '500 g de okras muy pequeñas', // FR: 500 g de tout petits gombos
      '25 cl de vinagre blanco al 6 %', // FR: 25 cl de vinaigre blanc à 6 %
      '25 cl de agua', // FR: 25 cl d'eau
      '15 g de sal y 1 cucharadita de azúcar', // FR: 15 g de sel et 1 cuillère à café de sucre
      '2 dientes de ajo y 1 guindilla', // FR: 2 gousses d'ail et 1 piment
    ],
    steps: <String>[
      // FR: Lave et sèche les gombos, garde seulement les plus petits et les plus fermes.
      'Lava y seca las okras, quédate solo con las más pequeñas y firmes.',
      // FR: Recoupe le pédoncule **sans percer la capsule**. Pèle l'ail, fends le piment en deux.
      'Recorta el pedúnculo **sin perforar la cápsula**. Pela el ajo, parte la guindilla por la mitad.',
      // FR: Range les gombos debout et serrés dans deux bocaux ébouillantés, avec l'ail et le piment.
      'Coloca las okras de pie y apretadas en dos tarros escaldados, con el ajo y la guindilla.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sel et le sucre.
      'Lleva a ebullición el vinagre, el agua, la sal y el azúcar.',
      // FR: Verse la saumure bouillante jusqu'à **couvrir entièrement** les gombos, à 1 cm du bord. Ferme aussitôt.
      'Vierte la salmuera hirviendo hasta **cubrir por completo** las okras, a 1 cm del borde. Cierra enseguida.',
      // FR: Laisse refroidir, puis au réfrigérateur. Attends une semaine avant d'ouvrir, c'est là qu'ils prennent le goût.
      'Deja enfriar y luego guarda en la nevera. Espera una semana antes de abrir, que es cuando cogen el sabor.',
    ],
  ),
  'gombo/Gombos sautés à l\'ail': RecipeText(
    // FR: Gombos sautés à l'ail
    name: 'Okras salteadas con ajo',
    // FR: À feu vif et peu de temps : c'est ce qui évite le filant.
    description: 'A fuego fuerte y poco tiempo: eso es lo que evita la baba.',
  ),
  'gombo/Soupou kandia': RecipeText(
    // FR: Soupou kandia
    name: 'Soupou kandia',
    // FR: La sauce gombo sénégalaise onctueuse, à l'huile de palme et au poisson.
    description: 'La salsa de okra senegalesa, untuosa, con aceite de palma y pescado.',
  ),
  'gombo/Sauce gombo': RecipeText(
    // FR: Sauce gombo
    name: 'Salsa de okra',
    // FR: La grande sauce sahélienne qui accompagne le tô, mijotée avec viande ou poisson.
    description: 'La gran salsa saheliana que acompaña al tô, cocida a fuego lento con carne o pescado.',
  ),

  // ─────────── groseillier (6 recettes) ───────────
  'groseillier/Grappes de groseilles congelées': RecipeText(
    // FR: Grappes de groseilles congelées
    name: 'Racimos de grosellas congelados',
    // FR: L'astuce : congeler les grappes entières, et égrapper quand c'est dur. Fini l'égrappage grain par grain.
    description: 'El truco: congelar los racimos enteros y desgranar cuando estén duros. Se acabó desgranar grano a grano.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '1 kg de grosellas en racimos', // FR: 1 kg de groseilles en grappes
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Rince rapidement les grappes, seulement si elles sont sales.
      'Enjuaga rápidamente los racimos, solo si están sucios.',
      // FR: Sèche-les à plat sur un torchon, sans les écraser.
      'Sécalos planos sobre un paño, sin aplastarlos.',
      // FR: Étale les grappes entières sur une plaque et congèle 2 heures.
      'Extiende los racimos enteros en una bandeja y congela 2 horas.',
      // FR: Frotte les grappes congelées entre tes doigts ou passe une fourchette : **les grains tombent tout seuls**.
      'Frota los racimos congelados entre los dedos o pasa un tenedor: **los granos caen solos**.',
      // FR: Verse les grains en sac et remets aussitôt au congélateur, avant qu'ils ne dégèlent.
      'Pasa los granos a una bolsa y vuelve a meterlos enseguida en el congelador, antes de que se descongelen.',
    ],
  ),
  'groseillier/Sirop de groseille en bouteilles': RecipeText(
    // FR: Sirop de groseille en bouteilles
    name: 'Sirope de grosella en botellas',
    // FR: Le sirop rouge de l'enfance, fait avec tes groseilles : un été entier dans quelques bouteilles.
    description: 'El sirope rojo de la infancia, hecho con tus grosellas: todo un verano en unas pocas botellas.',
    // FR: 1 an au placard, 3 semaines ouvert au réfrigérateur
    keeps: '1 año en la despensa, 3 semanas abierto en la nevera',
    ingredients: <String>[
      '1,5 kg de grosellas desgranadas', // FR: 1,5 kg de groseilles égrappées
      '10 cl de agua', // FR: 10 cl d'eau
      '1 kg de azúcar por litro de jugo', // FR: 1 kg de sucre par litre de jus
      '4 botellas de 50 cl con tapón mecánico y juntas nuevas', // FR: 4 bouteilles de 50 cl à bouchon mécanique avec joints neufs
    ],
    steps: <String>[
      // FR: Fais éclater les groseilles avec l'eau à feu doux, en écrasant à la cuillère.
      'Haz que las grosellas se abran con el agua a fuego suave, aplastándolas con la cuchara.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse égoutter, puis presse un peu.
      'Vierte en un paño limpio colocado sobre un colador y deja escurrir, y luego exprime un poco.',
      // FR: Mesure le jus, ajoute **1 kg de sucre par litre** et porte doucement à ébullition en écumant.
      'Mide el jugo, añade **1 kg de azúcar por litro** y lleva despacio a ebullición espumando.',
      // FR: Laisse bouillir 3 minutes : le sirop doit napper légèrement la cuillère.
      'Deja hervir 3 minutos: el sirope debe cubrir ligeramente la cuchara.',
      // FR: Verse le sirop chaud dans les bouteilles propres, à 2 cm du bord, et ferme avec des joints neufs.
      'Vierte el sirope caliente en las botellas limpias, a 2 cm del borde, y cierra con juntas nuevas.',
      // FR: Stérilise les bouteilles couchées et couvertes d'eau, 20 minutes à partir de l'ébullition, puis laisse refroidir dans l'eau.
      'Esteriliza las botellas tumbadas y cubiertas de agua, 20 minutos desde que hierva, y luego deja enfriar en el agua.',
    ],
  ),
  'groseillier/Confiture groseilles-framboises': RecipeText(
    // FR: Confiture groseilles-framboises
    name: 'Mermelada de grosella y frambuesa',
    // FR: La groseille apporte la pectine et l'acidité, la framboise le parfum : le duo qui prend à coup sûr.
    description: 'La grosella aporta la pectina y la acidez, la frambuesa el aroma: el dúo que cuaja seguro.',
    // FR: 1 an au placard, 3 semaines ouvert au réfrigérateur
    keeps: '1 año en la despensa, 3 semanas abierto en la nevera',
    ingredients: <String>[
      '1 kg de grosellas desgranadas', // FR: 1 kg de groseilles égrappées
      '500 g de frambuesas', // FR: 500 g de framboises
      '800 g de azúcar por kilo de puré', // FR: 800 g de sucre par kilo de purée
      '5 tarros de mermelada', // FR: 5 pots de confiture
    ],
    steps: <String>[
      // FR: Fais éclater groseilles et framboises à feu doux, à couvert, en remuant.
      'Haz que las grosellas y las frambuesas se abran a fuego suave, tapadas, removiendo.',
      // FR: Passe au moulin à légumes grille fine pour retirer **les pépins** : la confiture sera lisse.
      'Pásalas por el pasapurés de rejilla fina para quitar **las pepitas**: la mermelada quedará lisa.',
      // FR: Pèse la purée, ajoute 800 g de sucre par kilo et porte à ébullition en remuant.
      'Pesa el puré, añade 800 g de azúcar por kilo y lleva a ebullición removiendo.',
      // FR: Cuis à gros bouillons en écumant. Ça prend vite, la groseille est pleine de pectine.
      'Cuece a borbotones espumando. Cuaja rápido, la grosella está llena de pectina.',
      // FR: Teste sur une assiette froide : une goutte qui se fige est prête.
      'Prueba en un plato frío: una gota que cuaja está lista.',
      // FR: Mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pasa a tarros escaldados, cierra y ponlos boca abajo hasta que se enfríen.',
    ],
  ),
  'groseillier/Gelée de groseilles': RecipeText(
    // FR: Gelée de groseilles
    name: 'Jalea de grosellas',
    // FR: Le jus seul, filtré sans presser, pour qu'elle reste claire.
    description: 'Solo el jugo, filtrado sin exprimir, para que quede clara.',
  ),
  'groseillier/Groseilles au sucre': RecipeText(
    // FR: Groseilles au sucre
    name: 'Grosellas con azúcar',
    // FR: En grappes, trempées dans le blanc d'œuf puis le sucre.
    description: 'En racimos, pasadas por clara de huevo y luego por azúcar.',
  ),
  'groseillier/Bavarois aux groseilles': RecipeText(
    // FR: Bavarois aux groseilles
    name: 'Bavarois de grosellas',
    // FR: Leur acidité réveille une crème sucrée.
    description: 'Su acidez despierta una crema dulce.',
  ),

  // ─────────── haricot (6 recettes) ───────────
  'haricot/Haricots verts blanchis au congélateur': RecipeText(
    // FR: Haricots verts blanchis au congélateur
    name: 'Judías verdes escaldadas para congelar',
    // FR: Trois minutes dans l'eau bouillante, et ils gardent leur croquant tout l'hiver.
    description: 'Tres minutos en agua hirviendo, y conservan su crujiente todo el invierno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de judías verdes', // FR: 2 kg de haricots verts
      'sal gruesa', // FR: gros sel
      '1 bol grande de agua con hielo', // FR: 1 grand saladier d'eau glacée
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Équeute les haricots des deux côtés. Garde-les entiers, ils se tiennent mieux.
      'Quita las puntas de las judías por los dos lados. Déjalas enteras, se sostienen mejor.',
      // FR: Plonge-les par poignées dans une grande casserole d'eau bouillante salée et compte **3 minutes**.
      'Sumérgelas por puñados en una olla grande de agua hirviendo con sal y cuenta **3 minutos**.',
      // FR: Transfère-les aussitôt dans l'eau glacée : c'est ce qui **fixe la couleur**.
      'Pásalas enseguida al agua con hielo: eso es lo que **fija el color**.',
      // FR: Égoutte et sèche-les dans un torchon, en les roulant doucement.
      'Escurre y sécalas en un paño, rodándolas con suavidad.',
      // FR: Étale-les sur une plaque, congèle 2 heures, puis mets-les en sac : ils restent séparés et se prennent à la poignée.
      'Extiéndelas en una bandeja, congela 2 horas y luego pásalas a una bolsa: quedan separadas y se cogen a puñados.',
    ],
  ),
  'haricot/Haricots verts à l\'aneth au vinaigre': RecipeText(
    // FR: Haricots verts à l'aneth au vinaigre
    name: 'Judías verdes al eneldo en vinagre',
    // FR: Les « dilly beans » : debout dans le bocal, croquants et piquants, à grignoter comme des cornichons.
    description: 'Las «dilly beans»: de pie en el tarro, crujientes y picantes, para picotear como pepinillos.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '1 kg de judías verdes finas', // FR: 1 kg de haricots verts fins
      '50 cl de vinagre blanco al 6 %', // FR: 50 cl de vinaigre blanc à 6 %
      '50 cl de agua', // FR: 50 cl d'eau
      '25 g de sal', // FR: 25 g de sel
      '4 dientes de ajo y unas cabezuelas de eneldo', // FR: 4 gousses d'ail et quelques têtes d'aneth
      '1 cucharadita de guindilla en copos', // FR: 1 cuillère à café de piment en flocons
    ],
    steps: <String>[
      // FR: Équeute les haricots et coupe-les à la hauteur des bocaux, moins 2 cm.
      'Quita las puntas de las judías y córtalas a la altura de los tarros, menos 2 cm.',
      // FR: Blanchis-les **2 minutes** à l'eau bouillante : ils restent croquants mais ne sont plus crus.
      'Escáldalas **2 minutos** en agua hirviendo: quedan crujientes pero ya no están crudas.',
      // FR: Rafraîchis-les dans l'eau glacée et égoutte.
      'Refréscalas en agua con hielo y escurre.',
      // FR: Range-les debout, bien serrés, dans des bocaux propres avec l'ail, l'aneth et le piment.
      'Colócalas de pie, bien apretadas, en tarros limpios con el ajo, el eneldo y la guindilla.',
      // FR: Porte à ébullition le vinaigre, l'eau et le sel.
      'Lleva a ebullición el vinagre, el agua y la sal.',
      // FR: Verse bouillant jusqu'à **couvrir les haricots** de 1 cm, ferme, laisse refroidir et range au réfrigérateur. Prêts en une semaine.
      'Vierte hirviendo hasta **cubrir las judías** 1 cm, cierra, deja enfriar y guarda en la nevera. Listas en una semana.',
    ],
  ),
  'haricot/Haricots verts mijotés à l\'oignon pour le congélateur': RecipeText(
    // FR: Haricots verts mijotés à l'oignon pour le congélateur
    name: 'Judías verdes guisadas con cebolla para el congelador',
    // FR: Déjà cuisinés avec oignons et lardons, ils passent du congélateur à l'assiette les soirs pressés.
    description: 'Ya cocinadas con cebolla y taquitos de bacon, pasan del congelador al plato las noches con prisa.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de judías verdes', // FR: 1,5 kg de haricots verts
      '3 cebollas', // FR: 3 oignons
      '150 g de taquitos de bacon (opcional)', // FR: 150 g de lardons (facultatif)
      '2 cucharadas de aceite', // FR: 2 cuillères à soupe d'huile
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Équeute les haricots et coupe-les en deux. Émince les oignons.
      'Quita las puntas de las judías y córtalas por la mitad. Lamina las cebollas.',
      // FR: Cuis les haricots 5 minutes à l'eau bouillante salée, puis égoutte-les.
      'Cuece las judías 5 minutos en agua hirviendo con sal y luego escúrrelas.',
      // FR: Fais dorer les oignons et les lardons dans l'huile, à feu moyen.
      'Dora las cebollas y el bacon en el aceite, a fuego medio.',
      // FR: Ajoute les haricots, sale, poivre et fais sauter 5 minutes. **Garde-les un peu fermes** : ils finiront de cuire au réchauffage.
      'Añade las judías, sala, pon pimienta y saltea 5 minutos. **Déjalas algo firmes**: acabarán de hacerse al recalentar.',
      // FR: Étale sur un plat pour refroidir vite.
      'Extiende en una fuente para que se enfríen rápido.',
      // FR: Mets en boîtes d'un repas et congèle. Réchauffe-les à la poêle sans décongeler.
      'Pasa a recipientes de una comida y congela. Recalienta en la sartén sin descongelar.',
    ],
  ),
  'haricot/Haricots verts à la tomate': RecipeText(
    // FR: Haricots verts à la tomate
    name: 'Judías verdes con tomate',
    // FR: Mijotés dans une sauce tomate à l'ail, à l'huile d'olive.
    description: 'Guisadas en una salsa de tomate con ajo, con aceite de oliva.',
    ingredients: <String>[
      '800 g de judías verdes', // FR: 800 g de haricots verts
      '4 tomates', // FR: 4 tomates
      '1 cebolla, 2 dientes de ajo', // FR: 1 oignon, 2 gousses d'ail
      '3 cucharadas de aceite de oliva', // FR: 3 cuillères à soupe d'huile d'olive
      'sal, pimienta, tomillo', // FR: sel, poivre, thym
    ],
    steps: <String>[
      // FR: Équeute les haricots, garde-les entiers.
      'Quita las puntas de las judías, déjalas enteras.',
      // FR: Fais fondre oignon et ail à l'huile, ajoute les tomates concassées.
      'Pocha la cebolla y el ajo en el aceite, añade los tomates troceados.',
      // FR: Laisse réduire 10 minutes.
      'Deja reducir 10 minutos.',
      // FR: Ajoute les haricots, sale, couvre, et laisse 25 minutes à feu doux.
      'Añade las judías, sala, tapa y deja 25 minutos a fuego suave.',
      // FR: Encore meilleurs tièdes, ou le lendemain.
      'Aún mejores templadas, o al día siguiente.',
    ],
  ),
  'haricot/Salade de haricots verts aux amandes': RecipeText(
    // FR: Salade de haricots verts aux amandes
    name: 'Ensalada de judías verdes con almendras',
    // FR: Cuits croquants, refroidis net, avec des amandes grillées.
    description: 'Cocidas crujientes, enfriadas de golpe, con almendras tostadas.',
    ingredients: <String>[
      '600 g de judías verdes', // FR: 600 g de haricots verts
      '60 g de almendras laminadas', // FR: 60 g d'amandes effilées
      '1 chalota', // FR: 1 échalote
      'mostaza, vinagre, aceite', // FR: moutarde, vinaigre, huile
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Plonge les haricots dans une grande eau bouillante très salée.
      'Echa las judías en una olla grande de agua hirviendo muy salada.',
      // FR: 8 minutes : ils doivent plier sans casser.
      '8 minutos: deben doblarse sin romperse.',
      // FR: Égoutte et plonge-les aussitôt dans l'eau glacée. C'est ce qui fixe le vert.
      'Escurre y pásalas enseguida al agua con hielo. Eso es lo que fija el verde.',
      // FR: Fais dorer les amandes à sec, 2 minutes.
      'Tuesta las almendras en seco, 2 minutos.',
      // FR: Vinaigrette à l'échalote, amandes par-dessus au dernier moment.
      'Vinagreta de chalota, y las almendras por encima en el último momento.',
    ],
  ),
  'haricot/Haricots verts sautés': RecipeText(
    // FR: Haricots verts sautés
    name: 'Judías verdes salteadas',
    // FR: Blanchis puis jetés à la poêle avec de l'ail et du beurre.
    description: 'Escaldadas y luego echadas a la sartén con ajo y mantequilla.',
    ingredients: <String>[
      '600 g de judías verdes', // FR: 600 g de haricots verts
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '30 g de mantequilla', // FR: 30 g de beurre
      'sal, pimienta, perejil', // FR: sel, poivre, persil
    ],
    steps: <String>[
      // FR: Blanchis les haricots 7 minutes à l'eau salée.
      'Escalda las judías 7 minutos en agua con sal.',
      // FR: Égoutte-les et sèche-les bien.
      'Escúrrelas y sécalas bien.',
      // FR: Beurre dans la poêle, l'ail émincé, puis les haricots.
      'Mantequilla en la sartén, el ajo laminado y luego las judías.',
      // FR: 5 minutes à feu vif en remuant : quelques marques dorées, c'est parfait.
      '5 minutos a fuego fuerte removiendo: unas marcas doradas, y perfecto.',
      // FR: Persil, poivre.
      'Perejil, pimienta.',
    ],
  ),

  // ─────────── haricot_beurre (6 recettes) ───────────
  'haricot_beurre/Haricots beurre blanchis congelés': RecipeText(
    // FR: Haricots beurre blanchis congelés
    name: 'Judías mantequilla escaldadas y congeladas',
    // FR: Trois minutes dans l'eau bouillante, et leur jaune tendre reste intact tout l'hiver.
    description: 'Tres minutos en agua hirviendo, y su amarillo tierno se mantiene intacto todo el invierno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de judías mantequilla', // FR: 2 kg de haricots beurre
      'sal gruesa', // FR: gros sel
      '1 bol grande de agua con hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Équeute les haricots des deux côtés et retire le fil s'il y en a. Garde-les entiers.
      'Quita las puntas de las judías por los dos lados y retira el hilo si lo hay. Déjalas enteras.',
      // FR: Rince-les à l'eau froide.
      'Enjuágalas con agua fría.',
      // FR: Plonge-les par poignées dans une grande eau bouillante salée, **3 minutes** à la reprise de l'ébullition.
      'Sumérgelas por puñados en una olla grande de agua hirviendo con sal, **3 minutos** desde que vuelva a hervir.',
      // FR: Transfère-les aussitôt dans l'eau glacée : c'est ce qui garde leur couleur et leur croquant.
      'Pásalas enseguida al agua con hielo: eso es lo que conserva su color y su crujiente.',
      // FR: Égoutte et sèche-les bien sur un torchon.
      'Escurre y sécalas bien con un paño.',
      // FR: Congèle-les étalés sur une plaque 2 heures, puis verse en sacs datés.
      'Congélalas extendidas en una bandeja 2 horas y luego pásalas a bolsas con fecha.',
    ],
  ),
  'haricot_beurre/Haricots beurre au vinaigre et à l\'aneth': RecipeText(
    // FR: Haricots beurre au vinaigre et à l'aneth
    name: 'Judías mantequilla al vinagre y al eneldo',
    // FR: Rangés debout dans un bocal, croquants et acidulés : ils se croquent comme des cornichons.
    description: 'Colocadas de pie en un tarro, crujientes y avinagradas: se comen como pepinillos.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '800 g de judías mantequilla', // FR: 800 g de haricots beurre
      '40 cl de vinagre blanco al 8 %', // FR: 40 cl de vinaigre blanc à 8 %
      '40 cl de agua', // FR: 40 cl d'eau
      '15 g de sal', // FR: 15 g de sel
      '3 dientes de ajo, 3 cabezuelas de eneldo', // FR: 3 gousses d'ail, 3 têtes d'aneth
    ],
    steps: <String>[
      // FR: Équeute les haricots et recoupe-les à la hauteur de tes bocaux, moins 2 cm.
      'Quita las puntas de las judías y recórtalas a la altura de tus tarros, menos 2 cm.',
      // FR: Blanchis-les **2 minutes** à l'eau bouillante salée : crus, le vinaigre a du mal à les pénétrer.
      'Escáldalas **2 minutos** en agua hirviendo con sal: crudas, al vinagre le cuesta penetrarlas.',
      // FR: Rafraîchis-les dans l'eau glacée et égoutte.
      'Refréscalas en agua con hielo y escurre.',
      // FR: Range-les debout et serrés dans trois bocaux ébouillantés, avec une gousse d'ail et une tête d'aneth par bocal.
      'Colócalas de pie y apretadas en tres tarros escaldados, con un diente de ajo y una cabezuela de eneldo por tarro.',
      // FR: Fais bouillir le vinaigre, l'eau et le sel.
      'Hierve el vinagre, el agua y la sal.',
      // FR: Verse bouillant pour **couvrir entièrement** les haricots, ferme, laisse refroidir et range au réfrigérateur. Attends une semaine.
      'Vierte hirviendo para **cubrir por completo** las judías, cierra, deja enfriar y guarda en la nevera. Espera una semana.',
    ],
  ),
  'haricot_beurre/Haricots beurre lacto-fermentés': RecipeText(
    // FR: Haricots beurre lacto-fermentés
    name: 'Judías mantequilla lactofermentadas',
    // FR: En saumure, ils deviennent acidulés tout en restant croquants : la façon la plus simple d'en garder des bocaux.
    description: 'En salmuera, se vuelven avinagradas sin perder el crujiente: la forma más sencilla de guardar tarros.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 meses en la nevera',
    ingredients: <String>[
      '1 kg de judías mantequilla', // FR: 1 kg de haricots beurre
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '1 cucharadita de semillas de mostaza', // FR: 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Fais dissoudre **30 g de sel dans 1 litre d'eau** : saumure à 3 %.
      'Disuelve **30 g de sal en 1 litro de agua**: salmuera al 3 %.',
      // FR: Équeute les haricots et garde-les entiers. Ici, **pas de blanchiment** : ce sont les bactéries du légume cru qui font la fermentation.
      'Quita las puntas de las judías y déjalas enteras. Aquí, **sin escaldar**: son las bacterias de la verdura cruda las que hacen la fermentación.',
      // FR: Range-les debout et serrés dans deux bocaux avec l'ail et la moutarde, jusqu'à 3 cm du bord.
      'Colócalas de pie y apretadas en dos tarros con el ajo y la mostaza, hasta 3 cm del borde.',
      // FR: Couvre de saumure et cale un poids pour qu'ils restent **sous la saumure**.
      'Cubre con la salmuera y pon un peso para que queden **bajo la salmuera**.',
      // FR: Ferme sans serrer et laisse fermenter 1 à 2 semaines à 18–22 °C, sur une assiette.
      'Cierra sin apretar y deja fermentar de 1 a 2 semanas a 18–22 °C, sobre un plato.',
      // FR: Quand ils sont acidulés, serre les couvercles et range au réfrigérateur. Ils se mangent tels quels, froids.
      'Cuando estén avinagradas, aprieta las tapas y guarda en la nevera. Se comen tal cual, frías.',
    ],
  ),
  'haricot_beurre/Haricots beurre persillade': RecipeText(
    // FR: Haricots beurre persillade
    name: 'Judías mantequilla con ajo y perejil',
    // FR: Cuits croquants, sautés au beurre et à l'ail.
    description: 'Cocidas crujientes, salteadas con mantequilla y ajo.',
  ),
  'haricot_beurre/Salade de haricots beurre': RecipeText(
    // FR: Salade de haricots beurre
    name: 'Ensalada de judías mantequilla',
    // FR: Tièdes, échalote et vinaigrette à l'ancienne.
    description: 'Templadas, con chalota y vinagreta a la antigua.',
  ),
  'haricot_beurre/Haricots beurre à la tomate': RecipeText(
    // FR: Haricots beurre à la tomate
    name: 'Judías mantequilla con tomate',
    // FR: Mijotés dans un coulis à l'ail et au thym.
    description: 'Guisadas en una salsa de tomate con ajo y tomillo.',
  ),

  // ─────────── igname (6 recettes) ───────────
  'igname/Igname bouillie en portions': RecipeText(
    // FR: Igname bouillie en portions
    name: 'Ñame hervido en porciones',
    // FR: Épluchée, cuite, congelée : tu sors une portion, tu la réchauffes ou tu la piles, et le repas est là.
    description: 'Pelado, cocido, congelado: sacas una ración, la recalientas o la machacas, y la comida está lista.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 kg de ñame', // FR: 2 kg d'igname
      'sal gruesa', // FR: gros sel
      'guantes', // FR: des gants
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Mets des gants : la peau d'igname gratte les mains. Coupe en rondelles de 4 cm, puis épluche chaque rondelle.
      'Ponte guantes: la piel del ñame irrita las manos. Corta en rodajas de 4 cm y pela cada rodaja.',
      // FR: Rince les morceaux pour enlever la sève gluante.
      'Enjuaga los trozos para quitar la savia viscosa.',
      // FR: Cuis-les dans l'eau bouillante salée jusqu'à ce que la pointe du couteau entre sans forcer.
      'Cuécelos en agua hirviendo con sal hasta que la punta del cuchillo entre sin forzar.',
      // FR: Égoutte et laisse refroidir étalé sur un plateau. Chaud, il fait de la buée et du givre dans le sac.
      'Escurre y deja enfriar extendido en una bandeja. Caliente, forma vaho y escarcha en la bolsa.',
      // FR: Répartis en portions d'un repas, chasse l'air, note la date.
      'Reparte en raciones de una comida, saca el aire, anota la fecha.',
      // FR: À l'usage, réchauffe 10 minutes à la vapeur ou dans l'eau frémissante, ou pile directement chaud.
      'Al usarlo, recalienta 10 minutos al vapor o en agua a fuego lento, o machácalo directamente caliente.',
    ],
  ),
  'igname/Cubes d\'igname crus congelés': RecipeText(
    // FR: Cubes d'igname crus congelés
    name: 'Cubos de ñame crudos congelados',
    // FR: Vingt minutes de préparation, et des cubes prêts à jeter dans un ragoût. On les cuit toujours ensuite : l'igname ne se mange jamais crue.
    description: 'Veinte minutos de preparación, y cubos listos para echar a un guiso. Siempre se cuecen después: el ñame nunca se come crudo.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de ñame', // FR: 1,5 kg d'igname
      'guantes', // FR: des gants
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Avec des gants, épluche l'igname bien épais pour enlever la couche rosée sous la peau.
      'Con guantes, pela el ñame bien grueso para quitar la capa rosada bajo la piel.',
      // FR: Coupe en cubes de 3 cm, tous pareils pour qu'ils cuisent en même temps.
      'Corta en cubos de 3 cm, todos iguales para que se cuezan a la vez.',
      // FR: Rince-les et **sèche-les bien** dans un torchon.
      'Enjuágalos y **sécalos bien** con un paño.',
      // FR: Étale sur une plaque et congèle 2 heures, puis mets-les en sac.
      'Extiende en una bandeja y congela 2 horas, y luego pásalos a una bolsa.',
      // FR: Plonge-les **sans décongeler** dans l'eau bouillante salée ou la sauce, et cuis 20 à 25 minutes jusqu'à ce qu'ils soient tendres.
      'Échalos **sin descongelar** en agua hirviendo con sal o en la salsa, y cuece de 20 a 25 minutos hasta que estén tiernos.',
    ],
  ),
  'igname/Cossettes d\'igname séchées (élubo)': RecipeText(
    // FR: Cossettes d'igname séchées (élubo)
    name: 'Rodajas de ñame secas (élubo)',
    // FR: Précuites puis séchées, les cossettes se gardent des mois et se moulent en farine pour l'amala.
    description: 'Precocidas y luego secadas, las rodajas se conservan meses y se muelen en harina para el amala.',
    // FR: 1 an au sec, à l'abri de l'humidité
    keeps: '1 año en seco, protegido de la humedad',
    ingredients: <String>[
      '3 kg de ñame', // FR: 3 kg d'igname
      'guantes', // FR: des gants
      'rejillas o bandejas de horno', // FR: des claies ou plaques de four
      'un tarro o cubo hermético', // FR: un bocal ou seau hermétique
    ],
    steps: <String>[
      // FR: Avec des gants, épluche l'igname et coupe-la en tranches de 1 cm.
      'Con guantes, pela el ñame y córtalo en rodajas de 1 cm.',
      // FR: Plonge les tranches dans une eau frémissante : elles doivent cuire en surface mais rester fermes au cœur.
      'Sumerge las rodajas en agua a fuego lento: deben cocerse en la superficie pero seguir firmes por dentro.',
      // FR: Égoutte et laisse reposer une nuit à couvert : c'est ce qui donne la couleur brune de l'élubo.
      'Escurre y deja reposar una noche tapadas: eso es lo que da el color marrón del élubo.',
      // FR: Sèche à **60 °C** jusqu'à ce que les tranches soient dures comme du bois, ou 4 à 5 jours au grand soleil.
      'Seca a **60 °C** hasta que las rodajas queden duras como la madera, o de 4 a 5 días a pleno sol.',
      // FR: Stocke les cossettes entières, elles se gardent mieux que la farine.
      'Guarda las rodajas enteras, se conservan mejor que la harina.',
      // FR: Mouds-en une partie au moulin ou au blender puissant. La farine se verse toujours en pluie dans l'eau bouillante et se cuit en remuant.
      'Muele una parte en el molino o en una batidora potente. La harina se vierte siempre en lluvia en el agua hirviendo y se cuece removiendo.',
    ],
  ),
  'igname/Foufou d\'igname': RecipeText(
    // FR: Foufou d'igname
    name: 'Foufou de ñame',
    // FR: L'igname pilée en boule moelleuse, indispensable avec une sauce bien relevée.
    description: 'El ñame machacado en una bola esponjosa, imprescindible con una salsa bien sazonada.',
  ),
  'igname/Ragoût d\'igname': RecipeText(
    // FR: Ragoût d'igname
    name: 'Guiso de ñame',
    // FR: Des morceaux d'igname mijotés dans une sauce tomate qui embaume la cuisine.
    description: 'Trozos de ñame cocidos a fuego lento en una salsa de tomate que perfuma toda la cocina.',
  ),
  'igname/Igname frite': RecipeText(
    // FR: Igname frite
    name: 'Ñame frito',
    // FR: Des frites d'igname dorées, à tremper dans une petite sauce pimentée.
    description: 'Bastones de ñame fritos y dorados, para mojar en una salsita picante.',
  ),

  // ─────────── kiwi (6 recettes) ───────────
  'kiwi/Chutney de kiwis au gingembre': RecipeText(
    // FR: Chutney de kiwis au gingembre
    name: 'Chutney de kiwi y jengibre',
    // FR: Quand l'actinidia croule sous les fruits, un chutney acidulé en absorbe un kilo d'un coup.
    description: 'Cuando la actinidia se carga de frutos, un chutney ácido se lleva un kilo de golpe.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierto en la nevera',
    ingredients: <String>[
      '1 kg de kiwis maduros', // FR: 1 kg de kiwis mûrs
      '1 cebolla', // FR: 1 oignon
      '250 g de azúcar moreno', // FR: 250 g de sucre roux
      '20 cl de vinagre de sidra', // FR: 20 cl de vinaigre de cidre
      '20 g de jengibre fresco, 1 cucharadita de sal', // FR: 20 g de gingembre frais, 1 cuillère à café de sel
      '5 tarros con tapas nuevas', // FR: 5 pots avec couvercles neufs
    ],
    steps: <String>[
      // FR: Épluche les kiwis et coupe-les en dés. Émince l'oignon et râpe le gingembre.
      'Pela los kiwis y córtalos en dados. Lamina la cebolla y ralla el jengibre.',
      // FR: Mets tout dans une casserole à fond épais avec le sucre, le vinaigre et le sel, et porte à ébullition.
      'Pon todo en un cazo de fondo grueso con el azúcar, el vinagre y la sal, y lleva a ebullición.',
      // FR: Laisse cuire à petit feu, à découvert, en remuant souvent, jusqu'à ce que ça épaississe et que la cuillère laisse un sillon.
      'Deja cocer a fuego lento, sin tapar, removiendo a menudo, hasta que espese y la cuchara deje un surco.',
      // FR: Remplis les pots propres de chutney bouillant **jusqu'à 2 cm du bord** et ferme avec des couvercles neufs.
      'Llena los tarros limpios con el chutney hirviendo **hasta 2 cm del borde** y cierra con tapas nuevas.',
      // FR: Stérilise les pots couverts d'eau, 20 minutes à partir de l'ébullition, puis vérifie le vide en refroidissant.
      'Esteriliza los tarros cubiertos de agua, 20 minutos desde que hierva, y luego comprueba el vacío al enfriarse.',
    ],
  ),
  'kiwi/Rondelles de kiwi séchées': RecipeText(
    // FR: Rondelles de kiwi séchées
    name: 'Rodajas de kiwi secas',
    // FR: Séchées, les rondelles gardent leur vert vif et leurs petits grains noirs : jolies et acidulées.
    description: 'Secas, las rodajas conservan su verde vivo y sus pequeñas semillas negras: bonitas y ácidas.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 meses en tarro, en lugar seco',
    ingredients: <String>[
      '1,5 kg de kiwis maduros pero firmes', // FR: 1,5 kg de kiwis mûrs mais fermes
      'papel de horno', // FR: du papier cuisson
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Prends des kiwis mûrs mais encore fermes : cueillis durs en novembre, ils mûrissent en quelques jours à côté d'une pomme.
      'Coge kiwis maduros pero aún firmes: cogidos duros en noviembre, maduran en unos días junto a una manzana.',
      // FR: Épluche-les et coupe des rondelles de **6 mm**, toutes pareilles.
      'Pélalos y corta rodajas de **6 mm**, todas iguales.',
      // FR: Étale-les sur des grilles couvertes de papier cuisson et sèche au four à **60 °C**, porte entrouverte. Retourne-les à mi-temps.
      'Extiéndelas en rejillas cubiertas con papel de horno y sécalas en el horno a **60 °C**, con la puerta entreabierta. Dales la vuelta a mitad de tiempo.',
      // FR: Teste : la rondelle refroidie est souple, sans jus, et se décolle du papier toute seule.
      'Prueba: la rodaja ya fría es blanda, sin jugo, y se despega sola del papel.',
      // FR: Mets en bocal et surveille la buée la première semaine. S'il y en a, remets au four une heure.
      'Pásalas a un tarro y vigila el vaho la primera semana. Si lo hay, vuelve a meterlas en el horno una hora.',
    ],
  ),
  'kiwi/Rondelles de kiwi congelées': RecipeText(
    // FR: Rondelles de kiwi congelées
    name: 'Rodajas de kiwi congeladas',
    // FR: Épluchées et congelées sur plaque, elles filent directement dans un smoothie ou un sorbet.
    description: 'Peladas y congeladas en bandeja, van directamente a un batido o a un sorbete.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 kg de kiwis bien maduros', // FR: 1 kg de kiwis bien mûrs
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les kiwis et coupe-les en rondelles d'un centimètre.
      'Pela los kiwis y córtalos en rodajas de un centímetro.',
      // FR: Étale-les sur une plaque couverte de papier cuisson, sans qu'elles se touchent, et congèle 2 heures.
      'Extiéndelas en una bandeja cubierta con papel de horno, sin que se toquen, y congela 2 horas.',
      // FR: Décolle-les et verse-les en sac. Décongelées elles sont molles : **à mixer**, pas pour une salade de fruits.
      'Despégalas y pásalas a una bolsa. Descongeladas están blandas: **para triturar**, no para una macedonia.',
      // FR: Mixées encore congelées avec un peu de sucre, elles donnent un sorbet minute.
      'Trituradas aún congeladas con un poco de azúcar, dan un sorbete al instante.',
    ],
  ),
  'kiwi/Salade de kiwis à la menthe': RecipeText(
    // FR: Salade de kiwis à la menthe
    name: 'Ensalada de kiwis con menta',
    // FR: Avec de l'orange, c'est le dessert d'hiver le plus simple.
    description: 'Con naranja, es el postre de invierno más sencillo.',
  ),
  'kiwi/Confiture de kiwis': RecipeText(
    // FR: Confiture de kiwis
    name: 'Mermelada de kiwi',
    // FR: Verte et acidulée, avec de la vanille.
    description: 'Verde y ácida, con vainilla.',
  ),
  'kiwi/Smoothie kiwi-pomme': RecipeText(
    // FR: Smoothie kiwi-pomme
    name: 'Batido de kiwi y manzana',
    // FR: Attention : le kiwi fait tourner les laitages après une heure.
    description: 'Ojo: el kiwi corta los lácteos pasada una hora.',
  ),

  // ─────────── laitue (6 recettes) ───────────
  'laitue/Potage de laitue aux petits pois à congeler': RecipeText(
    // FR: Potage de laitue aux petits pois à congeler
    name: 'Crema de lechuga y guisantes para congelar',
    // FR: Quand toutes les laitues montent en même temps, la soupe est la seule façon de les garder.
    description: 'Cuando todas las lechugas se espigan a la vez, la sopa es la única forma de guardarlas.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 lechugas grandes', // FR: 2 grosses laitues
      '300 g de guisantes desgranados', // FR: 300 g de petits pois écossés
      '1 cebolla', // FR: 1 oignon
      '2 patatas', // FR: 2 pommes de terre
      '1,2 litros de caldo', // FR: 1,2 litre de bouillon
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Lave les laitues feuille à feuille, même un peu montées : coupe juste les côtes trop dures et amères.
      'Lava las lechugas hoja a hoja, aunque estén algo espigadas: corta solo las nervaduras demasiado duras y amargas.',
      // FR: Fais suer l'oignon émincé, ajoute les pommes de terre en dés et le bouillon, cuis 15 minutes.
      'Rehoga la cebolla en láminas, añade las patatas en dados y el caldo, y cuece 15 minutos.',
      // FR: Ajoute les petits pois et la laitue grossièrement coupée, et compte **5 minutes**, pas plus, pour garder le vert.
      'Añade los guisantes y la lechuga cortada en trozos grandes, y cuenta **5 minutos**, no más, para conservar el verde.',
      // FR: Mixe aussitôt, hors du feu. Sans crème : tu l'ajouteras à table, elle tranche au congélateur.
      'Tritura enseguida, fuera del fuego. Sin nata: la añadirás en la mesa, porque en el congelador se corta.',
      // FR: Refroidis vite en posant la casserole dans l'eau froide, en remuant de temps en temps.
      'Enfría rápido poniendo la cacerola en agua fría, removiendo de vez en cuando.',
      // FR: Mets en boîtes d'un repas en laissant 2 cm de vide, ça gonfle en gelant. Note la date.
      'Pasa a recipientes de una comida dejando 2 cm de vacío, se expande al congelarse. Anota la fecha.',
    ],
  ),
  'laitue/Laitue fondue au beurre en portions': RecipeText(
    // FR: Laitue fondue au beurre en portions
    name: 'Lechuga a la mantequilla en porciones',
    // FR: Un saladier de feuilles qui fond en une poignée : de quoi glisser du vert dans une quiche ou une omelette tout l'hiver.
    description: 'Un bol de hojas que se reduce a un puñado: para colar verde en una quiche o una tortilla todo el invierno.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '3 lechugas', // FR: 3 laitues
      '30 g de mantequilla', // FR: 30 g de beurre
      '1 chalota', // FR: 1 échalote
      'sal', // FR: sel
    ],
    steps: <String>[
      // FR: Lave les feuilles et essore-les bien : trop d'eau, et elles bouillent au lieu de fondre.
      'Lava las hojas y escúrrelas bien: con demasiada agua, hierven en vez de deshacerse.',
      // FR: Roule-les en cigare et coupe-les en lanières d'un centimètre.
      'Enróllalas como un puro y córtalas en tiras de un centímetro.',
      // FR: Fais fondre l'échalote hachée dans le beurre, ajoute la laitue par poignées et remue jusqu'à ce qu'elle tombe.
      'Derrite la chalota picada en la mantequilla, añade la lechuga por puñados y remueve hasta que se ablande.',
      // FR: Sale légèrement et laisse évaporer le jus à feu vif 2 minutes : c'est ce qui évite les glaçons.
      'Sala ligeramente y deja evaporar el jugo a fuego fuerte 2 minutos: eso evita que se formen trozos de hielo.',
      // FR: Étale sur une assiette pour refroidir vite, puis répartis en petits tas ou en bac à muffins.
      'Extiéndela en un plato para que se enfríe rápido y luego reparte en montoncitos o en un molde de magdalenas.',
      // FR: Congèle 2 heures, démoule les palets et garde-les en sac. Un palet se jette directement dans la poêle.
      'Congela 2 horas, desmolda los discos y guárdalos en una bolsa. Un disco se echa directamente a la sartén.',
    ],
  ),
  'laitue/Côtes de laitue en pickles croquants': RecipeText(
    // FR: Côtes de laitue en pickles croquants
    name: 'Nervios de lechuga en pickles crujientes',
    // FR: Les côtes épaisses d'une romaine ou d'une batavia montée gardent un croquant étonnant dans le vinaigre.
    description: 'Las nervaduras gruesas de una romana o una batavia espigada conservan un crujiente asombroso en el vinagre.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      'las nervaduras y los troncos de 4 lechugas', // FR: les côtes et trognons de 4 laitues
      '25 cl de vinagre de sidra al 6 %', // FR: 25 cl de vinaigre de cidre à 6 %
      '25 cl de agua', // FR: 25 cl d'eau
      '1 cucharada de azúcar', // FR: 1 cuillère à soupe de sucre
      '1 cucharadita de sal', // FR: 1 cuillère à café de sel
      '1 cucharadita de semillas de mostaza', // FR: 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Garde les grosses côtes blanches et les trognons des laitues montées, épluche les trognons au couteau.
      'Guarda las nervaduras blancas gruesas y los troncos de las lechugas espigadas, y pela los troncos con el cuchillo.',
      // FR: Coupe le tout en bâtonnets de 5 cm, assez épais pour rester croquants.
      'Corta todo en bastoncitos de 5 cm, lo bastante gruesos para seguir crujientes.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre, le sel et la moutarde, et laisse bouillir 2 minutes.
      'Lleva a ebullición el vinagre, el agua, el azúcar, la sal y la mostaza, y deja hervir 2 minutos.',
      // FR: Tasse les bâtonnets debout dans un bocal propre.
      'Aprieta los bastoncitos de pie en un tarro limpio.',
      // FR: Verse le vinaigre chaud jusqu'à **couvrir entièrement**, ferme, laisse refroidir et range au réfrigérateur.
      'Vierte el vinagre caliente hasta **cubrir por completo**, cierra, deja enfriar y guarda en la nevera.',
      // FR: Attends 2 jours avant d'y goûter. À servir avec une viande froide ou haché dans une salade de riz.
      'Espera 2 días antes de probarlos. Para servir con carne fría o picados en una ensalada de arroz.',
    ],
  ),
  'laitue/Salade verte vinaigrette maison': RecipeText(
    // FR: Salade verte vinaigrette maison
    name: 'Ensalada verde con vinagreta casera',
    // FR: Une laitue cueillie à l'instant ne demande presque rien.
    description: 'Una lechuga recién cortada casi no necesita nada.',
    ingredients: <String>[
      '1 lechuga bonita', // FR: 1 belle laitue
      '1 cucharadita de mostaza', // FR: 1 cuillère à café de moutarde
      '1 cucharada de vinagre', // FR: 1 cuillère à soupe de vinaigre
      '3 cucharadas de aceite', // FR: 3 cuillères à soupe d'huile
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Lave les feuilles à l'eau froide, sèche-les bien : l'eau empêche la vinaigrette de tenir.
      'Lava las hojas con agua fría y sécalas bien: el agua impide que la vinagreta se sostenga.',
      // FR: Dans le fond du saladier, délaye moutarde, sel et vinaigre.
      'En el fondo de la ensaladera, disuelve la mostaza, la sal y el vinagre.',
      // FR: Verse l'huile en filet en fouettant : la sauce doit épaissir.
      'Vierte el aceite en hilo mientras bates: la salsa debe espesar.',
      // FR: Ajoute les feuilles et mélange **juste avant** de servir.
      'Añade las hojas y mezcla **justo antes** de servir.',
    ],
  ),
  'laitue/Laitue braisée aux petits pois': RecipeText(
    // FR: Laitue braisée aux petits pois
    name: 'Lechuga estofada con guisantes',
    // FR: Oui, la laitue se cuit — fondante, avec des petits pois et un peu de lard.
    description: 'Sí, la lechuga se cocina: melosa, con guisantes y un poco de panceta.',
    ingredients: <String>[
      '2 lechugas', // FR: 2 laitues
      '300 g de guisantes desgranados', // FR: 300 g de petits pois écossés
      '100 g de taquitos de bacon', // FR: 100 g de lardons
      '1 cebolleta', // FR: 1 oignon nouveau
      '20 g de mantequilla, sal, pimienta', // FR: 20 g de beurre, sel, poivre
    ],
    steps: <String>[
      // FR: Coupe les laitues en quatre, garde-les attachées au trognon.
      'Corta las lechugas en cuatro, déjalas unidas por el tronco.',
      // FR: Fais dorer les lardons avec l'oignon émincé.
      'Dora los taquitos de bacon con la cebolleta laminada.',
      // FR: Ajoute les petits pois, les quartiers de laitue, le beurre et un fond d'eau.
      'Añade los guisantes, los cuartos de lechuga, la mantequilla y un chorrito de agua.',
      // FR: Couvre et laisse fondre 20 minutes à feu doux.
      'Tapa y deja que se ablanden 20 minutos a fuego suave.',
      // FR: Poivre généreusement, sale peu : les lardons salent.
      'Pon pimienta generosamente, sal poca: el bacon ya sala.',
    ],
  ),
  'laitue/Velouté de laitue': RecipeText(
    // FR: Velouté de laitue
    name: 'Crema de lechuga',
    // FR: La solution quand la laitue monte toute en même temps au potager.
    description: 'La solución cuando todas las lechugas se espigan a la vez en el huerto.',
    ingredients: <String>[
      '2 lechugas (incluso algo espigadas)', // FR: 2 laitues (même un peu montées)
      '2 patatas', // FR: 2 pommes de terre
      '1 cebolla', // FR: 1 oignon
      '80 cl de caldo', // FR: 80 cl de bouillon
      '10 cl de nata, sal, pimienta', // FR: 10 cl de crème, sel, poivre
    ],
    steps: <String>[
      // FR: Lave les laitues et hache-les grossièrement, côtes comprises.
      'Lava las lechugas y pícalas groseramente, nervaduras incluidas.',
      // FR: Fais fondre l'oignon, ajoute les pommes de terre.
      'Rehoga la cebolla, añade las patatas.',
      // FR: Mouille au bouillon et cuis 15 minutes.
      'Moja con el caldo y cuece 15 minutos.',
      // FR: Ajoute la laitue seulement **5 minutes** à la fin : au-delà elle perd sa couleur.
      'Añade la lechuga solo **5 minutos** al final: pasado ese tiempo pierde el color.',
      // FR: Mixe, ajoute la crème hors du feu, rectifie.
      'Tritura, añade la nata fuera del fuego, rectifica.',
    ],
  ),


  // ─────────── laurier_sauce (6 recettes) ───────────
  'laurier_sauce/Feuilles de laurier séchées à plat': RecipeText(
    // FR: Feuilles de laurier séchées à plat
    name: 'Hojas de laurel secadas planas',
    // FR: Séchées bien à plat et à l'ombre, elles restent vertes et parfumées toute l'année.
    description: 'Secadas bien planas y a la sombra, se mantienen verdes y aromáticas todo el año.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegidas de la luz',
    ingredients: <String>[
      'ramas de laurel', // FR: des rameaux de laurier-sauce
      'hojas de papel de periódico o un paño', // FR: des feuilles de papier journal ou un torchon
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Cueille sur un **vrai laurier-sauce** (Laurus nobilis). Le laurier-rose et le laurier-cerise sont toxiques : dans le doute, ne cueille pas.
      'Corta de un **laurel de verdad** (Laurus nobilis). La adelfa y el lauroceraso son tóxicos: en caso de duda, no cortes.',
      // FR: Essuie les feuilles avec un linge humide, détache-les des rameaux et garde les plus belles.
      'Limpia las hojas con un paño húmedo, sepáralas de las ramas y quédate con las más bonitas.',
      // FR: Étale-les en une seule couche entre deux feuilles de papier, posées sur une claie ou un plateau.
      'Extiéndelas en una sola capa entre dos hojas de papel, colocadas sobre una rejilla o una bandeja.',
      // FR: Laisse-les deux semaines à l'ombre, dans une pièce sèche et aérée. Un livre léger posé dessus les garde bien plates.
      'Déjalas dos semanas a la sombra, en una habitación seca y ventilada. Un libro ligero encima las mantiene bien planas.',
      // FR: Elles sont prêtes quand elles cassent net. Range-les entières en bocal, elles parfument mieux qu'émiettées.
      'Están listas cuando se parten de golpe. Guárdalas enteras en un tarro: aromatizan mejor que desmenuzadas.',
    ],
  ),
  'laurier_sauce/Rameaux de laurier au congélateur': RecipeText(
    // FR: Rameaux de laurier au congélateur
    name: 'Ramas de laurel en el congelador',
    // FR: Dix minutes, et des feuilles qui ont le parfum du frais pour tes bouillons et tes pot-au-feu.
    description: 'Diez minutos, y hojas con el aroma de lo fresco para tus caldos y tus cocidos.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      'unas ramas de laurel', // FR: quelques rameaux de laurier-sauce
      'una bolsa de congelación con cierre zip', // FR: un sac de congélation à zip
    ],
    steps: <String>[
      // FR: Rince les rameaux et essuie-les soigneusement avec un torchon.
      'Aclara las ramas y sécalas con cuidado con un paño.',
      // FR: Coupe-les en petits rameaux de quatre ou cinq feuilles, faciles à sortir un par un.
      'Córtalas en ramitas de cuatro o cinco hojas, fáciles de sacar de una en una.',
      // FR: Glisse-les dans le sac, chasse l'air, ferme et congèle à plat.
      'Mételas en la bolsa, saca el aire, cierra y congela en plano.',
      // FR: À l'usage, mets la feuille **encore gelée** dans la cocotte et retire-la avant de servir.
      'Al usarlas, echa la hoja **todavía congelada** en la olla y retírala antes de servir.',
    ],
  ),
  'laurier_sauce/Vinaigre de cidre au laurier et poivre': RecipeText(
    // FR: Vinaigre de cidre au laurier et poivre
    name: 'Vinagre de sidra con laurel y pimienta',
    // FR: Un vinaigre chaud et boisé pour les lentilles, les marinades et les sauces au jus de viande.
    description: 'Un vinagre cálido y amaderado para las lentejas, los escabeches y las salsas de carne.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 año en la despensa, protegido de la luz',
    ingredients: <String>[
      '10 hojas de laurel secas', // FR: 10 feuilles de laurier-sauce séchées
      '1 cucharadita de pimienta negra en grano', // FR: 1 cuillère à café de poivre noir en grains
      '75 cl de vinagre de sidra de 6 % como mínimo', // FR: 75 cl de vinaigre de cidre à 6 % minimum
      'una botella limpia', // FR: une bouteille propre
    ],
    steps: <String>[
      // FR: Froisse légèrement les feuilles de laurier entre tes doigts pour libérer leur parfum.
      'Arruga ligeramente las hojas de laurel entre los dedos para liberar su aroma.',
      // FR: Glisse-les dans la bouteille avec le poivre en grains.
      'Mételas en la botella junto con la pimienta en grano.',
      // FR: Fais chauffer le vinaigre jusqu'aux premiers frémissements, sans le faire bouillir.
      'Calienta el vinagre hasta los primeros temblores, sin dejar que hierva.',
      // FR: Verse-le sur les feuilles avec un entonnoir : elles doivent être **entièrement couvertes**.
      'Viértelo sobre las hojas con un embudo: deben quedar **completamente cubiertas**.',
      // FR: Ferme et laisse infuser deux semaines à l'ombre, en retournant la bouteille de temps en temps.
      'Cierra y deja infusionar dos semanas a la sombra, dando la vuelta a la botella de vez en cuando.',
      // FR: Filtre, remets une feuille propre dans la bouteille pour le joli, et referme.
      'Filtra, vuelve a poner una hoja limpia en la botella para que quede bonita, y cierra de nuevo.',
    ],
  ),
  'laurier_sauce/Bouquet garni': RecipeText(
    // FR: Bouquet garni
    name: 'Ramillete de hierbas aromáticas',
    // FR: Thym, laurier, persil, ficelés ensemble. La base de tout.
    description: 'Tomillo, laurel y perejil, atados juntos. La base de todo.',
  ),
  'laurier_sauce/Court-bouillon au laurier': RecipeText(
    // FR: Court-bouillon au laurier
    name: 'Caldo corto de laurel',
    // FR: Pour pocher un poisson sans le dessécher.
    description: 'Para escalfar un pescado sin resecarlo.',
  ),
  'laurier_sauce/Crème au laurier': RecipeText(
    // FR: Crème au laurier
    name: 'Crema de laurel',
    // FR: Infusé dans le lait chaud — un parfum inattendu en dessert.
    description: 'Infusionado en leche caliente: un aroma inesperado en el postre.',
  ),

  // ─────────── lavande (6 recettes) ───────────
  'lavande/Bouquets de lavande séchés pour la cuisine': RecipeText(
    // FR: Bouquets de lavande séchés pour la cuisine
    name: 'Ramilletes de lavanda secos para la cocina',
    // FR: Cueillie en boutons et séchée à l'ombre, elle te donne des fleurs à cuisiner pour toute l'année.
    description: 'Cortada en capullo y secada a la sombra, te da flores para cocinar durante todo el año.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegida de la luz',
    ingredients: <String>[
      'tallos de lavanda verdadera con las espigas a medio abrir', // FR: des tiges de lavande vraie aux épis à moitié ouverts
      'gomas elásticas', // FR: des élastiques
      'una sábana o una hoja grande de papel', // FR: un drap ou une grande feuille de papier
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Pour la cuisine, prends de la **lavande vraie**, pas du lavandin au goût camphré. Coupe quand un tiers des fleurs est ouvert, le matin après la rosée.
      'Para cocinar, usa **lavanda verdadera**, no lavandín, de sabor alcanforado. Corta cuando un tercio de las flores esté abierto, por la mañana, después del rocío.',
      // FR: Fais des bouquets d'une vingtaine de tiges serrés par un élastique : il suit les tiges quand elles rétrécissent.
      'Haz ramilletes de unos veinte tallos sujetos con una goma elástica, que sigue a los tallos cuando se encogen.',
      // FR: Suspends-les tête en bas dans un endroit sombre, sec et aéré, deux semaines.
      'Cuélgalos boca abajo durante dos semanas en un lugar oscuro, seco y ventilado.',
      // FR: Égrène les épis au-dessus du drap en les frottant entre tes mains.
      'Desgrana las espigas sobre la sábana frotándolas entre las manos.',
      // FR: Passe les fleurs au tamis pour ôter les bouts de tige, puis mets-les en bocal.
      'Pasa las flores por un colador para quitar los trocitos de tallo y guárdalas en un tarro.',
      // FR: Elle est très puissante : une demi-cuillère à café parfume tout un gâteau.
      'Es muy potente: media cucharadita perfuma un bizcocho entero.',
    ],
  ),
  'lavande/Gelée de lavande': RecipeText(
    // FR: Gelée de lavande
    name: 'Jalea de lavanda',
    // FR: Une gelée mauve et parfumée pour les tartines, le fromage de chèvre ou les sablés.
    description: 'Una jalea malva y aromática para tostadas, queso de cabra o galletas de mantequilla.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierta en la nevera',
    ingredients: <String>[
      '1 litro de zumo de manzana puro', // FR: 1 litre de pur jus de pomme
      '2 cucharadas soperas de flores de lavanda secas', // FR: 2 cuillères à soupe de fleurs de lavande séchées
      'el zumo de un limón', // FR: le jus d'un citron
      '800 g de azúcar', // FR: 800 g de sucre
      '1 sobre de pectina para 1 kg de fruta', // FR: 1 sachet de pectine pour 1 kg de fruits
    ],
    steps: <String>[
      // FR: Fais frémir le jus de pomme puis coupe le feu.
      'Lleva el zumo de manzana a un hervor suave y apaga el fuego.',
      // FR: Ajoute la lavande, couvre et infuse **10 minutes**. Trop longtemps, elle a un goût de savon.
      'Añade la lavanda, tapa e infusiona **10 minutos**. Si se pasa, sabe a jabón.',
      // FR: Filtre soigneusement : aucune fleur ne doit rester dans la gelée.
      'Filtra con cuidado: no debe quedar ninguna flor en la jalea.',
      // FR: Ajoute le jus de citron, il ravive la couleur.
      'Añade el zumo de limón, que reaviva el color.',
      // FR: Incorpore la pectine mélangée à un peu de sucre, porte à ébullition, puis ajoute le reste du sucre.
      'Incorpora la pectina mezclada con un poco de azúcar, lleva a ebullición y después añade el resto del azúcar.',
      // FR: Fais bouillir à gros bouillons en remuant, selon le paquet de pectine.
      'Hierve a borbotones removiendo, según indique el paquete de pectina.',
      // FR: Verse en pots chauds ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Vierte en tarros calientes escaldados, cierra y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'lavande/Glaçons de lavande et citron': RecipeText(
    // FR: Glaçons de lavande et citron
    name: 'Cubitos de lavanda y limón',
    // FR: Un quart d'heure, et des cubes violets qui parfument limonades et eaux pétillantes tout l'été.
    description: 'Un cuarto de hora y tendrás cubitos violetas que perfuman limonadas y aguas con gas todo el verano.',
    // FR: 4 mois au congélateur
    keeps: '4 meses en el congelador',
    ingredients: <String>[
      'una decena de espigas de lavanda fresca', // FR: une dizaine d'épis de lavande fraîche
      '1 limón sin tratar', // FR: 1 citron non traité
      'agua', // FR: de l'eau
      'dos cubiteras', // FR: deux bacs à glaçons
    ],
    steps: <String>[
      // FR: Rince les épis à l'eau froide et secoue-les.
      'Aclara las espigas con agua fría y sacúdelas.',
      // FR: Détache les fleurs des épis et prélève de fines lanières de zeste de citron.
      'Separa las flores de las espigas y saca tiras finas de piel de limón.',
      // FR: Mets quelques fleurs et un bout de zeste dans chaque case : **pas plus**, sinon la boisson devient savonneuse.
      'Pon unas pocas flores y un trozo de piel en cada hueco: **no más**, o la bebida sabrá a jabón.',
      // FR: Verse l'eau froide à ras. Une eau bouillie puis refroidie donne des glaçons plus transparents.
      'Llena de agua fría hasta el borde. Con agua hervida y enfriada, los cubitos salen más transparentes.',
      // FR: Congèle jusqu'à ce que ce soit dur, puis démoule les glaçons dans un sac fermé.
      'Congela hasta que estén duros y desmolda los cubitos en una bolsa cerrada.',
    ],
  ),
  'lavande/Sucre à la lavande': RecipeText(
    // FR: Sucre à la lavande
    name: 'Azúcar de lavanda',
    // FR: Fleurs séchées enfouies dans le sucre, deux semaines.
    description: 'Flores secas enterradas en el azúcar, dos semanas.',
  ),
  'lavande/Crème glacée à la lavande': RecipeText(
    // FR: Crème glacée à la lavande
    name: 'Helado de lavanda',
    // FR: Très peu de fleurs : elle vire vite au savon.
    description: 'Muy pocas flores: enseguida sabe a jabón.',
  ),
  'lavande/Miel de lavande maison': RecipeText(
    // FR: Miel de lavande maison
    name: 'Miel de lavanda casera',
    // FR: Un miel neutre parfumé à froid par les fleurs.
    description: 'Una miel neutra aromatizada en frío por las flores.',
  ),

  // ─────────── lentille (6 recettes) ───────────
  'lentille/Lentilles récoltées et séchées': RecipeText(
    // FR: Lentilles récoltées et séchées
    name: 'Lentejas cosechadas y secadas',
    // FR: Battues, triées et bien sèches, tes lentilles se gardent comme celles du commerce, sans un seul insecte.
    description: 'Trilladas, seleccionadas y bien secas, tus lentejas se conservan como las del comercio, sin un solo insecto.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 año en seco, a salvo de los insectos',
    ingredients: <String>[
      'las plantas de lenteja cosechadas cuando las vainas están marrones', // FR: les plants de lentilles récoltés quand les gousses sont brunes
      'una sábana grande', // FR: un grand drap
      'tarros de cristal bien secos', // FR: des bocaux en verre bien secs
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Arrache les plants quand la plupart des gousses sont brunes et sonnent, et laisse-les finir de sécher une semaine à l'abri, sur un drap.
      'Arranca las plantas cuando la mayoría de las vainas estén marrones y suenen, y déjalas acabar de secar una semana a cubierto, sobre una sábana.',
      // FR: Bats les plants sur le drap ou piétine-les dans un sac : les gousses s'ouvrent et libèrent les graines.
      'Golpea las plantas sobre la sábana o písalas dentro de un saco: las vainas se abren y sueltan las semillas.',
      // FR: Vanne au vent ou devant un ventilateur, en versant d'un seau à l'autre, pour chasser les débris.
      'Avienta al viento o delante de un ventilador, echándolas de un cubo a otro, para eliminar los restos.',
      // FR: Trie à la main sur un plateau : retire cailloux, graines percées ou tachées.
      'Selecciónalas a mano sobre una bandeja: retira piedrecitas y semillas picadas o manchadas.',
      // FR: Étale les lentilles en couche fine et laisse-les sécher encore quelques jours : une graine prête **ne marque plus** sous la dent.
      'Extiende las lentejas en una capa fina y déjalas secar unos días más: una semilla lista **ya no se marca** al morderla.',
      // FR: Passe-les **3 jours au congélateur** en sacs : ça tue les œufs de bruche invisibles qui perceraient tes graines au placard.
      'Pásalas **3 días por el congelador** en bolsas: así mueren los huevos de gorgojo invisibles que agujerearían tus semillas en la despensa.',
      // FR: Laisse-les revenir à température ambiante dans le sac fermé, puis mets en bocaux hermétiques, au sec. Toujours cuites avant de manger.
      'Déjalas volver a temperatura ambiente dentro de la bolsa cerrada y pásalas a tarros herméticos, en un lugar seco. Siempre cocidas antes de comer.',
    ],
  ),
  'lentille/Lentilles précuites en portions': RecipeText(
    // FR: Lentilles précuites en portions
    name: 'Lentejas precocidas en porciones',
    // FR: Cuites al dente un quart d'heure et congelées à plat : une salade ou un plat mijoté prêt en cinq minutes.
    description: 'Cocidas al dente un cuarto de hora y congeladas en plano: una ensalada o un guiso listo en cinco minutos.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 kg de lentejas verdes secas', // FR: 1 kg de lentilles vertes sèches
      '1 cebolla pinchada con un clavo', // FR: 1 oignon piqué d'un clou de girofle
      '1 hoja de laurel', // FR: 1 feuille de laurier
      'sal', // FR: sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Rince les lentilles à l'eau froide en retirant les petits cailloux.
      'Aclara las lentejas con agua fría quitando las piedrecitas.',
      // FR: Mets-les dans trois fois leur volume d'eau froide avec l'oignon et le laurier, **sans sel**, et cuis à petit frémissement.
      'Ponlas en tres veces su volumen de agua fría con la cebolla y el laurel, **sin sal**, y cuece a fuego muy suave.',
      // FR: Sale en fin de cuisson : salées au départ, leur peau durcit. Arrête quand elles sont encore un peu fermes, elles finiront de cuire au réchauffage.
      'Sala al final de la cocción: si se salan al principio, la piel se endurece. Para cuando aún estén un poco firmes, acabarán de hacerse al recalentar.',
      // FR: Égoutte et rince-les à l'eau froide pour stopper la cuisson, puis égoutte bien.
      'Escúrrelas y acláralas con agua fría para cortar la cocción; después escúrrelas bien.',
      // FR: Répartis en sacs d'une portion, aplatis-les et date. Elles se réchauffent encore gelées, dans une sauce ou à la vapeur.
      'Reparte en bolsas de una ración, aplánalas y anota la fecha. Se recalientan aún congeladas, en una salsa o al vapor.',
    ],
  ),
  'lentille/Soupe de lentilles au cumin à congeler': RecipeText(
    // FR: Soupe de lentilles au cumin à congeler
    name: 'Sopa de lentejas con comino para congelar',
    // FR: Une grande marmite pour la semaine et des portions au congélateur pour les soirs d'hiver.
    description: 'Una olla grande para la semana y raciones en el congelador para las noches de invierno.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '500 g de lentejas verdes secas', // FR: 500 g de lentilles vertes sèches
      '2 zanahorias', // FR: 2 carottes
      '1 cebolla', // FR: 1 oignon
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '2 litros de caldo', // FR: 2 litres de bouillon
      '1 cucharadita de comino, sal', // FR: 1 cuillère à café de cumin, sel
    ],
    steps: <String>[
      // FR: Rince les lentilles et retire les éventuels cailloux.
      'Aclara las lentejas y quita las posibles piedrecitas.',
      // FR: Coupe l'oignon et les carottes en petits dés, écrase l'ail.
      'Corta la cebolla y las zanahorias en daditos y machaca el ajo.',
      // FR: Fais revenir l'oignon, les carottes, l'ail et le cumin dans un filet d'huile, 5 minutes.
      'Sofríe la cebolla, las zanahorias, el ajo y el comino en un chorrito de aceite, 5 minutos.',
      // FR: Ajoute les lentilles et le bouillon, et laisse cuire à frémissement jusqu'à ce qu'elles soient fondantes.
      'Añade las lentejas y el caldo, y cuece a fuego suave hasta que estén blandas.',
      // FR: Mixe à moitié, pour garder des morceaux, puis sale.
      'Tritura a medias, para conservar algunos trozos, y sala.',
      // FR: Refroidis vite, casserole dans l'eau froide : une soupe tiède congelée fait de gros cristaux.
      'Enfría rápido, con la cazuela metida en agua fría: una sopa tibia congelada forma cristales grandes.',
      // FR: Répartis en portions en laissant 2 cm de vide, ferme et date.
      'Reparte en raciones dejando 2 cm de vacío, cierra y anota la fecha.',
    ],
  ),
  'lentille/Salade de lentilles à l\'échalote': RecipeText(
    // FR: Salade de lentilles à l'échalote
    name: 'Ensalada de lentejas con chalota',
    // FR: Tièdes, vinaigrette moutardée, beaucoup d'échalote.
    description: 'Tibias, con vinagreta de mostaza y mucha chalota.',
  ),
  'lentille/Petit salé aux lentilles': RecipeText(
    // FR: Petit salé aux lentilles
    name: 'Lentejas con cerdo en salazón (petit salé)',
    // FR: Le plat du dimanche, qui mijote sans surveillance.
    description: 'El plato del domingo, que se hace solo a fuego lento.',
  ),
  'lentille/Dahl de lentilles corail': RecipeText(
    // FR: Dahl de lentilles corail
    name: 'Dahl de lentejas rojas',
    // FR: Coco, curcuma, gingembre — prêt en vingt minutes.
    description: 'Coco, cúrcuma y jengibre: listo en veinte minutos.',
  ),

  // ─────────── mache (5 recettes) ───────────
  'mache/Velouté de mâche à congeler': RecipeText(
    // FR: Velouté de mâche à congeler
    name: 'Crema de canónigos para congelar',
    // FR: Une salade ne se conserve pas — son velouté, si. C'est la réponse pour toute feuille tendre.
    description: 'Una ensalada no se conserva, pero su crema sí. Es la respuesta para cualquier hoja tierna.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '600 g de canónigos', // FR: 600 g de mâche
      '4 patatas', // FR: 4 pommes de terre
      '2 chalotas', // FR: 2 échalotes
      '1,2 litros de caldo', // FR: 1,2 litre de bouillon
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Lave la mâche dans plusieurs eaux : le sable reste au coeur des bouquets, et il ne part pas à la cuisson.
      'Lava los canónigos en varias aguas: la arena se queda en el corazón de los cogollos y no se va con la cocción.',
      // FR: Cuis pommes de terre et échalotes en dés dans le bouillon, 15 minutes.
      'Cuece las patatas y las chalotas en dados en el caldo, 15 minutos.',
      // FR: Jette la mâche et compte **2 minutes**, pas plus. Au-delà, le vert tourne au kaki et ne revient jamais.
      'Echa los canónigos y cuenta **2 minutos**, no más. Pasado ese tiempo, el verde vira a caqui y no vuelve nunca.',
      // FR: Mixe aussitôt, hors du feu. **Sans crème** : elle tranche à la décongélation. Tu l'ajouteras dans l'assiette.
      'Tritura enseguida, fuera del fuego. **Sin nata**: se corta al descongelar. La añadirás en el plato.',
      // FR: Refroidis vite — casserole dans l'eau froide. Un velouté tiède mis au congélateur fait de gros cristaux qui le rendent granuleux.
      'Enfría rápido, con la cazuela metida en agua fría. Una crema tibia metida en el congelador forma cristales grandes que la vuelven granulosa.',
      // FR: Répartis en portions d'un repas, en laissant 2 cm de vide : ça gonfle en gelant. Note la date.
      'Reparte en raciones de una comida, dejando 2 cm de vacío: al congelarse se hincha. Anota la fecha.',
    ],
  ),
  'mache/Mâche blanchie congelée': RecipeText(
    // FR: Mâche blanchie congelée
    name: 'Canónigos escaldados congelados',
    // FR: Blanchie vingt secondes, essorée, congelée en boulettes : prête pour une omelette ou un gratin.
    description: 'Escaldados veinte segundos, escurridos y congelados en bolitas: listos para una tortilla o un gratinado.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 kg de canónigos', // FR: 1 kg de mâche
      'sal gorda', // FR: gros sel
      'un cuenco grande de agua con cubitos de hielo', // FR: un grand saladier d'eau et de glaçons
    ],
    steps: <String>[
      // FR: Lave la mâche à fond et équeute les racines encore attachées.
      'Lava los canónigos a fondo y corta las raíces que aún queden pegadas.',
      // FR: Porte une grande eau salée à gros bouillons. Beaucoup d'eau : elle ne doit pas refroidir quand tu jettes les feuilles.
      'Lleva a ebullición fuerte una olla grande de agua con sal. Mucha agua: no debe enfriarse cuando eches las hojas.',
      // FR: Plonge la mâche **20 secondes**, pas plus. Le blanchiment tue les enzymes qui jaunissent les feuilles au congélateur ; trop long, et il n'y a plus de feuille.
      'Sumerge los canónigos **20 segundos**, no más. El escaldado destruye las enzimas que amarillean las hojas en el congelador; si te pasas, ya no queda hoja.',
      // FR: Sors-la et plonge-la aussitôt dans l'eau glacée. Ce choc fixe le vert.
      'Sácalos y sumérgelos enseguida en el agua helada. Ese choque fija el verde.',
      // FR: Presse-la en boule entre tes mains pour chasser l'eau — vraiment fort. L'eau qui reste devient du givre.
      'Aprieta los canónigos en bola entre las manos para sacar el agua, pero con ganas. El agua que queda se convierte en escarcha.',
      // FR: Forme des boulettes de la taille d'une portion, pose-les sur une plaque, congèle 2 heures, puis mets-les en sac.
      'Forma bolitas del tamaño de una ración, colócalas en una bandeja, congela 2 horas y pásalas a una bolsa.',
    ],
  ),
  'mache/Pesto de mâche en glaçons': RecipeText(
    // FR: Pesto de mâche en glaçons
    name: 'Pesto de canónigos en cubitos',
    // FR: Un quart d'heure, et des cubes verts à jeter dans des pâtes tout l'hiver.
    description: 'Un cuarto de hora y tendrás cubos verdes para echar a la pasta todo el invierno.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '300 g de canónigos', // FR: 300 g de mâche
      '60 g de avellanas o de almendras', // FR: 60 g de noisettes ou d'amandes
      '80 g de parmesano', // FR: 80 g de parmesan
      '1 diente de ajo', // FR: 1 gousse d'ail
      '15 cl de aceite de oliva, sal', // FR: 15 cl d'huile d'olive, sel
    ],
    steps: <String>[
      // FR: Fais torréfier les noisettes à sec 3 minutes : la mâche a un goût de noisette, on l'appuie.
      'Tuesta las avellanas en seco 3 minutos: los canónigos saben un poco a avellana y así lo refuerzas.',
      // FR: Lave la mâche et **sèche-la bien**. De l'eau dans un pesto le fait tourner.
      'Lava los canónigos y **sécalos bien**. El agua en un pesto lo estropea.',
      // FR: Mixe mâche, ail et noisettes par à-coups, pour ne pas chauffer et noircir les feuilles.
      'Tritura canónigos, ajo y avellanas a golpes, para que no se calienten y no se ennegrezcan las hojas.',
      // FR: Verse l'huile en filet. **Garde le parmesan de côté** : au congélateur il devient farineux, tu l'ajouteras au moment de servir.
      'Añade el aceite en hilo. **Reserva el parmesano**: en el congelador se vuelve harinoso, lo añadirás a la hora de servir.',
      // FR: Remplis un bac à glaçons, un cube par portion de pâtes, et couvre d'un filet d'huile.
      'Llena una cubitera, un cubo por ración de pasta, y cubre con un chorrito de aceite.',
      // FR: Démoule les cubes une fois durs et garde-les en sac. Un cube fond directement dans les pâtes chaudes.
      'Desmolda los cubos cuando estén duros y guárdalos en una bolsa. Un cubo se derrite directamente en la pasta caliente.',
    ],
  ),
  'mache/Mâche, betterave et noix': RecipeText(
    // FR: Mâche, betterave et noix
    name: 'Canónigos, remolacha y nueces',
    // FR: La salade d'hiver par excellence, trois ingrédients et c'est tout.
    description: 'La ensalada de invierno por excelencia: tres ingredientes y nada más.',
    ingredients: <String>[
      '200 g de canónigos', // FR: 200 g de mâche
      '2 remolachas cocidas', // FR: 2 betteraves cuites
      '60 g de nueces peladas', // FR: 60 g de cerneaux de noix
      '1 cucharadita de mostaza', // FR: 1 cuillère à café de moutarde
      'vinagre de sidra, aceite de nuez, sal', // FR: vinaigre de cidre, huile de noix, sel
    ],
    steps: <String>[
      // FR: Lave la mâche dans plusieurs eaux : le sable reste au coeur des bouquets.
      'Lava los canónigos en varias aguas: la arena se queda en el corazón de los cogollos.',
      // FR: Sèche-la délicatement, elle s'écrase vite.
      'Sécalos con delicadeza, se aplastan enseguida.',
      // FR: Vinaigrette à la moutarde et à l'huile de noix.
      'Vinagreta con mostaza y aceite de nuez.',
      // FR: Dés de betterave, noix concassées, et mélange au dernier moment.
      'Dados de remolacha, nueces troceadas, y mezcla en el último momento.',
    ],
  ),
  'mache/Mâche aux lardons et œuf poché': RecipeText(
    // FR: Mâche aux lardons et œuf poché
    name: 'Canónigos con panceta y huevo poché',
    // FR: Tiède, avec un jaune coulant qui fait la sauce.
    description: 'Tibia, con una yema líquida que hace de salsa.',
    ingredients: <String>[
      '150 g de canónigos', // FR: 150 g de mâche
      '100 g de taquitos de panceta', // FR: 100 g de lardons
      '2 huevos muy frescos', // FR: 2 oeufs très frais
      '1 cucharada sopera de vinagre', // FR: 1 cuillère à soupe de vinaigre
      'pan, aceite, pimienta', // FR: pain, huile, poivre
    ],
    steps: <String>[
      // FR: Fais dorer les lardons, réserve-les dans leur gras.
      'Dora los taquitos de panceta y resérvalos en su grasa.',
      // FR: Fais griller des dés de pain dans la même poêle.
      'Tuesta dados de pan en la misma sartén.',
      // FR: Casse les oeufs dans une eau frémissante vinaigrée, 3 minutes.
      'Casca los huevos en agua a fuego suave con vinagre, 3 minutos.',
      // FR: Mâche dans l'assiette, lardons et croûtons tièdes dessus.
      'Pon los canónigos en el plato, con la panceta y los picatostes tibios encima.',
      // FR: Pose l'oeuf, poivre, et perce-le à table.
      'Coloca el huevo, echa pimienta y pínchalo en la mesa.',
    ],
  ),

  // ─────────── mais (6 recettes) ───────────
  'mais/Grains de maïs doux au congélateur': RecipeText(
    // FR: Grains de maïs doux au congélateur
    name: 'Granos de maíz dulce en el congelador',
    // FR: Le maïs perd son sucre dans les heures qui suivent la cueillette : blanchi tout de suite, il le garde jusqu'à Noël.
    description: 'El maíz pierde su azúcar en las horas que siguen a la cosecha: escaldado enseguida, la conserva hasta Navidad.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '6 mazorcas de maíz dulce recogidas ese mismo día', // FR: 6 épis de maïs doux cueillis du jour
      'un cuenco grande de agua helada', // FR: un grand saladier d'eau glacée
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Effeuille les épis et retire toutes les soies, au besoin avec une brosse à légumes.
      'Quita las hojas de las mazorcas y todas las barbas, si hace falta con un cepillo de verduras.',
      // FR: Plonge les épis entiers dans une grande casserole d'eau bouillante non salée : **4 minutes**.
      'Sumerge las mazorcas enteras en una olla grande de agua hirviendo sin sal: **4 minutos**.',
      // FR: Transfère-les dans l'eau glacée jusqu'à ce qu'ils soient froids à cœur, autant de temps que la cuisson.
      'Pásalas al agua helada hasta que estén frías por dentro, el mismo tiempo que la cocción.',
      // FR: Pose chaque épi debout dans un grand plat et égrène au couteau, de haut en bas, sans racler le cœur.
      'Pon cada mazorca de pie en una fuente grande y desgrana con un cuchillo, de arriba abajo, sin rascar el corazón.',
      // FR: Étale les grains sur une plaque, congèle 1 heure, puis verse en sac : ils restent bien séparés.
      'Extiende los granos en una bandeja, congela 1 hora y échalos en una bolsa: quedan bien sueltos.',
    ],
  ),
  'mais/Relish de maïs et poivron': RecipeText(
    // FR: Relish de maïs et poivron
    name: 'Relish de maíz y pimiento',
    // FR: Un condiment jaune et rouge, sucré-acidulé, qui transforme un hamburger ou une assiette de riz.
    description: 'Un condimento amarillo y rojo, agridulce, que transforma una hamburguesa o un plato de arroz.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      'los granos de 6 mazorcas de maíz (unos 800 g)', // FR: les grains de 6 épis de maïs (environ 800 g)
      '2 pimientos rojos', // FR: 2 poivrons rouges
      '1 cebolla', // FR: 1 oignon
      '50 cl de vinagre de sidra de 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '150 g de azúcar y 1 cucharada sopera de sal', // FR: 150 g de sucre et 1 cuillère à soupe de sel
      '1 cucharadita de cúrcuma y 1 de semillas de mostaza', // FR: 1 cuillère à café de curcuma et 1 de graines de moutarde
    ],
    steps: <String>[
      // FR: Blanchis les épis 4 minutes, rafraîchis-les et égrène-les au couteau.
      'Escalda las mazorcas 4 minutos, refréscalas y desgrana con un cuchillo.',
      // FR: Coupe les poivrons et l'oignon en petits dés, de la taille des grains.
      'Corta los pimientos y la cebolla en daditos, del tamaño de los granos.',
      // FR: Porte le vinaigre, le sucre, le sel et les épices à ébullition. **Pas d'eau** : le relish reste bien acide.
      'Lleva el vinagre, el azúcar, la sal y las especias a ebullición. **Sin agua**: el relish queda bien ácido.',
      // FR: Ajoute tous les légumes et laisse frémir en remuant de temps en temps.
      'Añade todas las verduras y deja que hierva suavemente, removiendo de vez en cuando.',
      // FR: Remplis des bocaux propres jusqu'à 2 cm du bord, en tassant pour que le liquide **recouvre** les légumes.
      'Llena tarros limpios hasta 2 cm del borde, apretando para que el líquido **cubra** las verduras.',
      // FR: Ferme, laisse refroidir et range au réfrigérateur. Il est meilleur après une semaine.
      'Cierra, deja enfriar y guarda en la nevera. Está mejor pasada una semana.',
    ],
  ),
  'mais/Maïs doux séché au four': RecipeText(
    // FR: Maïs doux séché au four
    name: 'Maíz dulce secado al horno',
    // FR: Séchés, les grains deviennent de petites billes sucrées qui se gardent au placard et regonflent dans les soupes.
    description: 'Secos, los granos se convierten en bolitas dulces que se guardan en la despensa y se hinchan de nuevo en las sopas.',
    // FR: 1 an au sec, en bocal fermé
    keeps: '1 año en seco, en tarro cerrado',
    ingredients: <String>[
      '12 mazorcas de maíz dulce', // FR: 12 épis de maïs doux
      'papel de horno', // FR: du papier cuisson
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Effeuille les épis et retire bien les soies.
      'Quita las hojas de las mazorcas y retira bien las barbas.',
      // FR: Blanchis-les 4 minutes à l'eau bouillante : ça fixe le sucre avant le séchage.
      'Escáldalas 4 minutos en agua hirviendo: así se fija el azúcar antes del secado.',
      // FR: Rafraîchis-les dans l'eau glacée, égoutte, puis égrène au couteau.
      'Refréscalas en agua helada, escurre y desgrana con un cuchillo.',
      // FR: Étale les grains en une seule couche sur des plaques couvertes de papier, four à **60 °C**, porte entrouverte avec une cuillère en bois.
      'Extiende los granos en una sola capa sobre bandejas cubiertas con papel, horno a **60 °C**, con la puerta entreabierta calzada con una cuchara de madera.',
      // FR: Remue toutes les 2 heures. C'est prêt quand les grains sont durs, ridés et cassent net sous la dent.
      'Remueve cada 2 horas. Está listo cuando los granos están duros, arrugados y se parten de golpe al morderlos.',
      // FR: Laisse refroidir complètement avant de les enfermer en bocal. Pour cuisiner : 2 heures de trempage, puis 30 minutes de cuisson.
      'Deja enfriar por completo antes de encerrarlos en un tarro. Para cocinar: 2 horas de remojo y luego 30 minutos de cocción.',
    ],
  ),
  'mais/Maïs grillé au beurre d\'herbes': RecipeText(
    // FR: Maïs grillé au beurre d'herbes
    name: 'Maíz a la brasa con mantequilla de hierbas',
    // FR: Sur la braise, tourné souvent, badigeonné à la fin.
    description: 'Sobre las brasas, dándole vueltas a menudo y untado al final.',
  ),
  'mais/Maïs grillé': RecipeText(
    // FR: Maïs grillé
    name: 'Maíz asado',
    // FR: L'épi grillé au feu de bois comme au bord de la route, un régal fumé.
    description: 'La mazorca asada en leña como a pie de carretera, un placer ahumado.',
  ),
  'mais/Bouillie de maïs': RecipeText(
    // FR: Bouillie de maïs
    name: 'Gachas de maíz',
    // FR: Une bouillie douce et crémeuse, sucrée juste ce qu'il faut pour le matin.
    description: 'Unas gachas suaves y cremosas, dulces justo lo necesario para la mañana.',
  ),

  // ─────────── manioc (6 recettes) ───────────
  'manioc/Manioc épluché congelé cru': RecipeText(
    // FR: Manioc épluché congelé cru
    name: 'Yuca pelada congelada cruda',
    // FR: Le manioc frais noircit en trois jours ; épluché et congelé, il attend des mois. À cuire toujours avant de manger.
    description: 'La yuca fresca se ennegrece en tres días; pelada y congelada, espera meses. Hay que cocerla siempre antes de comer.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '2 kg de yuca fresca', // FR: 2 kg de manioc frais
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les racines en tronçons de 8 cm. Fends la peau sur la longueur et soulève-la avec la lame : l'écorce et la couche rose partent ensemble.
      'Corta las raíces en trozos de 8 cm. Abre la piel a lo largo y levántala con la hoja del cuchillo: la corteza y la capa rosa salen juntas.',
      // FR: Rince bien les tronçons et jette ceux qui ont des veines noires ou bleues.
      'Aclara bien los trozos y tira los que tengan vetas negras o azules.',
      // FR: Sèche-les dans un torchon pour éviter le givre.
      'Sécalos con un paño para evitar la escarcha.',
      // FR: Mets-les en sacs par portions, chasse l'air et note la date.
      'Ponlos en bolsas por raciones, saca el aire y anota la fecha.',
      // FR: Cuis-les **sans décongeler** dans l'eau bouillante salée, 25 à 30 minutes jusqu'à tendreté, puis retire la fibre centrale. **Jamais cru.**
      'Cuécelos **sin descongelar** en agua hirviendo con sal, de 25 a 30 minutos hasta que estén tiernos, y retira la fibra central. **Nunca cruda.**',
    ],
  ),
  'manioc/Manioc précuit pour la poêle': RecipeText(
    // FR: Manioc précuit pour la poêle
    name: 'Yuca precocida para la sartén',
    // FR: Bouilli puis congelé, il ne reste qu'à le dorer : le manioc du soir en dix minutes.
    description: 'Hervida y congelada, solo queda dorarla: la yuca de la noche en diez minutos.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 kg de yuca fresca', // FR: 2 kg de manioc frais
      'sal gorda', // FR: gros sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche le manioc en enlevant toute l'écorce et la couche rose, coupe en tronçons de 6 cm.
      'Pela la yuca quitando toda la corteza y la capa rosa, y corta en trozos de 6 cm.',
      // FR: Cuis dans une grande eau salée jusqu'à ce que la chair s'entrouvre et devienne translucide.
      'Cuece en abundante agua con sal hasta que la carne se abra y se vuelva translúcida.',
      // FR: Égoutte, coupe chaque tronçon en deux et retire la **fibre centrale**, dure et filandreuse.
      'Escurre, corta cada trozo por la mitad y retira la **fibra central**, dura y filamentosa.',
      // FR: Laisse refroidir complètement à l'air, en une couche.
      'Deja enfriar por completo al aire, en una sola capa.',
      // FR: Congèle 2 heures sur plaque, puis mets en sacs.
      'Congela 2 horas en una bandeja y pasa a bolsas.',
      // FR: Fais-les dorer encore gelés à la poêle ou à la friture, ou réchauffe-les à la vapeur.
      'Dóralos aún congelados en la sartén o en fritura, o recaliéntalos al vapor.',
    ],
  ),
  'manioc/Farine de manioc rouie': RecipeText(
    // FR: Farine de manioc rouie
    name: 'Harina de yuca enriada',
    // FR: Le trempage de plusieurs jours puis le séchage, c'est la méthode qui rend le manioc sûr et le garde un an.
    description: 'El remojo de varios días y después el secado: es el método que hace la yuca segura y la conserva un año.',
    // FR: 1 an au sec, à l'abri de l'humidité
    keeps: '1 año en seco, protegida de la humedad',
    ingredients: <String>[
      '3 kg de yuca fresca', // FR: 3 kg de manioc frais
      'un cubo grande de agua limpia', // FR: un grand seau d'eau propre
      'un paño resistente', // FR: un torchon solide
      'un tarro o cubo hermético', // FR: un bocal ou seau hermétique
    ],
    steps: <String>[
      // FR: Épluche le manioc en enlevant écorce et couche rose, coupe-le en gros tronçons.
      'Pela la yuca quitando la corteza y la capa rosa, y córtala en trozos grandes.',
      // FR: Mets-le à tremper dans un seau d'eau, bien couvert d'eau. **Change l'eau chaque jour.**
      'Ponla a remojo en un cubo de agua, bien cubierta. **Cambia el agua cada día.**',
      // FR: Laisse rouir 3 à 4 jours, jusqu'à ce que les morceaux s'écrasent sous le doigt. Sur un manioc amer, cette étape **n'est jamais facultative**.
      'Deja enriar de 3 a 4 días, hasta que los trozos se aplasten al presionarlos con el dedo. En una yuca amarga, este paso **nunca es opcional**.',
      // FR: Égoutte, retire les fibres, puis presse la pulpe dans un torchon pour chasser le maximum d'eau.
      'Escurre, retira las fibras y después prensa la pulpa en un paño para sacar el máximo de agua.',
      // FR: Émiette et sèche à 60 °C jusqu'à ce que ça soit cassant et sec, ou 2 à 3 jours au soleil.
      'Desmenuza y seca a 60 °C hasta que esté quebradiza y seca, o de 2 a 3 días al sol.',
      // FR: Pile ou mixe, puis tamise finement.
      'Machaca en el mortero o tritura, y tamiza fino.',
      // FR: Stocke en bocal hermétique. La farine se cuit toujours dans l'eau bouillante en remuant avant de se manger.
      'Guarda en un tarro hermético. La harina se cuece siempre en agua hirviendo, removiendo, antes de comerla.',
    ],
  ),
  'manioc/Attiéké': RecipeText(
    // FR: Attiéké
    name: 'Attiéké',
    // FR: La semoule de manioc ivoirienne, légère et acidulée, avec poisson braisé.
    description: 'La sémola de yuca de Costa de Marfil, ligera y acidulada, con pescado a la brasa.',
  ),
  'manioc/Foufou de manioc': RecipeText(
    // FR: Foufou de manioc
    name: 'Foufou de yuca',
    // FR: La pâte de manioc pilée, souple et réconfortante, compagne de toutes les sauces.
    description: 'La masa de yuca machacada, suave y reconfortante, compañera de todas las salsas.',
  ),
  'manioc/Frites de manioc': RecipeText(
    // FR: Frites de manioc
    name: 'Patatas fritas de yuca',
    // FR: Des bâtonnets de manioc frits, croustillants dehors et fondants dedans.
    description: 'Bastones de yuca fritos, crujientes por fuera y tiernos por dentro.',
  ),

  // ─────────── marjolaine (6 recettes) ───────────
  'marjolaine/Marjolaine séchée en petites bottes': RecipeText(
    // FR: Marjolaine séchée en petites bottes
    name: 'Mejorana seca en manojitos',
    // FR: Plus douce que l'origan, elle sèche aussi bien et parfume tes plats mijotés tout l'hiver.
    description: 'Más suave que el orégano, se seca igual de bien y perfuma tus guisos todo el invierno.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegida de la luz',
    ingredients: <String>[
      'tallos de mejorana justo antes de la floración', // FR: des tiges de marjolaine juste avant la floraison
      'cordel', // FR: de la ficelle
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges à 5 cm du sol, en fin de matinée, quand les boutons floraux apparaissent.
      'Corta los tallos a 5 cm del suelo, a media mañana, cuando aparecen los botones florales.',
      // FR: Lie-les en petites bottes de la grosseur d'un pouce : trop serrées, elles noircissent au cœur.
      'Átalos en manojitos del grosor de un pulgar: si van muy apretados, se ennegrecen por dentro.',
      // FR: Suspends-les tête en bas à l'ombre, dans un endroit sec et aéré, une dizaine de jours.
      'Cuélgalos boca abajo a la sombra, en un lugar seco y ventilado, unos diez días.',
      // FR: Effeuille au-dessus d'un plateau quand les feuilles se brisent sous les doigts.
      'Deshoja sobre una bandeja cuando las hojas se rompan al tocarlas.',
      // FR: Mets en bocal bien fermé et note la date : son parfum fléchit au bout d'un an.
      'Guarda en un tarro bien cerrado y anota la fecha: su aroma flaquea al cabo de un año.',
    ],
  ),
  'marjolaine/Glaçons de marjolaine à l\'eau': RecipeText(
    // FR: Glaçons de marjolaine à l'eau
    name: 'Cubitos de mejorana con agua',
    // FR: Des cubes parfumés à jeter dans une soupe ou une sauce, sans une goutte de gras.
    description: 'Cubos aromáticos para echar a una sopa o a una salsa, sin una gota de grasa.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 puñados de hojas de mejorana', // FR: 2 poignées de feuilles de marjolaine
      'agua', // FR: de l'eau
      'una cubitera', // FR: un bac à glaçons
      'una bolsa de congelación', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Rince les tiges et égoutte-les.
      'Aclara los tallos y escúrrelos.',
      // FR: Effeuille et hache finement les feuilles.
      'Deshoja y pica fino las hojas.',
      // FR: Remplis chaque case à moitié de marjolaine et couvre d'eau froide en tassant pour que tout baigne.
      'Llena cada hueco hasta la mitad de mejorana y cubre con agua fría, apretando para que todo quede sumergido.',
      // FR: Congèle jusqu'à ce que les cubes soient durs, puis démoule-les en sac fermé.
      'Congela hasta que los cubos estén duros y desmóldalos en una bolsa cerrada.',
      // FR: Ajoute un cube **en fin de cuisson** dans les soupes et les sauces : il fond en deux minutes.
      'Añade un cubo **al final de la cocción** en las sopas y las salsas: se derrite en dos minutos.',
    ],
  ),
  'marjolaine/Herbes de Provence du jardin': RecipeText(
    // FR: Herbes de Provence du jardin
    name: 'Hierbas provenzales del huerto',
    // FR: Ta marjolaine séchée avec le thym, la sarriette et le romarin : le mélange des grillades, sans rien acheter.
    description: 'Tu mejorana seca con el tomillo, la ajedrea y el romero: la mezcla de las parrilladas, sin comprar nada.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegidas de la luz',
    ingredients: <String>[
      '4 cucharadas soperas de mejorana seca', // FR: 4 cuillères à soupe de marjolaine séchée
      '4 cucharadas soperas de tomillo seco', // FR: 4 cuillères à soupe de thym séché
      '2 cucharadas soperas de ajedrea seca', // FR: 2 cuillères à soupe de sarriette séchée
      '1 cucharada sopera de romero seco', // FR: 1 cuillère à soupe de romarin séché
      '1 cucharada sopera de orégano seco', // FR: 1 cuillère à soupe d'origan séché
    ],
    steps: <String>[
      // FR: Fais sécher chaque herbe en petites bottes, à l'ombre et au sec, une dizaine de jours. Elles doivent toutes **casser net**.
      'Seca cada hierba en manojitos, a la sombra y en seco, unos diez días. Todas deben **partirse de golpe**.',
      // FR: Effeuille-les une par une au-dessus d'un plateau et retire tous les bouts de tige.
      'Deshójalas una a una sobre una bandeja y retira todos los trozos de tallo.',
      // FR: Hache grossièrement les aiguilles de romarin, trop longues et dures entières.
      'Pica grueso las agujas de romero, demasiado largas y duras enteras.',
      // FR: Mélange toutes les herbes dans un saladier en les froissant légèrement entre tes mains.
      'Mezcla todas las hierbas en un cuenco arrugándolas ligeramente entre las manos.',
      // FR: Mets en bocal bien fermé, loin de la cuisinière et de la lumière.
      'Guarda en un tarro bien cerrado, lejos de la cocina y de la luz.',
    ],
  ),
  'marjolaine/Farce aux herbes': RecipeText(
    // FR: Farce aux herbes
    name: 'Relleno de hierbas',
    // FR: Plus douce que l'origan, idéale dans une farce de volaille.
    description: 'Más suave que el orégano, ideal en un relleno de ave.',
  ),
  'marjolaine/Courgettes à la marjolaine': RecipeText(
    // FR: Courgettes à la marjolaine
    name: 'Calabacines a la mejorana',
    // FR: Sautées, avec de l'ail et beaucoup d'herbe fraîche.
    description: 'Salteados, con ajo y mucha hierba fresca.',
  ),
  'marjolaine/Beurre maître d\'hôtel aux herbes': RecipeText(
    // FR: Beurre maître d'hôtel aux herbes
    name: 'Mantequilla maître d\'hôtel con hierbas',
    // FR: Marjolaine, persil, citron.
    description: 'Mejorana, perejil y limón.',
  ),

  // ─────────── melisse (6 recettes) ───────────
  'melisse/Feuilles de mélisse séchées': RecipeText(
    // FR: Feuilles de mélisse séchées
    name: 'Hojas de melisa secas',
    // FR: Son parfum citronné est fragile : séchée vite et à l'ombre, elle se garde pour les infusions d'hiver.
    description: 'Su aroma a limón es frágil: secada rápido y a la sombra, se conserva para las infusiones de invierno.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegidas de la luz',
    ingredients: <String>[
      'tallos de melisa cortados antes de la floración', // FR: des tiges de mélisse coupées avant la floraison
      'una rejilla o un paño', // FR: une claie ou un torchon
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges **avant la floraison**, en fin de matinée : après, les feuilles sentent moins le citron.
      'Corta los tallos **antes de la floración**, a media mañana: después, las hojas huelen menos a limón.',
      // FR: Détache les feuilles et étale-les en une seule couche sur la claie, sans les laver si elles sont propres.
      'Separa las hojas y extiéndelas en una sola capa sobre la rejilla, sin lavarlas si están limpias.',
      // FR: Laisse-les quatre à cinq jours à l'ombre dans une pièce chaude et aérée, ou quelques heures au déshydrateur à 35 °C.
      'Déjalas de cuatro a cinco días a la sombra en una habitación cálida y ventilada, o unas horas en el deshidratador a 35 °C.',
      // FR: Elles sont prêtes quand elles craquent. Si elles noircissent, c'est qu'elles ont séché trop lentement.
      'Están listas cuando crujen. Si se ennegrecen, es que se han secado demasiado despacio.',
      // FR: Mets-les en bocal **entières** et bien fermé, émiette-les seulement dans la théière.
      'Guárdalas **enteras** en un tarro bien cerrado y desmenúzalas solo en la tetera.',
    ],
  ),
  'melisse/Sirop de mélisse au citron': RecipeText(
    // FR: Sirop de mélisse au citron
    name: 'Almíbar de melisa y limón',
    // FR: Infusée puis cuite au sucre, la mélisse se boit en sirop à l'eau fraîche jusqu'à l'été suivant.
    description: 'Infusionada y luego cocida con azúcar, la melisa se bebe en almíbar con agua fresca hasta el verano siguiente.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierto en la nevera',
    ingredients: <String>[
      '100 g de hojas de melisa', // FR: 100 g de feuilles de mélisse
      '1 litro de agua', // FR: 1 litre d'eau
      '1 kg de azúcar', // FR: 1 kg de sucre
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      '4 botellas de 25 cl con chapas o juntas nuevas', // FR: 4 bouteilles de 25 cl avec capsules ou joints neufs
    ],
    steps: <String>[
      // FR: Rince les feuilles et froisse-les légèrement entre tes mains.
      'Aclara las hojas y arrúgalas ligeramente entre las manos.',
      // FR: Porte l'eau à ébullition, verse-la sur les feuilles et couvre.
      'Lleva el agua a ebullición, vierte sobre las hojas y tapa.',
      // FR: Laisse infuser hors du feu, sans jamais faire bouillir la mélisse : elle perdrait son parfum.
      'Deja infusionar fuera del fuego, sin hervir nunca la melisa: perdería su aroma.',
      // FR: Filtre en pressant bien les feuilles.
      'Filtra apretando bien las hojas.',
      // FR: Ajoute le sucre et le jus de citron, porte à ébullition et laisse bouillir en écumant.
      'Añade el azúcar y el zumo de limón, lleva a ebullición y deja hervir espumando.',
      // FR: Verse chaud dans les bouteilles propres jusqu'à 2 cm du bord, et ferme avec des capsules neuves.
      'Vierte caliente en las botellas limpias hasta 2 cm del borde y cierra con chapas nuevas.',
      // FR: Stérilise 20 minutes dans l'eau bouillante, bouteilles **entièrement couvertes**. Laisse refroidir dans l'eau.
      'Esteriliza 20 minutos en agua hirviendo, con las botellas **totalmente cubiertas**. Deja enfriar en el agua.',
      // FR: Vérifie que les capsules sont creusées. Sinon, garde la bouteille au réfrigérateur et bois-la vite.
      'Comprueba que las chapas están hundidas. Si no, guarda la botella en la nevera y bébela pronto.',
    ],
  ),
  'melisse/Glaçons de mélisse': RecipeText(
    // FR: Glaçons de mélisse
    name: 'Cubitos de melisa',
    // FR: Un quart d'heure, et la fraîcheur citronnée de la mélisse dans tes boissons d'été.
    description: 'Un cuarto de hora y la frescura de limón de la melisa en tus bebidas de verano.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 puñados de hojas de melisa', // FR: 2 poignées de feuilles de mélisse
      'agua', // FR: de l'eau
      'dos cubiteras', // FR: deux bacs à glaçons
      'una bolsa de congelación', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Rince les feuilles et égoutte-les.
      'Aclara las hojas y escúrrelas.',
      // FR: Cisèle-les grossièrement, ou garde de petites feuilles entières pour le joli.
      'Pícalas grueso, o deja hojitas enteras para que quede bonito.',
      // FR: Remplis chaque case à moitié de feuilles, puis complète d'eau froide.
      'Llena cada hueco hasta la mitad de hojas y completa con agua fría.',
      // FR: Congèle jusqu'à ce que ce soit dur, démoule et garde-les en sac fermé.
      'Congela hasta que estén duros, desmolda y guárdalos en una bolsa cerrada.',
      // FR: Jette-les dans l'eau, la citronnade ou une salade de fruits. Pour une infusion, jette deux cubes dans l'eau chaude.
      'Échalos al agua, a la limonada o a una macedonia. Para una infusión, echa dos cubos en el agua caliente.',
    ],
  ),
  'melisse/Infusion de mélisse': RecipeText(
    // FR: Infusion de mélisse
    name: 'Infusión de melisa',
    // FR: Citronnée et apaisante, fraîche ou séchée.
    description: 'Con aroma a limón y calmante, fresca o seca.',
  ),
  'melisse/Limonade à la mélisse': RecipeText(
    // FR: Limonade à la mélisse
    name: 'Limonada de melisa',
    // FR: Feuilles froissées dans l'eau pétillante et le citron.
    description: 'Hojas arrugadas en agua con gas y limón.',
  ),
  'melisse/Salade de fruits à la mélisse': RecipeText(
    // FR: Salade de fruits à la mélisse
    name: 'Macedonia de frutas con melisa',
    // FR: Ciselée fin, elle remplace la menthe avec plus de douceur.
    description: 'Picada fina, sustituye a la menta con más suavidad.',
  ),

  // ─────────── melon (6 recettes) ───────────
  'melon/Billes de melon congelées': RecipeText(
    // FR: Billes de melon congelées
    name: 'Bolitas de melón congeladas',
    // FR: Quand tous les melons mûrissent la même semaine : en billes congelées, ils finissent en smoothies et sorbets minute.
    description: 'Cuando todos los melones maduran la misma semana: en bolitas congeladas, acaban en batidos y sorbetes al instante.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '3 melones bien maduros', // FR: 3 melons bien mûrs
      'el zumo de un limón', // FR: le jus d'un citron
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave et essuie l'écorce avant de couper : le couteau porte sinon la terre jusque dans la chair.
      'Lava y seca la corteza antes de cortar: si no, el cuchillo arrastra la tierra hasta la pulpa.',
      // FR: Coupe les melons en deux, retire les graines et forme des billes à la cuillère parisienne, ou taille des cubes.
      'Corta los melones por la mitad, retira las semillas y forma bolitas con un sacabolas, o corta cubos.',
      // FR: Arrose d'un filet de citron et mélange délicatement.
      'Rocía con un chorrito de limón y mezcla con delicadeza.',
      // FR: Étale sur une plaque **sans qu'elles se touchent** et congèle 3 heures.
      'Extiende en una bandeja **sin que se toquen** y congela 3 horas.',
      // FR: Verse-les en sacs une fois dures. Décongelées elles sont molles : mixe-les encore gelées en smoothie ou en granité.
      'Échalas en bolsas cuando estén duras. Descongeladas están blandas: tritúralas aún congeladas en un batido o en una granizada.',
    ],
  ),
  'melon/Confiture de melon à l\'orange': RecipeText(
    // FR: Confiture de melon à l'orange
    name: 'Mermelada de melón y naranja',
    // FR: La confiture du Midi : le melon macéré au sucre et relevé d'orange et de citron, pour les tartines d'hiver.
    description: 'La mermelada del sur: el melón macerado con azúcar y realzado con naranja y limón, para las tostadas de invierno.',
    // FR: 1 an au placard
    keeps: '1 año en la despensa',
    ingredients: <String>[
      '1,5 kg de pulpa de melón', // FR: 1,5 kg de chair de melon
      '1 kg de azúcar', // FR: 1 kg de sucre
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      '1 naranja sin tratar', // FR: 1 orange non traitée
    ],
    steps: <String>[
      // FR: Épluche les melons, retire les graines et coupe la chair en petits dés. Coupe l'orange en très fines tranches.
      'Pela los melones, retira las semillas y corta la pulpa en daditos. Corta la naranja en rodajas muy finas.',
      // FR: Mélange melon, orange, sucre et jus de citron, couvre et laisse macérer une nuit au frais.
      'Mezcla el melón, la naranja, el azúcar y el zumo de limón, tapa y deja macerar una noche en un sitio fresco.',
      // FR: Porte à ébullition, puis cuis à feu moyen en remuant souvent et en écumant.
      'Lleva a ebullición y cuece a fuego medio removiendo a menudo y espumando.',
      // FR: Ne lésine pas sur le citron : le melon est peu acide, c'est le citron qui **fait prendre et qui conserve**.
      'No escatimes el limón: el melón es poco ácido, y es el limón el que **cuaja y conserva**.',
      // FR: Teste sur une assiette froide : la goutte doit se figer. Le melon est long à prendre, sois patient.
      'Prueba en un plato frío: la gota debe cuajar. El melón tarda en cuajar, ten paciencia.',
      // FR: Mets en pots ébouillantés remplis à 1 cm du bord, ferme aussitôt et retourne jusqu'à refroidissement.
      'Pon en tarros escaldados llenos hasta 1 cm del borde, cierra enseguida y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'melon/Lamelles de melon séchées': RecipeText(
    // FR: Lamelles de melon séchées
    name: 'Láminas de melón secas',
    // FR: Séché doucement, le melon devient une friandise souple et très sucrée pour les goûters.
    description: 'Secado despacio, el melón se convierte en una golosina blanda y muy dulce para la merienda.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegidas de la luz',
    ingredients: <String>[
      '2 melones bien maduros pero firmes', // FR: 2 melons bien mûrs mais fermes
      'papel de horno', // FR: du papier cuisson
      'tarros bien secos', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Épluche les melons, retire les graines et coupe la chair en lamelles régulières de 5 mm.
      'Pela los melones, retira las semillas y corta la pulpa en láminas regulares de 5 mm.',
      // FR: Tamponne les lamelles dans un torchon pour enlever le jus de surface.
      'Dales toquecitos con un paño para quitar el jugo de la superficie.',
      // FR: Étale-les sur les plaques sans qu'elles se touchent et sèche au four à **60 °C**, porte entrouverte, ou au déshydrateur.
      'Extiéndelas en las bandejas sin que se toquen y seca en el horno a **60 °C**, con la puerta entreabierta, o en el deshidratador.',
      // FR: Retourne-les à mi-séchage. Elles sont prêtes quand elles sont **souples comme du cuir**, sans aucune humidité au centre.
      'Dales la vuelta a mitad del secado. Están listas cuando son **flexibles como el cuero**, sin ninguna humedad en el centro.',
      // FR: Laisse refroidir, mets en bocal et secoue chaque jour la première semaine. De la buée ? Remets-les au four.
      'Deja enfriar, pásalas a un tarro y agítalo cada día la primera semana. ¿Vaho? Vuelven al horno.',
    ],
  ),
  'melon/Melon au jambon cru': RecipeText(
    // FR: Melon au jambon cru
    name: 'Melón con jamón',
    // FR: Le sucré et le salé, l'été, sans rien cuire.
    description: 'Lo dulce y lo salado, en verano, sin cocinar nada.',
  ),
  'melon/Soupe froide melon-menthe': RecipeText(
    // FR: Soupe froide melon-menthe
    name: 'Sopa fría de melón y menta',
    // FR: Mixé, bien glacé, un tour de poivre du moulin.
    description: 'Triturado, bien helado, con una vuelta de pimienta del molinillo.',
  ),
  'melon/Melon en salade au chèvre frais': RecipeText(
    // FR: Melon en salade au chèvre frais
    name: 'Ensalada de melón con queso de cabra fresco',
    // FR: Avec de la roquette et des pignons grillés.
    description: 'Con rúcula y piñones tostados.',
  ),

  // ─────────── menthe (6 recettes) ───────────
  'menthe/Glaçons de menthe': RecipeText(
    // FR: Glaçons de menthe
    name: 'Cubitos de menta',
    // FR: Les feuilles prises dans la glace gardent leur vert : un cube pour une limonade, trois pour une sauce au yaourt.
    description: 'Las hojas atrapadas en el hielo conservan su verde: un cubo para una limonada, tres para una salsa de yogur.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '4 buenos puñados de menta', // FR: 4 belles poignées de menthe
      'agua', // FR: de l'eau
      'cubiteras', // FR: des bacs à glaçons
    ],
    steps: <String>[
      // FR: Rince les tiges et effeuille-les. Jette les feuilles tachées ou abîmées.
      'Aclara los tallos y deshójalos. Tira las hojas manchadas o estropeadas.',
      // FR: Hache grossièrement les feuilles, ou laisse-les entières pour les boissons.
      'Pica grueso las hojas, o déjalas enteras para las bebidas.',
      // FR: Remplis les bacs aux deux tiers de feuilles et couvre d'eau froide, en appuyant pour **noyer** les feuilles.
      'Llena las cubiteras hasta dos tercios de hojas y cubre con agua fría, apretando para **ahogar** las hojas.',
      // FR: Congèle jusqu'à ce que les cubes soient durs, puis démoule-les dans un sac bien fermé.
      'Congela hasta que los cubos estén duros y desmóldalos en una bolsa bien cerrada.',
    ],
  ),
  'menthe/Menthe séchée en bouquets': RecipeText(
    // FR: Menthe séchée en bouquets
    name: 'Menta seca en ramilletes',
    // FR: Pendue tête en bas dans un coin sec, la menthe sèche toute seule et parfume le thé tout l'hiver.
    description: 'Colgada boca abajo en un rincón seco, la menta se seca sola y perfuma el té todo el invierno.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegida de la luz',
    ingredients: <String>[
      'una decena de ramilletes de menta', // FR: une dizaine de bouquets de menthe
      'cordel o gomas elásticas', // FR: de la ficelle ou des élastiques
      'bolsas de papel', // FR: des sacs en papier
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Coupe les tiges le matin, une fois la rosée partie et **avant la floraison** : c'est là qu'elles ont le plus d'arôme.
      'Corta los tallos por la mañana, una vez que se ha ido el rocío y **antes de la floración**: es cuando tienen más aroma.',
      // FR: Ne les lave que si elles sont terreuses, et sèche-les alors très bien : l'humidité les fait moisir.
      'Solo los lavas si tienen tierra, y entonces sécalos muy bien: la humedad los enmohece.',
      // FR: Fais de petits bouquets d'une dizaine de tiges, liés serré : les tiges rétrécissent en séchant.
      'Haz ramilletes pequeños de una decena de tallos, atados con fuerza: los tallos se encogen al secarse.',
      // FR: Pends-les tête en bas dans un endroit sec, aéré et sombre, dans un sac en papier percé contre la poussière.
      'Cuélgalos boca abajo en un lugar seco, ventilado y oscuro, dentro de una bolsa de papel con agujeros para protegerlos del polvo.',
      // FR: Quand les feuilles craquent sous les doigts, effeuille-les au-dessus d'une feuille de papier. Garde les feuilles entières.
      'Cuando las hojas crujan entre los dedos, deshójalas sobre una hoja de papel. Conserva las hojas enteras.',
      // FR: Mets-les en bocal fermé, au placard. Émiette-les seulement au moment de t'en servir.
      'Guárdalas en un tarro cerrado, en la despensa. Desmenúzalas solo en el momento de usarlas.',
    ],
  ),
  'menthe/Gelée de pomme à la menthe': RecipeText(
    // FR: Gelée de pomme à la menthe
    name: 'Jalea de manzana y menta',
    // FR: Les pommes donnent la prise, la menthe donne tout le reste : la gelée qui accompagne l'agneau.
    description: 'Las manzanas dan el punto de gelificación, la menta da todo lo demás: la jalea que acompaña al cordero.',
    // FR: 1 an au placard
    keeps: '1 año en la despensa',
    ingredients: <String>[
      '1,5 kg de manzanas ácidas', // FR: 1,5 kg de pommes acides
      '1 litro de agua', // FR: 1 litre d'eau
      'un buen puñado de menta', // FR: une grosse poignée de menthe
      'unos 750 g de azúcar', // FR: environ 750 g de sucre
      'el zumo de un limón', // FR: le jus d'un citron
    ],
    steps: <String>[
      // FR: Coupe les pommes en quartiers **sans les éplucher ni les épépiner** : la pectine est dans la peau et les pépins.
      'Corta las manzanas en cuartos **sin pelarlas ni quitarles las pepitas**: la pectina está en la piel y en las pepitas.',
      // FR: Cuis-les à couvert avec l'eau et la moitié de la menthe, jusqu'à ce qu'elles soient en bouillie.
      'Cuécelas tapadas con el agua y la mitad de la menta hasta que estén hechas puré.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse couler le jus sans presser, sinon la gelée sera trouble.
      'Vierte sobre un paño limpio colocado en un colador y deja que gotee el jugo sin apretar, o la jalea quedará turbia.',
      // FR: Pèse le jus et ajoute **750 g de sucre par litre**, plus le citron.
      'Pesa el jugo y añade **750 g de azúcar por litro**, más el limón.',
      // FR: Fais bouillir à feu vif en écumant, jusqu'à ce qu'une goutte se fige sur une assiette froide.
      'Hierve a fuego vivo espumando, hasta que una gota cuaje en un plato frío.',
      // FR: Hors du feu, ajoute le reste de menthe hachée très fin et remue.
      'Fuera del fuego, añade el resto de la menta picada muy fina y remueve.',
      // FR: Mets en pots ébouillantés remplis à ras, ferme aussitôt et retourne jusqu'à refroidissement.
      'Pon en tarros escaldados llenos hasta el borde, cierra enseguida y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'menthe/Thé à la menthe': RecipeText(
    // FR: Thé à la menthe
    name: 'Té con menta',
    // FR: Thé vert, bouquet entier, trois sucres. Versé de haut.
    description: 'Té verde, un manojo entero, tres terrones de azúcar. Servido desde lo alto.',
  ),
  'menthe/Taboulé à la menthe': RecipeText(
    // FR: Taboulé à la menthe
    name: 'Tabulé con menta',
    // FR: Plus de persil et de menthe que de semoule.
    description: 'Más perejil y menta que sémola.',
  ),
  'menthe/Ataya': RecipeText(
    // FR: Ataya
    name: 'Ataya',
    // FR: Le thé à la menthe mousseux, préparé en trois services entre amis, sans se presser.
    description: 'El té con menta espumoso, preparado en tres rondas entre amigos, sin prisa.',
  ),

  // ─────────── mil (6 recettes) ───────────
  'mil/Mil séché en épis et battu': RecipeText(
    // FR: Mil séché en épis et battu
    name: 'Mijo secado en espiga y trillado',
    // FR: Bien sec et bien protégé, le grain de mil tient jusqu'à la récolte suivante.
    description: 'Bien seco y bien protegido, el grano de mijo aguanta hasta la siguiente cosecha.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 año en seco, a salvo de los insectos',
    ingredients: <String>[
      'las espigas de mijo cortadas en su madurez', // FR: les épis de mil coupés à maturité
      'una lona o una sábana limpia', // FR: une bâche ou un drap propre
      'un palo o un mazo', // FR: un bâton ou un pilon
      'sacos o bidones herméticos', // FR: des sacs ou fûts hermétiques
    ],
    steps: <String>[
      // FR: Coupe les épis quand le grain est dur sous l'ongle et que la tige jaunit.
      'Corta las espigas cuando el grano esté duro al apretarlo con la uña y el tallo amarillee.',
      // FR: Étale-les sur une bâche au soleil une semaine, en les rentrant chaque soir à l'abri de la rosée.
      'Extiéndelas sobre una lona al sol durante una semana, recogiéndolas cada noche para protegerlas del rocío.',
      // FR: Teste : un grain croqué doit casser net, pas s'écraser. Sinon, encore deux jours.
      'Prueba: un grano mordido debe partirse de golpe, no aplastarse. Si no, dos días más.',
      // FR: Bats les épis au bâton sur la bâche, ou frotte-les entre les mains pour faire tomber le grain.
      'Golpea las espigas con el palo sobre la lona, o frótalas entre las manos para que caiga el grano.',
      // FR: Vanne par vent léger en versant le grain de haut : les balles s'envolent, le grain lourd reste.
      'Avienta con viento suave echando el grano desde arriba: las cascarillas vuelan y el grano pesado se queda.',
      // FR: Passe le grain **3 jours au congélateur** ou bien au soleil brûlant : ça tue les œufs de charançon.
      'Pasa el grano **3 días por el congelador** o bajo un sol abrasador: así mueren los huevos de gorgojo.',
      // FR: Stocke dans des sacs ou fûts hermétiques bien remplis, au frais et au sec, surélevés du sol.
      'Guarda en sacos o bidones herméticos bien llenos, en un sitio fresco y seco, separados del suelo.',
    ],
  ),
  'mil/Grains de mil passés au froid': RecipeText(
    // FR: Grains de mil passés au froid
    name: 'Granos de mijo pasados por el frío',
    // FR: Un quart d'heure pour mettre ton mil à l'abri des charançons et du rance, prêt à piler à la demande.
    description: 'Un cuarto de hora para poner tu mijo a salvo de los gorgojos y del enranciamiento, listo para machacar cuando haga falta.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      'mijo trillado y bien seco', // FR: du mil battu et bien sec
      'bolsas de congelación gruesas', // FR: des sacs de congélation épais
    ],
    steps: <String>[
      // FR: Étale le grain sur un plateau et retire petits cailloux, balles et grains noircis.
      'Extiende el grano sobre una bandeja y retira piedrecitas, cascarillas y granos ennegrecidos.',
      // FR: Remplis des sacs par portions d'un repas, chasse l'air et ferme bien.
      'Llena bolsas con raciones de una comida, saca el aire y cierra bien.',
      // FR: Congèle à plat. Le froid tue les insectes et les œufs en 3 jours, et le grain ne bouge plus ensuite.
      'Congela en plano. El frío mata los insectos y los huevos en 3 días, y después el grano ya no se mueve.',
      // FR: Avant de piler, laisse le sac fermé revenir à température 2 heures : ouvert froid, le grain prend l'humidité.
      'Antes de machacar, deja que la bolsa cerrada vuelva a temperatura ambiente 2 horas: si se abre fría, el grano coge humedad.',
    ],
  ),
  'mil/Farine de mil maison': RecipeText(
    // FR: Farine de mil maison
    name: 'Harina de mijo casera',
    // FR: Lavée, séchée, pilée : la farine prête pour la bouillie du matin. Elle rancit vite, alors on la garde au froid.
    description: 'Lavada, secada y machacada: la harina lista para las gachas de la mañana. Se enrancia pronto, así que se guarda en frío.',
    // FR: 1 mois au sec, 6 mois au congélateur
    keeps: '1 mes en seco, 6 meses en el congelador',
    ingredients: <String>[
      '1 kg de mijo descascarillado', // FR: 1 kg de mil décortiqué
      'agua limpia', // FR: de l'eau propre
      'un tamiz fino', // FR: un tamis fin
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave le mil dans plusieurs eaux en le frottant, jusqu'à ce que l'eau reste claire. Les cailloux restent au fond.
      'Lava el mijo en varias aguas frotándolo, hasta que el agua quede clara. Las piedras se quedan en el fondo.',
      // FR: Laisse-le tremper 1 heure puis égoutte bien dans une passoire.
      'Déjalo en remojo 1 hora y escúrrelo bien en un colador.',
      // FR: Pile ou mixe le grain encore humide par petites quantités.
      'Machaca o tritura el grano todavía húmedo en pequeñas cantidades.',
      // FR: Passe au tamis fin et repile ce qui reste dessus.
      'Pasa por el tamiz fino y vuelve a machacar lo que quede encima.',
      // FR: Étale la farine en couche mince et sèche au four à 50 °C ou au soleil, en émiettant les grumeaux.
      'Extiende la harina en capa fina y seca en el horno a 50 °C o al sol, deshaciendo los grumos.',
      // FR: Mets-la en sacs : un mois au sec dans un bocal, six mois au congélateur. **Jette-la si elle sent l'amer.**
      'Guárdala en bolsas: un mes en seco en un tarro, seis meses en el congelador. **Tírala si huele amargo.**',
    ],
  ),
  'mil/Tô de mil': RecipeText(
    // FR: Tô de mil
    name: 'Tô de mijo',
    // FR: La pâte de mil du Sahel, servie brûlante avec une sauce gombo ou feuilles.
    description: 'La masa de mijo del Sahel, servida muy caliente con una salsa de okra o de hojas.',
  ),
  'mil/Thiakry': RecipeText(
    // FR: Thiakry
    name: 'Thiakry',
    // FR: Le couscous de mil sucré au lait caillé, un dessert frais et gourmand.
    description: 'El cuscús de mijo dulce con leche cuajada, un postre fresco y goloso.',
  ),
  'mil/Couscous de mil': RecipeText(
    // FR: Couscous de mil
    name: 'Cuscús de mijo',
    // FR: Le thiéré sénégalais, une semoule de mil vapeur qui accompagne les sauces du soir.
    description: 'El thiéré senegalés, una sémola de mijo al vapor que acompaña las salsas de la noche.',
  ),

  // ─────────── moringa (6 recettes) ───────────
  'moringa/Feuilles de moringa séchées à l\'ombre': RecipeText(
    // FR: Feuilles de moringa séchées à l'ombre
    name: 'Hojas de moringa secadas a la sombra',
    // FR: Séchées à l'ombre, les folioles restent bien vertes et s'émiettent dans les sauces toute l'année.
    description: 'Secados a la sombra, los foliolos se mantienen bien verdes y se desmenuzan en las salsas todo el año.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegidas de la luz',
    ingredients: <String>[
      'ramas de moringa con mucha hoja', // FR: des branches de moringa feuillues
      'una sábana limpia o rejillas', // FR: un drap propre ou des claies
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Rince les branches entières à grande eau et secoue-les.
      'Aclara las ramas enteras con abundante agua y sacúdelas.',
      // FR: Suspends-les en bouquets ou étale-les à l'**ombre**, dans un endroit aéré. Le soleil direct les jaunit.
      'Cuélgalas en ramilletes o extiéndelas a la **sombra**, en un lugar ventilado. El sol directo las amarillea.',
      // FR: Quand les folioles craquent sous les doigts, fais-les tomber en passant la main le long des tiges.
      'Cuando los foliolos crujan entre los dedos, hazlos caer pasando la mano a lo largo de los tallos.',
      // FR: Retire les petites tiges et les folioles jaunes ou noires.
      'Retira los tallitos y los foliolos amarillos o negros.',
      // FR: Garde-les entières en bocal hermétique : elles gardent mieux leur goût qu'en poudre. Émiette au moment de cuisiner.
      'Guárdalos enteros en un tarro hermético: conservan mejor el sabor que en polvo. Desmenuza en el momento de cocinar.',
    ],
  ),
  'moringa/Moringa blanchi au congélateur': RecipeText(
    // FR: Moringa blanchi au congélateur
    name: 'Moringa escaldada en el congelador',
    // FR: Une minute dans l'eau bouillante, et les folioles gardent leur vert pour les soupes et les sauces de l'hiver.
    description: 'Un minuto en agua hirviendo y los foliolos conservan su verde para las sopas y las salsas del invierno.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 kg de foliolos de moringa', // FR: 1 kg de folioles de moringa
      'sal gorda', // FR: gros sel
      '1 cuenco grande de agua con cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Détache les folioles des tiges en faisant glisser tes doigts le long de chaque rameau.
      'Separa los foliolos de los tallos deslizando los dedos a lo largo de cada ramita.',
      // FR: Lave-les dans plusieurs eaux et égoutte.
      'Lávalos en varias aguas y escurre.',
      // FR: Plonge-les dans une grande eau bouillante salée, à gros bouillons.
      'Sumérgelos en una olla grande de agua con sal, a ebullición fuerte.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée pour fixer le vert.
      'Escurre y sumerge enseguida en el agua helada para fijar el verde.',
      // FR: Presse-les en boule entre tes mains, vraiment fort, pour chasser l'eau.
      'Aprieta en bola entre las manos, con ganas, para sacar el agua.',
      // FR: Forme des boulettes d'une portion, congèle-les 2 heures sur une plaque puis mets-les en sac.
      'Forma bolitas de una ración, congélalas 2 horas en una bandeja y pásalas a una bolsa.',
    ],
  ),
  'moringa/Folioles de moringa congelées crues': RecipeText(
    // FR: Folioles de moringa congelées crues
    name: 'Foliolos de moringa congelados crudos',
    // FR: Vingt minutes et c'est rangé : pour les sauces mijotées, le moringa cru congelé fait très bien l'affaire.
    description: 'Veinte minutos y a guardar: para las salsas guisadas, la moringa cruda congelada cumple muy bien.',
    // FR: 4 mois au congélateur
    keeps: '4 meses en el congelador',
    ingredients: <String>[
      'foliolos de moringa frescos', // FR: des folioles de moringa fraîches
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Égrène les folioles des tiges et jette celles qui jaunissent.
      'Desgrana los foliolos de los tallos y tira los que estén amarilleando.',
      // FR: Lave-les et **sèche-les à fond** dans un torchon ou une essoreuse à salade.
      'Lávalos y **sécalos a fondo** con un paño o una centrifugadora de ensaladas.',
      // FR: Mets-les en sacs par poignées d'une portion, à plat, en chassant l'air.
      'Ponlos en bolsas por puñados de una ración, en plano, sacando el aire.',
      // FR: Jette-les **encore gelées** dans la sauce chaude en fin de cuisson : décongelées, elles s'écrasent.
      'Échalos **todavía congelados** en la salsa caliente al final de la cocción: descongelados, se aplastan.',
    ],
  ),
  'moringa/Poudre de moringa': RecipeText(
    // FR: Poudre de moringa
    name: 'Moringa en polvo',
    // FR: Feuilles séchées à l'ombre et pilées, à saupoudrer sur tout.
    description: 'Hojas secadas a la sombra y machacadas, para espolvorear sobre todo.',
  ),
  'moringa/Soupe de moringa': RecipeText(
    // FR: Soupe de moringa
    name: 'Sopa de moringa',
    // FR: Un bouillon vert aux feuilles fraîches de moringa, léger et plein de vitamines.
    description: 'Un caldo verde con hojas frescas de moringa, ligero y lleno de vitaminas.',
  ),
  'moringa/Sauce feuilles de moringa': RecipeText(
    // FR: Sauce feuilles de moringa
    name: 'Salsa de hojas de moringa',
    // FR: Les feuilles mijotées en sauce, un classique nourrissant du Sahel.
    description: 'Las hojas guisadas en salsa, un clásico nutritivo del Sahel.',
  ),

  // ─────────── murier (6 recettes) ───────────
  'murier/Mûres congelées sur plaque': RecipeText(
    // FR: Mûres congelées sur plaque
    name: 'Moras congeladas en bandeja',
    // FR: Un quart d'heure au retour de cueillette, et tu as des mûres pour les crumbles jusqu'au printemps.
    description: 'Un cuarto de hora al volver de la recolección y tendrás moras para los crumbles hasta la primavera.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '1 kg de moras', // FR: 1 kg de mûres
      'bolsas o cajas de congelación', // FR: des sacs ou boîtes de congélation
    ],
    steps: <String>[
      // FR: Trie les mûres, retire les queues et écarte celles qui sont moisies ou encore rouges.
      'Selecciona las moras, quita los rabillos y aparta las que estén mohosas o todavía rojas.',
      // FR: Rince-les très rapidement, seulement si elles sont sales, puis sèche-les à plat sur un torchon.
      'Acláralas muy rápido, solo si están sucias, y sécalas en plano sobre un paño.',
      // FR: Étale-les sur une plaque sans qu'elles se touchent et congèle 2 heures.
      'Extiéndelas en una bandeja sin que se toquen y congela 2 horas.',
      // FR: Mets-les en boîte une fois dures : elles restent entières et se prennent à la poignée.
      'Pásalas a una caja cuando estén duras: se mantienen enteras y se cogen a puñados.',
    ],
  ),
  'murier/Gelée de mûres sans pépins': RecipeText(
    // FR: Gelée de mûres sans pépins
    name: 'Jalea de moras sin pepitas',
    // FR: La mûre a beaucoup de pépins et peu de pectine : passée et citronnée, elle donne une gelée noire et brillante.
    description: 'La mora tiene muchas pepitas y poca pectina: pasada y con limón, da una jalea negra y brillante.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierta en la nevera',
    ingredients: <String>[
      '2 kg de moras', // FR: 2 kg de mûres
      '10 cl de agua', // FR: 10 cl d'eau
      '750 g de azúcar por litro de jugo', // FR: 750 g de sucre par litre de jus
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      '6 tarros de mermelada', // FR: 6 pots de confiture
    ],
    steps: <String>[
      // FR: Cuis les mûres avec l'eau à couvert, en écrasant, jusqu'à ce qu'elles soient en bouillie.
      'Cuece las moras con el agua, tapadas, aplastándolas, hasta que estén hechas puré.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse égoutter, puis presse doucement.
      'Vierte sobre un paño limpio colocado en un colador y deja escurrir; después aprieta suavemente.',
      // FR: Mesure le jus, ajoute 750 g de sucre par litre et le jus des citrons : **sans citron, la gelée ne prend pas**.
      'Mide el jugo, añade 750 g de azúcar por litro y el zumo de los limones: **sin limón, la jalea no cuaja**.',
      // FR: Porte à ébullition et cuis à gros bouillons en écumant.
      'Lleva a ebullición y cuece a borbotones espumando.',
      // FR: Teste sur une assiette froide : une goutte qui se fige est prête. Sinon, deux minutes de plus.
      'Prueba en un plato frío: una gota que cuaje significa que está lista. Si no, dos minutos más.',
      // FR: Mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pon en tarros escaldados, cierra y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'murier/Cuir de mûres et pommes': RecipeText(
    // FR: Cuir de mûres et pommes
    name: 'Cuero de moras y manzanas',
    // FR: Une purée étalée et séchée au four : des rouleaux de fruits à glisser dans le cartable.
    description: 'Un puré extendido y secado al horno: rollos de fruta para meter en la mochila.',
    // FR: 3 mois en bocal, au sec
    keeps: '3 meses en tarro, en seco',
    ingredients: <String>[
      '500 g de moras', // FR: 500 g de mûres
      '3 manzanas', // FR: 3 pommes
      '2 cucharadas soperas de miel', // FR: 2 cuillères à soupe de miel
      'papel de horno', // FR: du papier cuisson
    ],
    steps: <String>[
      // FR: Épluche et épépine les pommes, coupe-les en dés : elles apportent la tenue que la mûre n'a pas.
      'Pela las manzanas, quítales las pepitas y córtalas en dados: aportan la consistencia que la mora no tiene.',
      // FR: Cuis pommes et mûres à couvert, à feu doux, jusqu'à ce que tout s'écrase.
      'Cuece las manzanas y las moras, tapadas, a fuego suave, hasta que todo se deshaga.',
      // FR: Passe au moulin à légumes grille fine pour retirer les pépins, puis ajoute le miel.
      'Pasa por el pasapurés de malla fina para retirar las pepitas y añade la miel.',
      // FR: Étale la purée sur une plaque couverte de papier cuisson, en couche **régulière de 4 mm**.
      'Extiende el puré en una bandeja cubierta con papel de horno, en una capa **regular de 4 mm**.',
      // FR: Sèche au four à **60 °C**, porte entrouverte : c'est prêt quand le centre ne colle plus au doigt.
      'Seca en el horno a **60 °C**, con la puerta entreabierta: está listo cuando el centro ya no se pega al dedo.',
      // FR: Laisse refroidir, découpe en bandes avec le papier, roule-les et range-les en bocal.
      'Deja enfriar, corta en tiras junto con el papel, enróllalas y guárdalas en un tarro.',
    ],
  ),
  'murier/Confiture de mûres': RecipeText(
    // FR: Confiture de mûres
    name: 'Mermelada de moras',
    // FR: Passée au moulin si les graines te gênent.
    description: 'Pasada por el pasapurés si las pepitas te molestan.',
  ),
  'murier/Crumble aux mûres': RecipeText(
    // FR: Crumble aux mûres
    name: 'Crumble de moras',
    // FR: Avec des pommes, pour équilibrer l'acidité.
    description: 'Con manzanas, para equilibrar la acidez.',
  ),
  'murier/Sirop de mûres': RecipeText(
    // FR: Sirop de mûres
    name: 'Almíbar de moras',
    // FR: Jus et sucre à parts égales, à allonger d'eau pétillante.
    description: 'Jugo y azúcar a partes iguales, para alargar con agua con gas.',
  ),

  // ─────────── myrtillier (6 recettes) ───────────
  'myrtillier/Myrtilles congelées sur plaque': RecipeText(
    // FR: Myrtilles congelées sur plaque
    name: 'Arándanos congelados en bandeja',
    // FR: La plus simple de toutes : elles gèlent une à une et se prennent à la poignée pour un muffin ou un porridge.
    description: 'La más sencilla de todas: se congelan uno a uno y se cogen a puñados para un muffin o unas gachas de avena.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '1 kg de arándanos', // FR: 1 kg de myrtilles
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Trie les myrtilles et retire feuilles, queues et baies écrasées.
      'Selecciona los arándanos y retira hojas, rabillos y bayas aplastadas.',
      // FR: Ne les lave que si elles sont sales : la pellicule blanche qui les couvre les protège au congélateur.
      'Solo los lavas si están sucios: la película blanca que los cubre los protege en el congelador.',
      // FR: Étale-les sur une plaque en une couche et congèle 2 heures.
      'Extiéndelos en una bandeja en una sola capa y congela 2 horas.',
      // FR: Verse-les en sac une fois dures. Dans une pâte, mets-les **encore congelées** : elles ne la tachent pas en violet.
      'Pásalos a una bolsa cuando estén duros. En una masa, ponlos **todavía congelados**: así no la manchan de violeta.',
    ],
  ),
  'myrtillier/Myrtilles au sirop léger': RecipeText(
    // FR: Myrtilles au sirop léger
    name: 'Arándanos en almíbar ligero',
    // FR: Quelques bocaux de myrtilles au placard, et une tarte ou un yaourt prend des couleurs en plein hiver.
    description: 'Unos tarros de arándanos en la despensa, y una tarta o un yogur cobra color en pleno invierno.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 año en la despensa, 5 días abierto en la nevera',
    ingredients: <String>[
      '1,5 kg de arándanos', // FR: 1,5 kg de myrtilles
      '75 cl de agua', // FR: 75 cl d'eau
      '200 g de azúcar', // FR: 200 g de sucre
      'el zumo de un limón', // FR: le jus d'un citron
      '4 tarros de 50 cl con juntas nuevas', // FR: 4 bocaux de 50 cl avec joints neufs
    ],
    steps: <String>[
      // FR: Trie et rince les myrtilles, puis égoutte-les.
      'Selecciona y aclara los arándanos, y después escúrrelos.',
      // FR: Porte l'eau, le sucre et le jus de citron à ébullition 2 minutes.
      'Lleva el agua, el azúcar y el zumo de limón a ebullición 2 minutos.',
      // FR: Remplis les bocaux de myrtilles en tassant doucement, couvre de sirop chaud **jusqu'à 2 cm du bord** et ferme avec des joints neufs.
      'Llena los tarros de arándanos apretando suavemente, cubre con almíbar caliente **hasta 2 cm del borde** y cierra con juntas nuevas.',
      // FR: Stérilise les bocaux couverts d'eau, 20 minutes à partir de l'ébullition.
      'Esteriliza los tarros cubiertos de agua, 20 minutos desde que hierva.',
      // FR: Laisse refroidir dans l'eau, puis vérifie le vide : couvercle creux, joint qui tient. Sinon, au frais et à manger vite.
      'Deja enfriar en el agua y comprueba el vacío: tapa hundida, junta que aguanta. Si no, a la nevera y a comerlos pronto.',
    ],
  ),
  'myrtillier/Myrtilles séchées': RecipeText(
    // FR: Myrtilles séchées
    name: 'Arándanos secos',
    // FR: Séchées, elles remplacent les raisins secs dans un muesli, avec un goût bien plus vif.
    description: 'Secos, sustituyen a las pasas en un muesli, con un sabor mucho más vivo.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 meses en tarro, en seco',
    ingredients: <String>[
      '1 kg de arándanos', // FR: 1 kg de myrtilles
      'un cuenco de agua helada', // FR: un saladier d'eau glacée
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Trie et rince les myrtilles.
      'Selecciona y aclara los arándanos.',
      // FR: Plonge-les **30 secondes** dans l'eau bouillante : la peau se fendille, sinon elles mettent deux jours à sécher.
      'Sumérgelos **30 segundos** en agua hirviendo: la piel se resquebraja; si no, tardan dos días en secarse.',
      // FR: Passe-les dans l'eau glacée, puis égoutte et sèche-les sur un torchon.
      'Pásalos al agua helada, y después escúrrelos y sécalos sobre un paño.',
      // FR: Étale-les sur des grilles couvertes de papier cuisson et sèche au four à **60 °C**, porte entrouverte.
      'Extiéndelos sobre rejillas cubiertas con papel de horno y seca en el horno a **60 °C**, con la puerta entreabierta.',
      // FR: Quand elles sont fripées et souples sans jus, laisse refroidir et mets en bocal. Surveille la buée la première semaine.
      'Cuando estén arrugados y blandos sin jugo, deja enfriar y pásalos a un tarro. Vigila el vaho la primera semana.',
    ],
  ),
  'myrtillier/Tarte aux myrtilles': RecipeText(
    // FR: Tarte aux myrtilles
    name: 'Tarta de arándanos',
    // FR: Crues sur une crème, ou cuites — les deux marchent.
    description: 'Crudos sobre una crema, o cocidos: las dos formas funcionan.',
  ),
  'myrtillier/Muffins aux myrtilles': RecipeText(
    // FR: Muffins aux myrtilles
    name: 'Muffins de arándanos',
    // FR: Roulées dans la farine pour qu'elles ne tombent pas au fond.
    description: 'Rebozados en harina para que no caigan al fondo.',
  ),
  'myrtillier/Confiture de myrtilles': RecipeText(
    // FR: Confiture de myrtilles
    name: 'Mermelada de arándanos',
    // FR: Peu de sucre, beaucoup de citron.
    description: 'Poco azúcar, mucho limón.',
  ),

  // ─────────── navet (6 recettes) ───────────
  'navet/Dés de navets blanchis': RecipeText(
    // FR: Dés de navets blanchis
    name: 'Dados de nabo escaldados',
    // FR: Deux minutes dans l'eau bouillante, et tu as des navets prêts pour le pot-au-feu ou le couscous tout l'hiver.
    description: 'Dos minutos en agua hirviendo y tendrás nabos listos para el cocido o el cuscús todo el invierno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de nabos', // FR: 2 kg de navets
      'sal gorda', // FR: gros sel
      'un cuenco grande de agua con cubitos de hielo', // FR: un grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les navets et coupe-les en dés de 2 cm, réguliers pour qu'ils blanchissent tous pareil.
      'Pela los nabos y córtalos en dados de 2 cm, regulares para que se escalden todos por igual.',
      // FR: Plonge-les par fournées dans une grande eau salée bouillante, **2 minutes**.
      'Sumérgelos por tandas en abundante agua hirviendo con sal, **2 minutos**.',
      // FR: Fais-les tomber aussitôt dans l'eau glacée, le temps qu'ils soient froids à cœur.
      'Pásalos enseguida al agua helada, el tiempo que tarden en estar fríos por dentro.',
      // FR: Égoutte et sèche-les dans un torchon : chaque goutte devient du givre.
      'Escurre y sécalos con un paño: cada gota se convierte en escarcha.',
      // FR: Étale sur une plaque, congèle 2 heures, puis verse en sacs. Ils resteront détachés.
      'Extiende en una bandeja, congela 2 horas y echa en bolsas. Quedarán sueltos.',
    ],
  ),
  'navet/Navets roses façon torshi': RecipeText(
    // FR: Navets roses façon torshi
    name: 'Nabos rosas al estilo torshi',
    // FR: Le pickle libanais : une tranche de betterave suffit à teinter les navets d'un rose fuchsia.
    description: 'El encurtido libanés: una rodaja de remolacha basta para teñir los nabos de un rosa fucsia.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '1 kg de nabos pequeños', // FR: 1 kg de petits navets
      '1 remolacha pequeña cruda', // FR: 1 petite betterave crue
      '50 cl de vinagre blanco de 6 %', // FR: 50 cl de vinaigre blanc à 6 %
      '50 cl de agua', // FR: 50 cl d'eau
      '40 g de sal', // FR: 40 g de sel
      '3 dientes de ajo', // FR: 3 gousses d'ail
    ],
    steps: <String>[
      // FR: Épluche les navets et coupe-les en bâtonnets ou en quartiers. Épluche la betterave et tranche-la en rondelles.
      'Pela los nabos y córtalos en bastones o en cuartos. Pela la remolacha y córtala en rodajas.',
      // FR: Remplis les bocaux en intercalant navets, rondelles de betterave et ail écrasé.
      'Llena los tarros alternando nabos, rodajas de remolacha y ajo machacado.',
      // FR: Porte l'eau, le vinaigre et le sel à frémissement pour dissoudre le sel, puis laisse tiédir.
      'Lleva el agua, el vinagre y la sal a un hervor suave para disolver la sal, y deja templar.',
      // FR: Verse le liquide jusqu'à **couvrir entièrement** les légumes. Ce qui dépasse brunit.
      'Vierte el líquido hasta **cubrir por completo** las verduras. Lo que sobresale se oscurece.',
      // FR: Ferme et laisse une semaine au réfrigérateur avant d'ouvrir : le rose gagne le cœur des navets.
      'Cierra y deja una semana en la nevera antes de abrir: el rosa llega hasta el corazón de los nabos.',
    ],
  ),
  'navet/Navets râpés fermentés au sel': RecipeText(
    // FR: Navets râpés fermentés au sel
    name: 'Nabos rallados fermentados con sal',
    // FR: La choucroute de navets des campagnes allemandes : juste du sel, et le temps fait le reste.
    description: 'El chucrut de nabos del campo alemán: solo sal, y el tiempo hace el resto.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 meses en la nevera',
    ingredients: <String>[
      '2 kg de nabos', // FR: 2 kg de navets
      '40 g de sal sin yodo', // FR: 40 g de sel non iodé
      '1 cucharadita de semillas de alcaravea', // FR: 1 cuillère à café de graines de carvi
    ],
    steps: <String>[
      // FR: Épluche les navets et râpe-les grossièrement. Pèse la râpée.
      'Pela los nabos y rállalos grueso. Pesa lo rallado.',
      // FR: Ajoute **20 g de sel par kilo** de navets râpés et le carvi, mélange avec les mains.
      'Añade **20 g de sal por kilo** de nabos rallados y la alcaravea, y mezcla con las manos.',
      // FR: Laisse reposer : le sel tire l'eau et fait tout seul la saumure.
      'Deja reposar: la sal saca el agua y hace sola la salmuera.',
      // FR: Tasse fort dans un bocal, poing après poing, jusqu'à ce que le jus remonte au-dessus.
      'Aprieta con fuerza en un tarro, puñado tras puñado, hasta que el jugo suba por encima.',
      // FR: Pose un poids pour que tout reste **sous le jus**. S'il en manque, complète avec de la saumure à 30 g de sel par litre.
      'Coloca un peso para que todo quede **bajo el jugo**. Si falta, completa con salmuera de 30 g de sal por litro.',
      // FR: Laisse fermenter 2 semaines à 18–22 °C, couvercle posé sans serrer, puis range au réfrigérateur.
      'Deja fermentar 2 semanas a 18–22 °C, con la tapa puesta sin apretar, y guarda después en la nevera.',
    ],
  ),
  'navet/Navets glacés': RecipeText(
    // FR: Navets glacés
    name: 'Nabos glaseados',
    // FR: Beurre, sucre, un fond d'eau : ils sortent brillants.
    description: 'Mantequilla, azúcar y un fondo de agua: salen brillantes.',
    ingredients: <String>[
      '800 g de nabos', // FR: 800 g de navets
      '30 g de mantequilla', // FR: 30 g de beurre
      '1 cucharadita de azúcar', // FR: 1 cuillère à café de sucre
      'sal, perejil', // FR: sel, persil
    ],
    steps: <String>[
      // FR: Pèle les navets et coupe-les en quartiers réguliers.
      'Pela los nabos y córtalos en cuartos regulares.',
      // FR: Casserole large : beurre, sucre, sel, eau à mi-hauteur.
      'En una cacerola ancha: mantequilla, azúcar, sal y agua hasta la mitad de su altura.',
      // FR: Cuis à découvert 20 minutes, l'eau doit s'évaporer en sirop.
      'Cuece 20 minutos sin tapar; el agua debe evaporarse hasta formar un almíbar.',
      // FR: Remue pour les enrober, persil, et sers chaud.
      'Remueve para bañarlos, añade el perejil y sirve caliente.',
    ],
  ),
  'navet/Purée de navets': RecipeText(
    // FR: Purée de navets
    name: 'Puré de nabos',
    // FR: Moitié navet, moitié pomme de terre : plus légère qu'une purée classique.
    description: 'Mitad nabo, mitad patata: más ligero que un puré clásico.',
    ingredients: <String>[
      '500 g de nabos', // FR: 500 g de navets
      '500 g de patatas', // FR: 500 g de pommes de terre
      '20 cl de leche', // FR: 20 cl de lait
      '40 g de mantequilla', // FR: 40 g de beurre
      'sal, pimienta, nuez moscada', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Pèle et coupe navets et pommes de terre en morceaux égaux.
      'Pela y corta nabos y patatas en trozos iguales.',
      // FR: Cuis-les à l'eau salée 20 minutes.
      'Cuécelos en agua con sal 20 minutos.',
      // FR: Égoutte et laisse-les sécher 2 minutes sur le feu éteint : une purée de navets tourne vite à la soupe.
      'Escurre y déjalos secar 2 minutos sobre el fuego apagado: un puré de nabos se convierte enseguida en sopa.',
      // FR: Écrase au presse-purée, pas au mixeur, avec le lait chaud et le beurre.
      'Aplasta con el pasapurés, no con la batidora, con la leche caliente y la mantequilla.',
      // FR: Sel, poivre, muscade.
      'Sal, pimienta y nuez moscada.',
    ],
  ),
  'navet/Navets au miel et thym': RecipeText(
    // FR: Navets au miel et thym
    name: 'Nabos con miel y tomillo',
    // FR: Le miel prend le dessus sur l'amertume des gros navets d'hiver.
    description: 'La miel se impone sobre el amargor de los nabos grandes de invierno.',
    ingredients: <String>[
      '800 g de nabos', // FR: 800 g de navets
      '2 cucharadas soperas de miel', // FR: 2 cuillères à soupe de miel
      '20 g de mantequilla', // FR: 20 g de beurre
      'tomillo, sal, pimienta, 1 chorrito de vinagre', // FR: thym, sel, poivre, 1 trait de vinaigre
    ],
    steps: <String>[
      // FR: Coupe les navets en gros dés.
      'Corta los nabos en dados grandes.',
      // FR: Fais-les colorer au beurre à feu vif, 5 minutes.
      'Dóralos en la mantequilla a fuego vivo, 5 minutos.',
      // FR: Ajoute miel, thym, sel, un trait de vinaigre, un fond d'eau.
      'Añade la miel, el tomillo, la sal, un chorrito de vinagre y un fondo de agua.',
      // FR: Couvre et laisse 20 minutes à feu doux.
      'Tapa y deja 20 minutos a fuego suave.',
      // FR: Découvre à la fin pour faire réduire et caraméliser.
      'Destapa al final para que reduzca y caramelice.',
    ],
  ),

  // ─────────── niebe (6 recettes) ───────────
  'niebe/Niébé sec en sacs hermétiques': RecipeText(
    // FR: Niébé sec en sacs hermétiques
    name: 'Caupí seco en sacos herméticos',
    // FR: Bien séché et enfermé sans air, le niébé échappe aux bruches et se garde jusqu'à la récolte suivante.
    description: 'Bien seco y encerrado sin aire, el caupí se libra de los gorgojos y se conserva hasta la siguiente cosecha.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 año en seco, a salvo de los insectos',
    ingredients: <String>[
      'las vainas de caupí secas en la planta', // FR: les gousses de niébé sèches sur pied
      'una lona limpia', // FR: une bâche propre
      'sacos herméticos o bidones bien cerrados', // FR: des sacs hermétiques ou des bidons bien fermés
    ],
    steps: <String>[
      // FR: Récolte les gousses quand elles sont jaunes-brunes et craquent sous les doigts.
      'Recoge las vainas cuando estén amarillo-marrón y crujan entre los dedos.',
      // FR: Étale-les au soleil sur une bâche jusqu'à ce qu'elles s'ouvrent toutes seules, environ une semaine.
      'Extiéndelas al sol sobre una lona hasta que se abran solas, más o menos una semana.',
      // FR: Bats-les doucement au bâton ou écosse-les à la main, puis vanne pour enlever les cosses.
      'Golpéalas suavemente con un palo o desgránalas a mano, y después avienta para quitar las vainas.',
      // FR: Trie : retire les graines percées d'un petit trou rond, c'est la bruche, et les graines tachées.
      'Selecciona: retira las semillas con un agujerito redondo, que es el gorgojo, y las semillas manchadas.',
      // FR: Passe les graines **3 jours au congélateur**, ou mets-les dans un bidon plein à ras et fermé : sans air, les insectes meurent.
      'Pasa las semillas **3 días por el congelador**, o ponlas en un bidón lleno hasta el borde y cerrado: sin aire, los insectos mueren.',
      // FR: Stocke au frais et au sec dans des sacs triples ou des bidons hermétiques. Le niébé sec se cuit toujours avant de se manger.
      'Guarda en un sitio fresco y seco, en sacos triples o bidones herméticos. El caupí seco se cuece siempre antes de comerlo.',
    ],
  ),
  'niebe/Niébé frais blanchi au congélateur': RecipeText(
    // FR: Niébé frais blanchi au congélateur
    name: 'Caupí fresco escaldado en el congelador',
    // FR: Les graines fraîches écossées, deux minutes dans l'eau bouillante, et elles gardent leur tendre tout l'hiver.
    description: 'Las semillas frescas desgranadas, dos minutos en agua hirviendo, y conservan su ternura todo el invierno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1 kg de caupí fresco desgranado', // FR: 1 kg de niébé frais écossé
      '1 cuenco grande de agua con cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Rince les graines écossées et retire celles qui sont tachées ou trop dures.
      'Aclara las semillas desgranadas y retira las que estén manchadas o demasiado duras.',
      // FR: Plonge-les dans une grande casserole d'eau bouillante, compte à partir de la reprise de l'ébullition.
      'Sumérgelas en una olla grande de agua hirviendo y cuenta desde que vuelva a hervir.',
      // FR: Égoutte et plonge aussitôt dans l'eau glacée 2 minutes pour stopper la cuisson.
      'Escurre y sumerge enseguida en agua helada 2 minutos para cortar la cocción.',
      // FR: Égoutte et sèche sur un torchon. Moins il reste d'eau, moins il y a de givre.
      'Escurre y seca sobre un paño. Cuanta menos agua quede, menos escarcha habrá.',
      // FR: Étale sur une plaque, congèle 1 heure, puis mets en sac.
      'Extiende en una bandeja, congela 1 hora y pasa a una bolsa.',
      // FR: Cuis-les sans décongeler, 15 à 20 minutes dans l'eau ou la sauce : le blanchiment ne suffit pas à les cuire.
      'Cuécelas sin descongelar, de 15 a 20 minutos en agua o en salsa: el escaldado no basta para cocinarlas.',
    ],
  ),
  'niebe/Niébé cuit en portions': RecipeText(
    // FR: Niébé cuit en portions
    name: 'Caupí cocido en porciones',
    // FR: Une grosse marmite de niébé cuit, et des portions prêtes pour un ndambé ou une salade sans attendre.
    description: 'Una olla grande de caupí cocido y raciones listas para un ndambé o una ensalada sin esperar.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '500 g de caupí seco', // FR: 500 g de niébé sec
      '2 litros de agua', // FR: 2 litres d'eau
      '1 hoja de laurel', // FR: 1 feuille de laurier
      'sal', // FR: sel
      'recipientes de congelación', // FR: des boîtes de congélation
    ],
    steps: <String>[
      // FR: Trie le niébé, rince-le et laisse-le tremper si tu as le temps : il cuira plus vite.
      'Selecciona el caupí, aclara y déjalo en remojo si tienes tiempo: se cocerá más rápido.',
      // FR: Mets-le dans l'eau froide avec le laurier, porte à ébullition et écume la mousse grise.
      'Ponlo en agua fría con el laurel, lleva a ebullición y retira la espuma gris.',
      // FR: Laisse frémir jusqu'à ce que le grain s'écrase entre deux doigts. **Sale seulement à la fin**, sinon la peau durcit.
      'Deja hervir suavemente hasta que el grano se aplaste entre dos dedos. **Sala solo al final**, o la piel se endurece.',
      // FR: Laisse refroidir dans un peu de son eau de cuisson, ça l'empêche de sécher.
      'Deja enfriar en un poco de su agua de cocción, así no se seca.',
      // FR: Répartis en boîtes avec un peu de jus, en laissant 2 cm de vide, et note la date.
      'Reparte en recipientes con un poco de caldo, dejando 2 cm de vacío, y anota la fecha.',
    ],
  ),
  'niebe/Akara': RecipeText(
    // FR: Akara
    name: 'Akara',
    // FR: Les beignets de niébé croustillants, stars des petits déjeuners de rue.
    description: 'Los buñuelos de caupí crujientes, estrellas de los desayunos callejeros.',
  ),
  'niebe/Moin-moin': RecipeText(
    // FR: Moin-moin
    name: 'Moin-moin',
    // FR: Le flan de niébé vapeur du Nigeria, moelleux et délicatement épicé.
    description: 'El flan de caupí al vapor de Nigeria, esponjoso y delicadamente especiado.',
  ),
  'niebe/Ndambé': RecipeText(
    // FR: Ndambé
    name: 'Ndambé',
    // FR: Le ragoût de niébé sénégalais, servi dans du pain frais pour un sandwich costaud.
    description: 'El guiso de caupí senegalés, servido en pan fresco para un bocadillo contundente.',
  ),

  // ─────────── noisetier (6 recettes) ───────────
  'noisetier/Noisettes séchées en coque': RecipeText(
    // FR: Noisettes séchées en coque
    name: 'Avellanas secas con cáscara',
    // FR: Bien sèches, les noisettes se gardent tout l'hiver dans leur coque, qui est leur meilleure boîte.
    description: 'Bien secas, las avellanas se guardan todo el invierno en su cáscara, que es su mejor envase.',
    // FR: 1 an en coque, au sec et au frais
    keeps: '1 año con cáscara, en seco y en un sitio fresco',
    ingredients: <String>[
      'las avellanas caídas al suelo', // FR: les noisettes tombées au sol
      'cajas de fruta o rejillas', // FR: des cagettes ou des claies
      'redes o sacos de tela', // FR: des filets ou sacs en toile
    ],
    steps: <String>[
      // FR: Ramasse les noisettes au sol tous les deux jours, avant les écureuils, et retire leur collerette verte.
      'Recoge las avellanas del suelo cada dos días, antes que las ardillas, y quítales la envoltura verde.',
      // FR: Plonge-les dans un seau d'eau : celles qui **flottent** sont vides ou véreuses, jette-les.
      'Sumérgelas en un cubo de agua: las que **flotan** están vacías o con gusano, tíralas.',
      // FR: Étale les bonnes en une couche dans des cagettes, dans un grenier sec et aéré, et remue-les de temps en temps. Deux semaines.
      'Extiende las buenas en una capa en cajas de fruta, en un desván seco y ventilado, y remuévelas de vez en cuando. Dos semanas.',
      // FR: Casse-en une : l'amande doit se détacher de la coque et se casser net, sans plier.
      'Rompe una: la almendra debe despegarse de la cáscara y partirse de golpe, sin doblarse.',
      // FR: Range-les en filets ou sacs de toile suspendus, dans un endroit frais et sec, hors de portée des souris.
      'Guárdalas en redes o sacos de tela colgados, en un sitio fresco y seco, fuera del alcance de los ratones.',
    ],
  ),
  'noisetier/Noisettes décortiquées au congélateur': RecipeText(
    // FR: Noisettes décortiquées au congélateur
    name: 'Avellanas peladas en el congelador',
    // FR: Une fois cassées, elles rancissent vite : au congélateur, elles restent comme au premier jour.
    description: 'Una vez abiertas, se enrancian pronto: en el congelador, se quedan como el primer día.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '1 kg de avellanas secas con cáscara', // FR: 1 kg de noisettes sèches en coque
      'un cascanueces', // FR: un casse-noix
      'bolsas o tarros de congelación', // FR: des sacs ou bocaux de congélation
    ],
    steps: <String>[
      // FR: Casse les noisettes au casse-noix, ou plusieurs à la fois dans un torchon avec un maillet.
      'Rompe las avellanas con el cascanueces, o varias a la vez dentro de un paño con un mazo.',
      // FR: Trie les amandes et jette celles qui sont noircies, ridées ou piquées : **une seule rance** gâte tout le sachet.
      'Selecciona las almendras y tira las que estén ennegrecidas, arrugadas o picadas: **una sola rancia** estropea toda la bolsa.',
      // FR: Mets-les en sachets de 250 g, chasse l'air et ferme bien : les noisettes prennent les odeurs.
      'Ponlas en bolsitas de 250 g, saca el aire y cierra bien: las avellanas cogen los olores.',
      // FR: Congèle à plat. Elles s'utilisent sans décongeler, pour torréfier, mixer ou mettre dans une pâte.
      'Congela en plano. Se usan sin descongelar, para tostar, triturar o añadir a una masa.',
    ],
  ),
  'noisetier/Poudre de noisettes torréfiées': RecipeText(
    // FR: Poudre de noisettes torréfiées
    name: 'Harina de avellanas tostadas',
    // FR: Torréfiées puis moulues, elles donnent une poudre qui parfume un gâteau bien mieux que celle du commerce.
    description: 'Tostadas y luego molidas, dan un polvo que perfuma un bizcocho mucho mejor que el del comercio.',
    // FR: 2 mois en bocal au réfrigérateur, 6 mois au congélateur
    keeps: '2 meses en tarro en la nevera, 6 meses en el congelador',
    ingredients: <String>[
      '500 g de avellanas peladas', // FR: 500 g de noisettes décortiquées
      'un paño limpio', // FR: un torchon propre
      'un tarro de cristal', // FR: un bocal en verre
    ],
    steps: <String>[
      // FR: Étale les noisettes sur une plaque et fais-les torréfier au four à **160 °C**, en secouant à mi-temps.
      'Extiende las avellanas en una bandeja y tuéstalas en el horno a **160 °C**, sacudiendo a la mitad del tiempo.',
      // FR: Verse-les chaudes dans un torchon et frotte : la peau brune s'en va presque toute seule.
      'Échalas calientes en un paño y frota: la piel marrón se va casi sola.',
      // FR: Laisse-les refroidir complètement, sinon la poudre tourne en pâte.
      'Deja que se enfríen por completo, o el polvo se convierte en pasta.',
      // FR: Mixe par **petits à-coups** : trop longtemps, l'huile sort et tu obtiens une pâte à tartiner.
      'Tritura a **pequeños golpes**: si te pasas, sale el aceite y obtienes una crema de untar.',
      // FR: Mets en bocal fermé et garde au réfrigérateur : l'huile de noisette rancit vite à température ambiante.
      'Guarda en un tarro cerrado en la nevera: el aceite de avellana se enrancia pronto a temperatura ambiente.',
    ],
  ),
  'noisetier/Pâte à tartiner maison': RecipeText(
    // FR: Pâte à tartiner maison
    name: 'Crema de avellanas casera para untar',
    // FR: Noisettes torréfiées, mixées longtemps jusqu'à la crème.
    description: 'Avellanas tostadas, trituradas mucho rato hasta lograr la crema.',
  ),
  'noisetier/Gâteau aux noisettes': RecipeText(
    // FR: Gâteau aux noisettes
    name: 'Bizcocho de avellanas',
    // FR: Sans farine, juste des noisettes moulues et des œufs.
    description: 'Sin harina, solo avellanas molidas y huevos.',
  ),
  'noisetier/Noisettes torréfiées au sel': RecipeText(
    // FR: Noisettes torréfiées au sel
    name: 'Avellanas tostadas con sal',
    // FR: Quinze minutes de four, frottées dans un torchon.
    description: 'Quince minutos de horno, frotadas en un paño.',
  ),

  // ─────────── oignon (6 recettes) ───────────
  'oignon/Oignons ressuyés en tresses': RecipeText(
    // FR: Oignons ressuyés en tresses
    name: 'Cebollas oreadas en trenzas',
    // FR: Bien séchés et tressés, les oignons de garde passent l'hiver suspendus, jusqu'au printemps.
    description: 'Bien secas y trenzadas, las cebollas de conserva pasan el invierno colgadas, hasta la primavera.',
    // FR: 6 mois au sec, au frais et à l'ombre
    keeps: '6 meses en seco, en un sitio fresco y a la sombra',
    ingredients: <String>[
      'las cebollas de conserva arrancadas en tiempo seco', // FR: les oignons de garde arrachés par temps sec
      'cordel de cocina', // FR: de la ficelle de cuisine
      'un lugar seco, ventilado y a la sombra', // FR: un endroit sec, aéré et à l'ombre
    ],
    steps: <String>[
      // FR: Arrache les oignons quand les fanes sont couchées et jaunies, par une journée sèche.
      'Arranca las cebollas cuando las hojas estén tumbadas y amarillas, en un día seco.',
      // FR: Laisse-les 2 à 3 jours sur le sol, au soleil, puis à l'abri sec et aéré.
      'Déjalas 2 o 3 días en el suelo, al sol, y luego a cubierto, en un sitio seco y ventilado.',
      // FR: Laisse-les ressuyer 2 semaines, jusqu'à ce que la peau soit craquante et le collet bien sec.
      'Déjalas oréarse 2 semanas, hasta que la piel esté crujiente y el cuello bien seco.',
      // FR: Brosse la terre à la main sans enlever les peaux, et coupe les racines à 1 cm.
      'Quita la tierra con la mano sin retirar las pieles, y corta las raíces a 1 cm.',
      // FR: Trie : mange d'abord les oignons au collet épais ou mou, ils ne se gardent pas.
      'Selecciona: come primero las cebollas de cuello grueso o blando, no se conservan.',
      // FR: Tresse les fanes sèches autour d'une ficelle, un oignon après l'autre, comme une natte.
      'Trenza las hojas secas alrededor de un cordel, una cebolla tras otra, como una trenza.',
      // FR: Suspends les tresses au frais, au sec et à l'ombre. Vérifie chaque mois et retire ceux qui germent ou ramollissent.
      'Cuelga las trenzas en un sitio fresco, seco y a la sombra. Revisa cada mes y retira las que broten o se ablanden.',
    ],
  ),
  'oignon/Oignons émincés congelés': RecipeText(
    // FR: Oignons émincés congelés
    name: 'Cebolla cortada en juliana congelada',
    // FR: Un quart d'heure de larmes une fois, et plus jamais d'oignon à éplucher pour une sauce en semaine.
    description: 'Un cuarto de hora de lágrimas una vez, y nunca más una cebolla que pelar para una salsa entre semana.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 kg de cebollas', // FR: 2 kg d'oignons
      'bolsas de congelación gruesas', // FR: des sacs de congélation épais
    ],
    steps: <String>[
      // FR: Épluche les oignons et émince-les ou coupe-les en dés, comme tu les utilises le plus.
      'Pela las cebollas y córtalas en juliana o en dados, como más las uses.',
      // FR: Étale-les sur une plaque et congèle 1 heure pour qu'ils ne fassent pas un bloc.
      'Extiéndelas en una bandeja y congela 1 hora para que no formen un bloque.',
      // FR: Mets-les en sacs par portions, chasse l'air, et **double l'emballage** : sinon tout le congélateur sent l'oignon.
      'Ponlas en bolsas por raciones, saca el aire y **dobla el envase**: si no, todo el congelador huele a cebolla.',
      // FR: Jette-les encore gelés dans la poêle chaude. Ils sont parfaits cuits, pas en salade.
      'Échalas aún congeladas en la sartén caliente. Quedan perfectas cocinadas, no en ensalada.',
    ],
  ),
  'oignon/Pickles d\'oignons rouges': RecipeText(
    // FR: Pickles d'oignons rouges
    name: 'Encurtido de cebolla roja',
    // FR: Roses, croquants, acidulés : une poignée sur une salade, un burger ou un poisson grillé.
    description: 'Rosa, crujiente y acidulado: un puñado sobre una ensalada, una hamburguesa o un pescado a la parrilla.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '1 kg de cebollas rojas', // FR: 1 kg d'oignons rouges
      '40 cl de vinagre de sidra de 6 %', // FR: 40 cl de vinaigre de cidre à 6 %
      '40 cl de agua', // FR: 40 cl d'eau
      '2 cucharadas soperas de azúcar', // FR: 2 cuillères à soupe de sucre
      '1 cucharada sopera de sal', // FR: 1 cuillère à soupe de sel
    ],
    steps: <String>[
      // FR: Épluche les oignons et coupe-les en rondelles fines de 3 mm.
      'Pela las cebollas y córtalas en rodajas finas de 3 mm.',
      // FR: Tasse-les dans des bocaux ébouillantés sans les écraser.
      'Apriétalas en tarros escaldados sin aplastarlas.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel jusqu'à ce qu'ils fondent.
      'Lleva a ebullición el vinagre, el agua, el azúcar y la sal hasta que se disuelvan.',
      // FR: Verse le liquide bouillant pour **couvrir entièrement** les oignons, à 1 cm du bord. Ferme.
      'Vierte el líquido hirviendo para **cubrir por completo** las cebollas, a 1 cm del borde. Cierra.',
      // FR: Laisse refroidir puis mets au réfrigérateur. Ils sont roses et prêts dès le lendemain.
      'Deja enfriar y pon en la nevera. Están rosas y listas al día siguiente.',
    ],
  ),
  'oignon/Soupe à l\'oignon gratinée': RecipeText(
    // FR: Soupe à l'oignon gratinée
    name: 'Sopa de cebolla gratinada',
    // FR: Une heure de patience sur les oignons, et tout est joué.
    description: 'Una hora de paciencia con las cebollas, y todo está hecho.',
    ingredients: <String>[
      '1 kg de cebollas', // FR: 1 kg d'oignons
      '40 g de mantequilla', // FR: 40 g de beurre
      '1 cucharada sopera de harina', // FR: 1 cuillère à soupe de farine
      '1,5 litros de caldo', // FR: 1,5 litre de bouillon
      '4 rebanadas de pan, 150 g de gruyère', // FR: 4 tranches de pain, 150 g de gruyère
    ],
    steps: <String>[
      // FR: Émince les oignons en fines lamelles.
      'Corta las cebollas en láminas finas.',
      // FR: Fais-les blondir au beurre à feu doux **40 minutes** en remuant. C'est toute la recette : pressé, ça ne marche pas.
      'Dóralas en la mantequilla a fuego suave **40 minutos**, removiendo. Esa es toda la receta: con prisas no funciona.',
      // FR: Saupoudre la farine, remue 2 minutes, puis verse le bouillon chaud.
      'Espolvorea la harina, remueve 2 minutos y vierte el caldo caliente.',
      // FR: Laisse mijoter 20 minutes.
      'Deja cocer a fuego lento 20 minutos.',
      // FR: Verse en bols, pose le pain, couvre de gruyère.
      'Reparte en cuencos, coloca el pan y cubre con el gruyère.',
      // FR: Sous le gril 5 minutes, jusqu'à la croûte.
      'Gratina 5 minutos hasta formar costra.',
    ],
  ),
  'oignon/Oignons confits': RecipeText(
    // FR: Oignons confits
    name: 'Cebollas confitadas',
    // FR: Doux et sirupeux, ils se gardent au frais et relèvent tout.
    description: 'Dulces y almibaradas, se guardan en frío y realzan cualquier plato.',
    ingredients: <String>[
      '1 kg de cebollas', // FR: 1 kg d'oignons
      '3 cucharadas soperas de azúcar', // FR: 3 cuillères à soupe de sucre
      '5 cl de vinagre de vino', // FR: 5 cl de vinaigre de vin
      '2 cucharadas soperas de aceite', // FR: 2 cuillères à soupe d'huile
      'sal, tomillo', // FR: sel, thym
    ],
    steps: <String>[
      // FR: Émince les oignons.
      'Corta las cebollas en juliana.',
      // FR: Fais-les suer à l'huile 15 minutes à couvert.
      'Sudalas en el aceite 15 minutos, tapadas.',
      // FR: Ajoute sucre, vinaigre, sel, thym. Découvre et laisse réduire.
      'Añade el azúcar, el vinagre, la sal y el tomillo. Destapa y deja reducir.',
      // FR: Encore 30 minutes à feu doux : ils doivent brunir et devenir sirupeux.
      'Otros 30 minutos a fuego suave: deben dorarse y quedar almibaradas.',
      // FR: En bocal, ils tiennent une semaine au réfrigérateur.
      'En un tarro, aguantan una semana en la nevera.',
    ],
  ),
  'oignon/Tarte à l\'oignon': RecipeText(
    // FR: Tarte à l'oignon
    name: 'Tarta de cebolla',
    // FR: Des oignons fondus, des lardons, un appareil à la crème.
    description: 'Cebollas pochadas, taquitos de panceta y una mezcla de nata.',
    ingredients: <String>[
      '1 masa quebrada', // FR: 1 pâte brisée
      '800 g de cebollas', // FR: 800 g d'oignons
      '150 g de taquitos de panceta', // FR: 150 g de lardons
      '20 cl de nata, 2 huevos', // FR: 20 cl de crème, 2 oeufs
      'sal, pimienta, nuez moscada', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Émince les oignons, fais-les fondre 25 minutes.
      'Corta las cebollas en juliana y póchalas 25 minutos.',
      // FR: Ajoute les lardons 5 minutes.
      'Añade los taquitos de panceta 5 minutos.',
      // FR: Bats crème, oeufs, poivre, muscade. Sale peu.
      'Bate la nata, los huevos, la pimienta y la nuez moscada. Sala poco.',
      // FR: Garnis la pâte, verse l'appareil.
      'Forra el molde con la masa y vierte la mezcla.',
      // FR: Four à 190 °C, 30 minutes.
      'Horno a 190 °C, 30 minutos.',
    ],
  ),

  // ─────────── origan (6 recettes) ───────────
  'origan/Bouquets d\'origan séchés': RecipeText(
    // FR: Bouquets d'origan séchés
    name: 'Ramilletes de orégano secos',
    // FR: L'origan est plus parfumé sec que frais : c'est sa conservation reine.
    description: 'El orégano es más aromático seco que fresco: esa es su mejor forma de conservarlo.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      'tallos de orégano al comienzo de la floración', // FR: des tiges d'origan en début de floraison
      'cordel', // FR: de la ficelle
      'una bolsa grande de papel', // FR: un grand sac en papier
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges quand les **premières fleurs s'ouvrent** : c'est là que l'arôme est au maximum.
      'Corta los tallos cuando **se abran las primeras flores**: es cuando el aroma es máximo.',
      // FR: Secoue-les pour faire tomber les insectes et lie-les en petits bouquets lâches.
      'Sacúdelos para que caigan los insectos y átalos en ramilletes pequeños y sueltos.',
      // FR: Suspends-les tête en bas dans un sac en papier percé de quelques trous, à l'ombre et au sec, une dizaine de jours.
      'Cuélgalos boca abajo en una bolsa de papel con algunos agujeros, a la sombra y en seco, una decena de días.',
      // FR: Frotte les tiges au-dessus d'une feuille de papier : feuilles et fleurs se détachent ensemble.
      'Frota los tallos sobre una hoja de papel: hojas y flores se desprenden juntas.',
      // FR: Retire les bouts de tige et mets en bocal bien fermé. Émiette-le entre tes paumes juste avant de l'utiliser.
      'Retira los trozos de tallo y guarda en un tarro bien cerrado. Desmenúzalo entre las palmas justo antes de usarlo.',
    ],
  ),
  'origan/Glaçons d\'origan à l\'huile d\'olive': RecipeText(
    // FR: Glaçons d'origan à l'huile d'olive
    name: 'Cubitos de orégano con aceite de oliva',
    // FR: Pour garder aussi le goût de l'origan frais, prêt à fondre dans une sauce tomate.
    description: 'Para conservar también el sabor del orégano fresco, listo para derretirse en una salsa de tomate.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 buenos puñados de hojas de orégano', // FR: 2 belles poignées de feuilles d'origan
      '10 cl de aceite de oliva', // FR: 10 cl d'huile d'olive
      'una cubitera', // FR: un bac à glaçons
      'una bolsa de congelación', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Rince les tiges et sèche-les bien sur un torchon.
      'Aclara los tallos y sécalos bien con un paño.',
      // FR: Effeuille et hache grossièrement les feuilles.
      'Deshoja y pica grueso las hojas.',
      // FR: Remplis les cases du bac aux trois quarts de feuilles et couvre d'huile d'olive à ras.
      'Llena los huecos de la cubitera hasta tres cuartos de hojas y cubre con aceite de oliva hasta el borde.',
      // FR: Congèle jusqu'à ce que les cubes soient durs, puis démoule-les en sac.
      'Congela hasta que los cubos estén duros y desmóldalos en una bolsa.',
      // FR: Jette un cube gelé directement dans la sauce ou la poêle. **Ne garde jamais** l'huile aux herbes décongelée hors du frigo.
      'Echa un cubo congelado directamente en la salsa o en la sartén. **No dejes nunca** el aceite con hierbas descongelado fuera de la nevera.',
    ],
  ),
  'origan/Huile d\'olive à l\'origan séché': RecipeText(
    // FR: Huile d'olive à l'origan séché
    name: 'Aceite de oliva con orégano seco',
    // FR: Un filet sur la pizza ou la feta, à faire avec ton origan déjà séché et à garder au frais.
    description: 'Un chorrito sobre la pizza o la feta, para hacer con tu orégano ya seco y guardar en frío.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      '3 cucharadas soperas de orégano bien seco', // FR: 3 cuillères à soupe d'origan bien sec
      '25 cl de aceite de oliva', // FR: 25 cl d'huile d'olive
      '1 botella pequeña limpia y seca', // FR: 1 petite bouteille propre et sèche
    ],
    steps: <String>[
      // FR: Utilise de l'origan **parfaitement sec**, jamais frais : l'eau des herbes fraîches dans l'huile est dangereuse.
      'Usa orégano **perfectamente seco**, nunca fresco: el agua de las hierbas frescas en el aceite es peligrosa.',
      // FR: Fais tiédir l'huile à feu très doux avec l'origan, sans frémissement, puis coupe le feu.
      'Templa el aceite a fuego muy suave con el orégano, sin que llegue a hervir, y apaga el fuego.',
      // FR: Laisse infuser hors du feu jusqu'à ce que l'huile soit tiède.
      'Deja infusionar fuera del fuego hasta que el aceite esté tibio.',
      // FR: Filtre dans la bouteille à travers une passoire fine et un entonnoir.
      'Filtra en la botella con un colador fino y un embudo.',
      // FR: Ferme et range-la **tout de suite au réfrigérateur**. Elle fige au froid : sors-la 15 minutes avant de t'en servir.
      'Cierra y guárdala **enseguida en la nevera**. Se solidifica con el frío: sácala 15 minutos antes de usarla.',
    ],
  ),
  'origan/Sauce tomate à l\'origan': RecipeText(
    // FR: Sauce tomate à l'origan
    name: 'Salsa de tomate con orégano',
    // FR: Séché plutôt que frais : il est plus puissant.
    description: 'Mejor seco que fresco: es más potente.',
  ),
  'origan/Pizza margherita': RecipeText(
    // FR: Pizza margherita
    name: 'Pizza margarita',
    // FR: Origan sur la tomate avant le four, basilic après.
    description: 'Orégano sobre el tomate antes del horno, albahaca después.',
  ),
  'origan/Feta marinée à l\'origan': RecipeText(
    // FR: Feta marinée à l'origan
    name: 'Feta marinada con orégano',
    // FR: En cubes dans l'huile, avec du citron et du poivre.
    description: 'En cubos en aceite, con limón y pimienta.',
  ),

  // ─────────── oseille (6 recettes) ───────────
  'oseille/Oseille fondue au beurre à congeler': RecipeText(
    // FR: Oseille fondue au beurre à congeler
    name: 'Acedera pochada en mantequilla para congelar',
    // FR: L'oseille fond en une minute dans le beurre : congelée en portions, elle donne une sauce acidulée en un instant.
    description: 'La acedera se deshace en un minuto en la mantequilla: congelada en raciones, da una salsa acidulada en un instante.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 kg de acedera', // FR: 1 kg d'oseille
      '50 g de mantequilla', // FR: 50 g de beurre
      'sal', // FR: sel
      'una cubitera o cajitas pequeñas', // FR: un bac à glaçons ou de petites boîtes
    ],
    steps: <String>[
      // FR: Lave l'oseille et égoutte-la bien.
      'Lava la acedera y escúrrela bien.',
      // FR: Retire les tiges en tirant dessus : elles emportent la nervure centrale, qui est dure.
      'Quita los tallos tirando de ellos: se llevan el nervio central, que es duro.',
      // FR: Fais fondre le beurre dans une grande casserole, jette l'oseille et remue : en **2 à 3 minutes** elle fond en purée kaki.
      'Derrite la mantequilla en una cacerola grande, echa la acedera y remueve: en **2 o 3 minutos** se deshace en un puré color caqui.',
      // FR: Sale légèrement et laisse évaporer l'eau 2 minutes de plus.
      'Sala ligeramente y deja evaporar el agua 2 minutos más.',
      // FR: Laisse refroidir complètement.
      'Deja enfriar por completo.',
      // FR: Répartis dans un bac à glaçons ou de petites boîtes, congèle, puis démoule en sac daté.
      'Reparte en una cubitera o en cajitas pequeñas, congela y desmolda en una bolsa con la fecha.',
    ],
  ),
  'oseille/Oseille hachée en glaçons': RecipeText(
    // FR: Oseille hachée en glaçons
    name: 'Acedera picada en cubitos',
    // FR: Dix minutes, crue et hachée : chaque glaçon parfume une omelette ou une soupe en fin de cuisson.
    description: 'Diez minutos, cruda y picada: cada cubito perfuma una tortilla o una sopa al final de la cocción.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '500 g de acedera', // FR: 500 g d'oseille
      'un poco de agua', // FR: un peu d'eau
      'una cubitera', // FR: un bac à glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave l'oseille et sèche-la au torchon.
      'Lava la acedera y sécala con un paño.',
      // FR: Équeute et cisèle finement les feuilles en lanières.
      'Quita los tallos y corta las hojas en tiras finas.',
      // FR: Tasse l'oseille dans les cases d'un bac à glaçons et complète avec un fond d'eau pour la protéger de l'air.
      'Aprieta la acedera en los huecos de una cubitera y completa con un fondo de agua para protegerla del aire.',
      // FR: Congèle 4 heures, puis démoule les cubes et garde-les en sac. Utilise-les directement dans la poêle ou la casserole, sans décongeler.
      'Congela 4 horas, desmolda los cubos y guárdalos en una bolsa. Úsalos directamente en la sartén o en la cacerola, sin descongelar.',
    ],
  ),
  'oseille/Oseille séchée': RecipeText(
    // FR: Oseille séchée
    name: 'Acedera seca',
    // FR: Séchée à l'ombre, elle garde son acidité pour parfumer les soupes et les sauces en plein hiver.
    description: 'Secada a la sombra, conserva su acidez para dar aroma a sopas y salsas en pleno invierno.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegida de la luz',
    ingredients: <String>[
      '500 g de hojas de acedera', // FR: 500 g de feuilles d'oseille
      'rejillas o bandejas', // FR: des grilles ou plaques
      '2 tarros pequeños bien secos', // FR: 2 petits bocaux bien secs
    ],
    steps: <String>[
      // FR: Lave les feuilles et sèche-les complètement à l'essoreuse puis au torchon.
      'Lava las hojas y sécalas por completo con la centrifugadora y luego con un paño.',
      // FR: Équeute-les et laisse-les entières.
      'Quítales el tallo y déjalas enteras.',
      // FR: Étale-les sans qu'elles se chevauchent et sèche au four à 40 °C, porte entrouverte, ou au déshydrateur.
      'Extiéndelas sin que se solapen y seca en el horno a 40 °C, con la puerta entreabierta, o en el deshidratador.',
      // FR: Elles sont prêtes quand elles se brisent entre les doigts. Si elles plient encore, continue.
      'Están listas cuando se rompen entre los dedos. Si aún se doblan, sigue.',
      // FR: Émiette-les grossièrement et mets-les en bocaux fermés, dans un placard sombre.
      'Desmenúzalas grueso y guárdalas en tarros cerrados, en un armario oscuro.',
    ],
  ),
  'oseille/Sauce à l\'oseille': RecipeText(
    // FR: Sauce à l'oseille
    name: 'Salsa de acedera',
    // FR: Fondue à la crème, pour un saumon ou un œuf poché.
    description: 'Pochada con nata, para un salmón o un huevo poché.',
  ),
  'oseille/Soupe à l\'oseille': RecipeText(
    // FR: Soupe à l'oseille
    name: 'Sopa de acedera',
    // FR: Acidulée, liée d'un jaune d'œuf hors du feu.
    description: 'Acidulada, ligada con una yema de huevo fuera del fuego.',
  ),
  'oseille/Omelette à l\'oseille': RecipeText(
    // FR: Omelette à l'oseille
    name: 'Tortilla de acedera',
    // FR: Les feuilles fondent en quelques secondes.
    description: 'Las hojas se deshacen en unos segundos.',
  ),


  // ─────────── pak_choi (6 recettes) ───────────
  'pak_choi/Pak choï blanchi congelé': RecipeText(
    // FR: Pak choï blanchi congelé
    name: 'Pak choi blanqueado y congelado',
    // FR: Coupé en quartiers et blanchi juste ce qu'il faut, il garde sa tige croquante pour tes woks d'hiver.
    description: 'Cortado en cuartos y blanqueado justo lo necesario, conserva su tallo crujiente para tus woks de invierno.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de pak choi', // FR: 1,5 kg de pak choï
      'sal gorda', // FR: gros sel
      '1 ensaladera grande de agua y cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les pieds en deux ou en quatre dans la longueur, en gardant la base pour que les feuilles tiennent.
      'Corta las matas en dos o en cuatro a lo largo, conservando la base para que las hojas se mantengan unidas.',
      // FR: Rince bien entre les tiges, où la terre se loge.
      'Acláralas bien entre los tallos, donde se esconde la tierra.',
      // FR: Plonge-les dans une grande eau bouillante salée, **2 minutes**, pas plus.
      'Sumérgelas en abundante agua hirviendo con sal, **2 minutos**, ni uno más.',
      // FR: Transfère aussitôt dans l'eau glacée pour fixer le vert.
      'Pásalas enseguida al agua con hielo para fijar el verde.',
      // FR: Égoutte la tête en bas puis sèche sur un torchon en pressant doucement.
      'Escúrrelas boca abajo y sécalas sobre un paño presionando suavemente.',
      // FR: Congèle 2 heures sur une plaque, puis mets en sacs datés. Fais-le sauter encore gelé, à feu vif.
      'Congela 2 horas sobre una bandeja y luego pasa a bolsas con fecha. Saltéalo aún congelado, a fuego vivo.',
    ],
  ),
  'pak_choi/Pak choï lacto-fermenté au piment': RecipeText(
    // FR: Pak choï lacto-fermenté au piment
    name: 'Pak choi lacto-fermentado con guindilla',
    // FR: En saumure une petite semaine, il devient acidulé et piquant, un condiment pour tes bols de riz.
    description: 'En salmuera una semanita, se vuelve ácido y picante, un condimento para tus cuencos de arroz.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '1 kg de pak choi', // FR: 1 kg de pak choï
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '1 guindilla fresca', // FR: 1 piment frais
      '1 trozo de jengibre de 3 cm', // FR: 1 morceau de gingembre de 3 cm
    ],
    steps: <String>[
      // FR: Fais dissoudre **30 g de sel dans 1 litre d'eau** : saumure à 3 %.
      'Disuelve **30 g de sal en 1 litro de agua**: salmuera al 3 %.',
      // FR: Coupe le pak choï en tronçons de 3 cm, le piment en rondelles, le gingembre en lamelles.
      'Corta el pak choi en trozos de 3 cm, la guindilla en rodajas y el jengibre en láminas.',
      // FR: Rince les tronçons et égoutte-les bien.
      'Aclara los trozos y escúrrelos bien.',
      // FR: Tasse le tout dans deux bocaux jusqu'à 3 cm du bord, et couvre de saumure.
      'Apisona todo en dos tarros hasta 3 cm del borde y cúbrelo con la salmuera.',
      // FR: Pose un poids pour garder les feuilles **sous la saumure**, et ferme sans serrer.
      'Pon un peso para mantener las hojas **bajo la salmuera** y cierra sin apretar.',
      // FR: Laisse fermenter 1 semaine à 18–22 °C, puis goûte : acidulé, c'est prêt. Sinon, quelques jours de plus. Ensuite, au réfrigérateur.
      'Deja fermentar 1 semana a 18–22 °C y prueba: si está ácido, ya está listo. Si no, unos días más. Después, a la nevera.',
    ],
  ),
  'pak_choi/Tiges de pak choï au vinaigre de riz': RecipeText(
    // FR: Tiges de pak choï au vinaigre de riz
    name: 'Tallos de pak choi en vinagre de arroz',
    // FR: Les tiges blanches, croquantes comme du céleri, deviennent un pickle aigre-doux en vingt minutes.
    description: 'Los tallos blancos, crujientes como el apio, se convierten en un encurtido agridulce en veinte minutos.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      '500 g de tallos de pak choi', // FR: 500 g de tiges de pak choï
      '25 cl de vinagre blanco al 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl de agua', // FR: 25 cl d'eau
      '10 g de sal, 40 g de azúcar', // FR: 10 g de sel, 40 g de sucre
      '1 diente de ajo', // FR: 1 gousse d'ail
    ],
    steps: <String>[
      // FR: Sépare les tiges des feuilles et taille-les en bâtonnets. Les feuilles iront dans une poêlée.
      'Separa los tallos de las hojas y córtalos en bastoncitos. Las hojas irán a una sartén salteada.',
      // FR: Range les bâtonnets dans deux bocaux ébouillantés avec l'ail en lamelles.
      'Coloca los bastoncitos en dos tarros escaldados con el ajo en láminas.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre.
      'Hierve el vinagre, el agua, la sal y el azúcar.',
      // FR: Verse bouillant pour **couvrir entièrement** les tiges et ferme.
      'Vierte hirviendo para **cubrir por completo** los tallos y cierra.',
      // FR: Laisse refroidir, puis au réfrigérateur. Bons au bout de 24 heures.
      'Deja enfriar y llévalos a la nevera. Están buenos a las 24 horas.',
    ],
  ),
  'pak_choi/Pak choï vapeur sauce soja': RecipeText(
    // FR: Pak choï vapeur sauce soja
    name: 'Pak choi al vapor con salsa de soja',
    // FR: Fendu en deux, cinq minutes de vapeur, un filet de soja.
    description: 'Abierto en dos, cinco minutos de vapor y un chorrito de soja.',
  ),
  'pak_choi/Pak choï sauté à l\'ail': RecipeText(
    // FR: Pak choï sauté à l'ail
    name: 'Pak choi salteado con ajo',
    // FR: Les tiges d'abord, les feuilles à la fin.
    description: 'Primero los tallos, las hojas al final.',
  ),
  'pak_choi/Nouilles sautées au pak choï': RecipeText(
    // FR: Nouilles sautées au pak choï
    name: 'Fideos salteados con pak choi',
    // FR: Un plat complet en un seul wok.
    description: 'Un plato completo en un solo wok.',
  ),

  // ─────────── panais (6 recettes) ───────────
  'panais/Rondelles de panais blanchies': RecipeText(
    // FR: Rondelles de panais blanchies
    name: 'Rodajas de chirivía blanqueadas',
    // FR: Trois minutes dans l'eau bouillante, et les rondelles vont directement du sac au four ou à la soupe.
    description: 'Tres minutos en agua hirviendo y las rodajas pasan directamente de la bolsa al horno o a la sopa.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de chirivías', // FR: 2 kg de panais
      'sal gorda', // FR: gros sel
      '1 ensaladera grande de agua y cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les panais et coupe-les en rondelles de 1 cm. Retire le cœur s'il est dur et ligneux sur les gros.
      'Pela las chirivías y córtalas en rodajas de 1 cm. Quita el corazón si es duro y leñoso en las grandes.',
      // FR: Blanchis-les **3 minutes** dans une grande eau bouillante salée.
      'Blanquéalas **3 minutos** en abundante agua hirviendo con sal.',
      // FR: Plonge-les aussitôt dans l'eau glacée : sinon ils continuent de cuire et deviennent farineux.
      'Sumérgelas enseguida en el agua con hielo: si no, siguen cocinándose y quedan harinosas.',
      // FR: Égoutte et sèche bien sur un torchon.
      'Escúrrelas y sécalas bien sobre un paño.',
      // FR: Congèle sur plaque 2 heures sans qu'elles se touchent, puis verse en sacs datés.
      'Congela sobre una bandeja 2 horas sin que se toquen y luego pásalas a bolsas con fecha.',
    ],
  ),
  'panais/Écrasé de panais en portions': RecipeText(
    // FR: Écrasé de panais en portions
    name: 'Puré rústico de chirivía en porciones',
    // FR: Cuit, écrasé au beurre et congelé à plat : un accompagnement prêt en cinq minutes les soirs pressés.
    description: 'Cocida, aplastada con mantequilla y congelada plana: una guarnición lista en cinco minutos las noches con prisa.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 kg de chirivías', // FR: 2 kg de panais
      '60 g de mantequilla', // FR: 60 g de beurre
      '1 pizca de nuez moscada', // FR: 1 pincée de muscade
      'sal, pimienta', // FR: sel, poivre
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les panais et coupe-les en tronçons égaux.
      'Pela las chirivías y córtalas en trozos iguales.',
      // FR: Cuis-les à l'eau salée jusqu'à ce qu'un couteau s'enfonce sans résistance.
      'Cuécelas en agua con sal hasta que un cuchillo entre sin resistencia.',
      // FR: Égoutte bien puis écrase à la fourchette ou au presse-purée avec le beurre et la muscade. Pas au mixeur : ça devient collant.
      'Escúrrelas bien y aplástalas con un tenedor o un pasapurés junto con la mantequilla y la nuez moscada. Nada de batidora: se vuelve pegajoso.',
      // FR: Laisse refroidir complètement, étalé dans un plat : un écrasé tiède fait de gros cristaux au congélateur.
      'Deja enfriar por completo, extendido en una fuente: un puré tibio forma cristales grandes en el congelador.',
      // FR: Répartis en sacs d'une portion, aplatis-les pour qu'ils congèlent et décongèlent vite, et date-les.
      'Reparte en bolsas de una porción, aplánalas para que se congelen y descongelen rápido, y ponles fecha.',
    ],
  ),
  'panais/Chips de panais séchées': RecipeText(
    // FR: Chips de panais séchées
    name: 'Chips de chirivía secas',
    // FR: Tranchées fines et séchées au four doux, elles se grignotent tout l'hiver.
    description: 'Cortadas finas y secadas en horno suave, se picotean todo el invierno.',
    // FR: 1 mois en boîte hermétique, au sec
    keeps: '1 mes en caja hermética, en lugar seco',
    ingredients: <String>[
      '1 kg de chirivías', // FR: 1 kg de panais
      '1 cucharada sopera de aceite de oliva', // FR: 1 cuillère à soupe d'huile d'olive
      '1 cucharadita de sal fina', // FR: 1 cuillère à café de sel fin
      'una caja hermética', // FR: une boîte hermétique
    ],
    steps: <String>[
      // FR: Épluche les panais et tranche-les très finement à la mandoline, 2 mm maximum.
      'Pela las chirivías y córtalas muy finas con la mandolina, 2 mm como máximo.',
      // FR: Mélange les tranches avec l'huile et le sel, en les frottant pour bien les enrober.
      'Mezcla las lonchas con el aceite y la sal, frotándolas para que queden bien cubiertas.',
      // FR: Étale-les en une couche sur des plaques garnies de papier cuisson et enfourne à 100 °C, porte entrouverte.
      'Extiéndelas en una sola capa sobre bandejas forradas con papel de horno y hornea a 100 °C, con la puerta entreabierta.',
      // FR: Retourne-les à mi-cuisson. Elles sont prêtes quand elles sont **cassantes**, pas seulement dorées.
      'Dales la vuelta a mitad de cocción. Están listas cuando están **quebradizas**, no solo doradas.',
      // FR: Laisse-les refroidir complètement sur la plaque avant de les enfermer : tièdes, elles ramollissent.
      'Déjalas enfriar por completo sobre la bandeja antes de guardarlas: tibias, se ablandan.',
    ],
  ),
  'panais/Panais rôtis au miel': RecipeText(
    // FR: Panais rôtis au miel
    name: 'Chirivías asadas con miel',
    // FR: Sucré naturellement, le four le confirme.
    description: 'Dulce de por sí, el horno lo confirma.',
  ),
  'panais/Velouté de panais': RecipeText(
    // FR: Velouté de panais
    name: 'Crema de chirivía',
    // FR: Doux, épais, une pointe de muscade.
    description: 'Suave, espesa, con un toque de nuez moscada.',
  ),
  'panais/Purée panais-pomme de terre': RecipeText(
    // FR: Purée panais-pomme de terre
    name: 'Puré de chirivía y patata',
    // FR: Moitié-moitié, pour ne pas écœurer.
    description: 'Mitad y mitad, para que no empalague.',
  ),

  // ─────────── papayer (6 recettes) ───────────
  'papayer/Cubes de papaye mûre congelés': RecipeText(
    // FR: Cubes de papaye mûre congelés
    name: 'Cubos de papaya madura congelados',
    // FR: Quand toutes les papayes mûrissent en même temps, un quart d'heure suffit pour en garder pour les smoothies.
    description: 'Cuando todas las papayas maduran a la vez, un cuarto de hora basta para guardar algunas para los batidos.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '3 papayas maduras', // FR: 3 papayes mûres
      'el zumo de 2 limas', // FR: le jus de 2 citrons verts
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les papayes en deux, retire les graines noires à la cuillère, puis épluche.
      'Corta las papayas por la mitad, quita las semillas negras con una cuchara y pélalas.',
      // FR: Coupe la chair en cubes de 3 cm.
      'Corta la pulpa en cubos de 3 cm.',
      // FR: Arrose de jus de citron vert et mélange : il garde la couleur et réveille le goût.
      'Rocía con zumo de lima y mezcla: conserva el color y realza el sabor.',
      // FR: Étale sur une plaque sans que les cubes se touchent et congèle 2 heures.
      'Extiende en una bandeja sin que los cubos se toquen y congela 2 horas.',
      // FR: Verse en sac une fois durs. À mixer encore gelés avec du lait ou du yaourt.
      'Pásalos a una bolsa cuando estén duros. Para triturar aún congelados con leche o yogur.',
    ],
  ),
  'papayer/Atchara de papaye verte': RecipeText(
    // FR: Atchara de papaye verte
    name: 'Atchara de papaya verde',
    // FR: Le pickle des Philippines : papaye verte râpée, carotte et gingembre dans un vinaigre sucré, croquant pendant des semaines.
    description: 'El encurtido de Filipinas: papaya verde rallada, zanahoria y jengibre en un vinagre azucarado, crujiente durante semanas.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '1 papaya verde de unos 1,5 kg', // FR: 1 papaye verte d'environ 1,5 kg
      '2 zanahorias', // FR: 2 carottes
      '30 g de sal', // FR: 30 g de sel
      '50 cl de vinagre de sidra al 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '30 cl de agua y 200 g de azúcar', // FR: 30 cl d'eau et 200 g de sucre
      '1 trozo de jengibre de 4 cm', // FR: 1 morceau de gingembre de 4 cm
    ],
    steps: <String>[
      // FR: Épluche la papaye verte, ouvre-la, retire les graines blanches, puis râpe-la côté gros trous. Râpe aussi les carottes.
      'Pela la papaya verde, ábrela, quita las semillas blancas y rállala por el lado de los agujeros grandes. Ralla también las zanahorias.',
      // FR: Mélange la râpée avec le sel et laisse une heure : elle rend beaucoup d'eau.
      'Mezcla lo rallado con la sal y déjalo una hora: suelta mucha agua.',
      // FR: Rince à l'eau froide et presse par poignées dans un torchon, **très fort**.
      'Aclara con agua fría y escurre por puñados en un paño, **con mucha fuerza**.',
      // FR: Porte à ébullition le vinaigre, l'eau et le sucre, puis laisse refroidir.
      'Lleva a ebullición el vinagre, el agua y el azúcar, y deja enfriar.',
      // FR: Tasse papaye, carotte et gingembre en julienne dans des bocaux propres.
      'Apisona la papaya, la zanahoria y el jengibre en juliana en tarros limpios.',
      // FR: Verse le vinaigre pour **tout recouvrir**, ferme et range au réfrigérateur. Prête en 2 jours.
      'Vierte el vinagre para **cubrirlo todo**, cierra y guarda en la nevera. Lista en 2 días.',
    ],
  ),
  'papayer/Chutney de papaye au gingembre': RecipeText(
    // FR: Chutney de papaye au gingembre
    name: 'Chutney de papaya con jengibre',
    // FR: Papaye mûre, oignon, piment et vinaigre mijotés longtemps : un chutney sucré-piquant pour les grillades et le fromage.
    description: 'Papaya madura, cebolla, guindilla y vinagre cocidos largo rato: un chutney agridulce y picante para las carnes a la plancha y el queso.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '1 kg de pulpa de papaya apenas madura', // FR: 1 kg de chair de papaye à peine mûre
      '2 cebollas', // FR: 2 oignons
      '30 cl de vinagre de sidra al 6 %', // FR: 30 cl de vinaigre de cidre à 6 %
      '300 g de azúcar moreno', // FR: 300 g de sucre roux
      '1 trozo de jengibre de 4 cm', // FR: 1 morceau de gingembre de 4 cm
      '1 guindilla y 1 cucharadita de sal', // FR: 1 piment et 1 cuillère à café de sel
    ],
    steps: <String>[
      // FR: Coupe la papaye en petits dés, émince les oignons, râpe le gingembre et hache le piment sans ses graines.
      'Corta la papaya en dados pequeños, pica las cebollas en láminas finas, ralla el jengibre y trocea la guindilla sin sus semillas.',
      // FR: Mets tout dans une grande casserole avec le vinaigre, le sucre et le sel, et porte à ébullition.
      'Pon todo en una cazuela grande con el vinagre, el azúcar y la sal, y lleva a ebullición.',
      // FR: Laisse mijoter à petit feu en remuant souvent, surtout à la fin : ça accroche vite.
      'Deja cocer a fuego lento removiendo a menudo, sobre todo al final: se pega enseguida.',
      // FR: C'est prêt quand une cuillère tirée au fond laisse **un sillon qui ne se referme pas**.
      'Está listo cuando una cuchara arrastrada por el fondo deja **un surco que no se cierra**.',
      // FR: Remplis des pots ébouillantés jusqu'à 1 cm du bord, ferme aussitôt.
      'Llena tarros escaldados hasta 1 cm del borde y cierra enseguida.',
      // FR: Laisse refroidir et range au réfrigérateur : la papaye est peu acide, le froid est ta sécurité. Meilleur après une semaine.
      'Deja enfriar y guarda en la nevera: la papaya es poco ácida, el frío es tu seguridad. Mejor tras una semana.',
    ],
  ),
  'papayer/Papaye verte mijotée': RecipeText(
    // FR: Papaye verte mijotée
    name: 'Papaya verde estofada',
    // FR: Encore ferme, elle se cuisine comme une courge.
    description: 'Todavía firme, se cocina como una calabaza.',
  ),
  'papayer/Salade de papaye verte': RecipeText(
    // FR: Salade de papaye verte
    name: 'Ensalada de papaya verde',
    // FR: La papaye encore verte râpée en salade croquante, citronnée et un peu pimentée.
    description: 'La papaya aún verde, rallada en una ensalada crujiente, con limón y un puntito picante.',
  ),
  'papayer/Papaye au citron vert': RecipeText(
    // FR: Papaye au citron vert
    name: 'Papaya con lima',
    // FR: Des tranches de papaye mûre arrosées de citron vert, le dessert le plus simple du monde.
    description: 'Rodajas de papaya madura rociadas con lima, el postre más sencillo del mundo.',
  ),

  // ─────────── pasteque (6 recettes) ───────────
  'pasteque/Cubes de pastèque congelés': RecipeText(
    // FR: Cubes de pastèque congelés
    name: 'Cubos de sandía congelados',
    // FR: Une pastèque entière entamée ne tient pas trois jours : en cubes, elle fait des smoothies et des glaçons tout l'automne.
    description: 'Una sandía entera empezada no aguanta tres días: en cubos, da para batidos y cubitos de hielo todo el otoño.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 sandía bien madura', // FR: 1 pastèque bien mûre
      'bolsas o cajas de congelación', // FR: des sacs ou boîtes de congélation
      'una bandeja y papel de horno', // FR: une plaque et du papier cuisson
    ],
    steps: <String>[
      // FR: Lave l'écorce avant de couper : le couteau entraînerait la terre dans la chair.
      'Lava la corteza antes de cortar: el cuchillo arrastraría la tierra a la pulpa.',
      // FR: Retire l'écorce et coupe la chair en cubes de 3 cm, en ôtant le plus de pépins possible.
      'Quita la corteza y corta la pulpa en cubos de 3 cm, retirando las pepitas que puedas.',
      // FR: Étale les cubes sur une plaque couverte de papier, **sans qu'ils se touchent**, et congèle 3 heures.
      'Extiende los cubos sobre una bandeja cubierta con papel, **sin que se toquen**, y congela 3 horas.',
      // FR: Verse-les en sac une fois durs, chasse l'air et ferme.
      'Pásalos a una bolsa cuando estén duros, saca el aire y cierra.',
      // FR: À l'usage : décongelée elle devient molle, donc mixe-la encore gelée en smoothie ou sers-la comme glaçon.
      'Al usarla: descongelada se queda blanda, así que tritúrala aún congelada en un batido o sírvela como cubito de hielo.',
    ],
  ),
  'pasteque/Granité de pastèque au citron vert': RecipeText(
    // FR: Granité de pastèque au citron vert
    name: 'Granizado de sandía y lima',
    // FR: Mixée, sucrée à peine et grattée à la fourchette : un dessert glacé qui sent encore l'été en octobre.
    description: 'Triturada, apenas azucarada y rascada con un tenedor: un postre helado que aún huele a verano en octubre.',
    // FR: 3 mois au congélateur
    keeps: '3 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de pulpa de sandía sin pepitas', // FR: 1,5 kg de chair de pastèque sans pépins
      '100 g de azúcar', // FR: 100 g de sucre
      'el zumo de 2 limas', // FR: le jus de 2 citrons verts
      'unas hojas de menta', // FR: quelques feuilles de menthe
    ],
    steps: <String>[
      // FR: Coupe la chair en morceaux et retire les pépins.
      'Corta la pulpa en trozos y quita las pepitas.',
      // FR: Mixe-la avec le sucre, le citron vert et la menthe, puis passe au tamis pour un granité bien lisse.
      'Tritúrala con el azúcar, la lima y la menta, y pásala por un colador para un granizado bien fino.',
      // FR: Verse dans un plat large et peu profond : plus la couche est fine, plus ça prend vite.
      'Vierte en una fuente ancha y poco profunda: cuanto más fina es la capa, más rápido cuaja.',
      // FR: Mets au congélateur et gratte à la fourchette **toutes les 30 minutes**, quatre ou cinq fois.
      'Mete en el congelador y rasca con un tenedor **cada 30 minutos**, cuatro o cinco veces.',
      // FR: Quand c'est en paillettes, transvase dans une boîte bien fermée. Gratte encore un coup avant de servir.
      'Cuando esté en escamas, pásalo a una caja bien cerrada. Rasca una vez más antes de servir.',
    ],
  ),
  'pasteque/Pickles d\'écorce de pastèque': RecipeText(
    // FR: Pickles d'écorce de pastèque
    name: 'Encurtido de corteza de sandía',
    // FR: Le blanc de l'écorce, qu'on jette d'habitude, devient un pickle croquant et épicé du sud des États-Unis.
    description: 'El blanco de la corteza, que normalmente se tira, se convierte en un encurtido crujiente y especiado del sur de Estados Unidos.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      'la corteza de una sandía de 5 kg (unos 1 kg de parte blanca)', // FR: l'écorce d'une pastèque de 5 kg (environ 1 kg de blanc)
      '50 cl de vinagre de sidra al 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '50 cl de agua', // FR: 50 cl d'eau
      '250 g de azúcar', // FR: 250 g de sucre
      '1 cucharada sopera de sal', // FR: 1 cuillère à soupe de sel
      '1 rama de canela y 5 clavos', // FR: 1 bâton de cannelle et 5 clous de girofle
    ],
    steps: <String>[
      // FR: Épluche la peau verte dure au couteau éplucheur et garde le blanc, avec un fin liseré rose.
      'Pela la piel verde dura con un pelador y conserva la parte blanca, con un fino borde rosa.',
      // FR: Coupe ce blanc en cubes de 2 cm.
      'Corta esa parte blanca en cubos de 2 cm.',
      // FR: Cuis les cubes à l'eau salée frémissante jusqu'à ce qu'ils soient juste tendres, translucides sur les bords.
      'Cuece los cubos en agua con sal a fuego suave hasta que estén justo tiernos, translúcidos en los bordes.',
      // FR: Dans une autre casserole, fais bouillir vinaigre, eau, sucre et épices 5 minutes.
      'En otra cazuela, hierve el vinagre, el agua, el azúcar y las especias 5 minutos.',
      // FR: Égoutte les cubes, mets-les dans le sirop vinaigré et laisse frémir 10 minutes.
      'Escurre los cubos, ponlos en el almíbar avinagrado y deja hervir a fuego suave 10 minutos.',
      // FR: Remplis des bocaux propres à 2 cm du bord et **couvre entièrement** de liquide chaud. Ferme, laisse refroidir, puis au réfrigérateur.
      'Llena tarros limpios hasta 2 cm del borde y **cubre por completo** con el líquido caliente. Cierra, deja enfriar y a la nevera.',
    ],
  ),
  'pasteque/Salade pastèque-feta-menthe': RecipeText(
    // FR: Salade pastèque-feta-menthe
    name: 'Ensalada de sandía, feta y menta',
    // FR: Le salé de la feta contre le sucre du fruit.
    description: 'Lo salado del feta frente a lo dulce de la fruta.',
  ),
  'pasteque/Confiture d\'écorces de pastèque': RecipeText(
    // FR: Confiture d'écorces de pastèque
    name: 'Mermelada de cortezas de sandía',
    // FR: Le blanc de l'écorce, qu'on jette toujours à tort.
    description: 'El blanco de la corteza, que siempre se tira sin razón.',
  ),
  'pasteque/Jus de pastèque frais': RecipeText(
    // FR: Jus de pastèque frais
    name: 'Zumo de sandía fresco',
    // FR: La pastèque mixée avec un peu de citron vert, la boisson des grandes chaleurs.
    description: 'La sandía triturada con un poco de lima, la bebida de los grandes calores.',
  ),

  // ─────────── patate_douce (6 recettes) ───────────
  'patate_douce/Cubes de patate douce rôtis au congélateur': RecipeText(
    // FR: Cubes de patate douce rôtis au congélateur
    name: 'Cubos de boniato asados para el congelador',
    // FR: Rôtis d'avance, ils passent du congélateur au four en dix minutes, pour une soirée sans éplucher.
    description: 'Asados de antemano, pasan del congelador al horno en diez minutos, para una noche sin pelar.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de boniatos', // FR: 2 kg de patates douces
      '3 cucharadas soperas de aceite', // FR: 3 cuillères à soupe d'huile
      '1 cucharadita de sal', // FR: 1 cuillère à café de sel
      'papel de horno', // FR: du papier cuisson
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les patates douces et coupe-les en cubes de 2 cm, tous pareils.
      'Pela los boniatos y córtalos en cubos de 2 cm, todos iguales.',
      // FR: Mélange-les à l'huile et au sel dans un grand saladier, pour que chaque cube soit enrobé.
      'Mézclalos con el aceite y la sal en una ensaladera grande, para que cada cubo quede bien cubierto.',
      // FR: Étale-les sur des plaques sans les entasser et rôtis 25 minutes à 200 °C : **tendres mais pas fondants**.
      'Extiéndelos en bandejas sin amontonarlos y ásalos 25 minutos a 200 °C: **tiernos pero sin deshacerse**.',
      // FR: Laisse-les refroidir complètement sur la plaque.
      'Déjalos enfriar por completo sobre la bandeja.',
      // FR: Congèle la plaque 2 heures, puis verse les cubes en sac. Réchauffe-les sans décongeler, 10 minutes à 220 °C.
      'Congela la bandeja 2 horas y pasa los cubos a una bolsa. Recaliéntalos sin descongelar, 10 minutos a 220 °C.',
    ],
  ),
  'patate_douce/Patates douces blanchies en dés': RecipeText(
    // FR: Patates douces blanchies en dés
    name: 'Boniatos blanqueados en dados',
    // FR: Trois minutes dans l'eau, et des dés prêts pour les mafés, les currys et les soupes, sans perdre leur couleur.
    description: 'Tres minutos en el agua y unos dados listos para los mafés, los currys y las sopas, sin perder el color.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de boniatos', // FR: 1,5 kg de patates douces
      'el zumo de un limón', // FR: le jus d'un citron
      'una ensaladera grande de agua con hielo', // FR: un grand saladier d'eau glacée
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche et coupe en dés de 2 cm ; jette-les au fur et à mesure dans l'eau citronnée pour qu'ils ne brunissent pas.
      'Pela y corta en dados de 2 cm; échalos al agua con limón según los vayas cortando para que no se oscurezcan.',
      // FR: Plonge-les dans l'eau bouillante et compte **3 minutes** à la reprise de l'ébullition.
      'Sumérgelos en agua hirviendo y cuenta **3 minutos** desde que vuelva a hervir.',
      // FR: Transfère-les aussitôt dans l'eau glacée.
      'Pásalos enseguida al agua con hielo.',
      // FR: Égoutte-les et sèche-les sur un torchon.
      'Escúrrelos y sécalos sobre un paño.',
      // FR: Étale-les sur une plaque, congèle 2 heures, puis mets-les en sac. Cuis-les sans décongeler, ils finissent de cuire dans le plat.
      'Extiéndelos en una bandeja, congela 2 horas y luego ponlos en una bolsa. Cocínalos sin descongelar, terminan de hacerse en el plato.',
    ],
  ),
  'patate_douce/Rondelles de patate douce déshydratées': RecipeText(
    // FR: Rondelles de patate douce déshydratées
    name: 'Rodajas de boniato deshidratadas',
    // FR: Cuites puis séchées, elles se croquent comme des fruits secs ou regonflent dans une soupe.
    description: 'Cocidas y luego secadas, se pican como frutos secos o se rehidratan en una sopa.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegido de la luz',
    ingredients: <String>[
      '1,5 kg de boniatos', // FR: 1,5 kg de patates douces
      'papel de horno', // FR: du papier cuisson
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Épluche et coupe en rondelles de 5 mm, bien régulières.
      'Pela y corta en rodajas de 5 mm, bien regulares.',
      // FR: Cuis-les à la vapeur jusqu'à ce qu'elles soient tendres mais encore entières.
      'Cuécelas al vapor hasta que estén tiernas pero aún enteras.',
      // FR: Laisse-les refroidir et sécher à l'air sur une grille, une seule couche.
      'Déjalas enfriar y secarse al aire sobre una rejilla, en una sola capa.',
      // FR: Sèche-les au four à **60 °C**, porte entrouverte, ou au déshydrateur. Retourne-les à mi-temps.
      'Sécalas en el horno a **60 °C**, con la puerta entreabierta, o en el deshidratador. Dales la vuelta a mitad de tiempo.',
      // FR: C'est prêt quand elles sont souples comme du cuir, sans aucune zone humide quand tu les plies.
      'Están listas cuando son flexibles como el cuero, sin ninguna zona húmeda al doblarlas.',
      // FR: Laisse refroidir une heure avant de les mettre en bocal. Secoue le bocal les premiers jours : s'il y a de la buée, remets au four.
      'Deja enfriar una hora antes de ponerlas en el tarro. Agita el tarro los primeros días: si hay vaho, vuelven al horno.',
    ],
  ),
  'patate_douce/Frites de patate douce au four': RecipeText(
    // FR: Frites de patate douce au four
    name: 'Patatas fritas de boniato al horno',
    // FR: Fécule de maïs avant cuisson : c'est ce qui les rend croustillantes.
    description: 'Maicena antes de hornear: es lo que las deja crujientes.',
  ),
  'patate_douce/Frites de patate douce': RecipeText(
    // FR: Frites de patate douce
    name: 'Patatas fritas de boniato',
    // FR: Des frites dorées et sucrées-salées qui plaisent à toute la famille.
    description: 'Patatas doradas y agridulces que gustan a toda la familia.',
  ),
  'patate_douce/Purée de patate douce': RecipeText(
    // FR: Purée de patate douce
    name: 'Puré de boniato',
    // FR: Une purée orange, veloutée et naturellement sucrée, douce comme tout.
    description: 'Un puré naranja, sedoso y naturalmente dulce, suave como pocos.',
  ),

  // ─────────── pecher (6 recettes) ───────────
  'pecher/Confiture de pêches à la vanille': RecipeText(
    // FR: Confiture de pêches à la vanille
    name: 'Mermelada de melocotón con vainilla',
    // FR: La pêche ne se garde pas trois jours : en confiture, elle tient jusqu'à l'été suivant.
    description: 'El melocotón no aguanta tres días: en mermelada, dura hasta el verano siguiente.',
    // FR: 1 an au placard, 3 semaines ouvert au réfrigérateur
    keeps: '1 año en la despensa, 3 semanas abierto en la nevera',
    ingredients: <String>[
      '1,5 kg de melocotones bien maduros', // FR: 1,5 kg de pêches bien mûres
      '1 kg de azúcar', // FR: 1 kg de sucre
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      '1 vaina de vainilla', // FR: 1 gousse de vanille
      '6 tarros de mermelada', // FR: 6 pots de confiture
    ],
    steps: <String>[
      // FR: Plonge les pêches **30 secondes** dans l'eau bouillante, puis dans l'eau froide : la peau s'enlève toute seule.
      'Sumerge los melocotones **30 segundos** en agua hirviendo y luego en agua fría: la piel se quita sola.',
      // FR: Pèle-les, retire le noyau et coupe la chair en dés de 2 cm. Tu dois avoir environ 1,2 kg de chair.
      'Pélalos, quita el hueso y corta la pulpa en dados de 2 cm. Deberías tener unos 1,2 kg de pulpa.',
      // FR: Mélange les dés avec le sucre, le citron et la vanille fendue, et laisse macérer au frais.
      'Mezcla los dados con el azúcar, el limón y la vainilla abierta, y deja macerar en un sitio fresco.',
      // FR: Porte à ébullition et cuis à feu vif en remuant et en écumant.
      'Lleva a ebullición y cuece a fuego vivo removiendo y espumando.',
      // FR: Teste sur une assiette froide : une goutte qui se fige est prête. La pêche manque de pectine, c'est le citron qui fait prendre.
      'Prueba sobre un plato frío: una gota que cuaja está lista. El melocotón tiene poca pectina, es el limón el que hace que cuaje.',
      // FR: Retire la vanille, mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Retira la vainilla, pon en tarros escaldados, cierra y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'pecher/Quartiers de pêches congelés': RecipeText(
    // FR: Quartiers de pêches congelés
    name: 'Gajos de melocotón congelados',
    // FR: Pelées, citronnées, congelées sur plaque : de la pêche en hiver pour les smoothies et les gâteaux.
    description: 'Pelados, con limón, congelados en bandeja: melocotón en invierno para los batidos y los pasteles.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de melocotones maduros pero firmes', // FR: 2 kg de pêches mûres mais fermes
      'el zumo de un limón', // FR: le jus d'un citron
      'un recipiente de agua con hielo', // FR: un saladier d'eau glacée
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Plonge les pêches **30 secondes** dans l'eau bouillante pour décoller la peau.
      'Sumerge los melocotones **30 segundos** en agua hirviendo para despegar la piel.',
      // FR: Passe-les aussitôt dans l'eau glacée, puis pèle-les à la main.
      'Pásalos enseguida al agua con hielo y pélalos a mano.',
      // FR: Coupe-les en quartiers et retire le noyau.
      'Córtalos en gajos y quita el hueso.',
      // FR: Arrose de jus de citron et mélange : sans lui, la chair brunit au congélateur.
      'Rocía con zumo de limón y mezcla: sin él, la pulpa se oscurece en el congelador.',
      // FR: Étale sur une plaque sans que les quartiers se touchent, congèle 3 heures, puis mets en sac.
      'Extiende en una bandeja sin que los gajos se toquen, congela 3 horas y luego pásalos a una bolsa.',
    ],
  ),
  'pecher/Lamelles de pêches séchées': RecipeText(
    // FR: Lamelles de pêches séchées
    name: 'Láminas de melocotón secas',
    // FR: Séchée, la pêche concentre tout son sucre : un en-cas d'été qui tient dans la poche.
    description: 'Seco, el melocotón concentra todo su azúcar: un tentempié de verano que cabe en el bolsillo.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 meses en tarro, en lugar seco',
    ingredients: <String>[
      '2 kg de melocotones maduros pero firmes', // FR: 2 kg de pêches mûres mais fermes
      '1 litro de agua fría', // FR: 1 litre d'eau froide
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Pèle les pêches après 30 secondes dans l'eau bouillante et un passage à l'eau froide.
      'Pela los melocotones tras 30 segundos en agua hirviendo y un paso por agua fría.',
      // FR: Retire le noyau et coupe des lamelles de **6 mm**, toutes pareilles pour qu'elles sèchent ensemble.
      'Quita el hueso y corta láminas de **6 mm**, todas iguales para que se sequen a la vez.',
      // FR: Trempe-les quelques minutes dans l'eau citronnée, puis éponge-les sur un torchon.
      'Déjalas unos minutos en el agua con limón y sécalas con un paño.',
      // FR: Étale-les sur des grilles et sèche au four à **65 °C**, porte entrouverte, en les retournant à mi-temps.
      'Extiéndelas sobre rejillas y sécalas en el horno a **65 °C**, con la puerta entreabierta, dándoles la vuelta a mitad de tiempo.',
      // FR: Quand elles sont souples comme du cuir et sans jus, laisse refroidir et mets en bocal. Surveille la buée la première semaine.
      'Cuando sean flexibles como el cuero y no suelten jugo, deja enfriar y pasa a un tarro. Vigila el vaho la primera semana.',
    ],
  ),
  'pecher/Pêches au sirop': RecipeText(
    // FR: Pêches au sirop
    name: 'Melocotones en almíbar',
    // FR: Pelées après trente secondes d'eau bouillante, mises en bocal.
    description: 'Pelados tras treinta segundos de agua hirviendo, puestos en tarro.',
  ),
  'pecher/Pêches rôties à la verveine': RecipeText(
    // FR: Pêches rôties à la verveine
    name: 'Melocotones asados con verbena',
    // FR: Au four avec du miel et des feuilles de verveine du jardin.
    description: 'Al horno con miel y hojas de verbena del huerto.',
  ),
  'pecher/Pêche Melba': RecipeText(
    // FR: Pêche Melba
    name: 'Melocotón Melba',
    // FR: Pêche pochée, glace vanille, coulis de framboises.
    description: 'Melocotón escalfado, helado de vainilla y coulis de frambuesa.',
  ),

  // ─────────── pensee (6 recettes) ───────────
  'pensee/Pensées pressées pour les gâteaux': RecipeText(
    // FR: Pensées pressées pour les gâteaux
    name: 'Pensamientos prensados para los pasteles',
    // FR: Séchées à plat dans un livre, elles décorent biscuits et gâteaux toute l'année.
    description: 'Secados planos dentro de un libro, decoran galletas y pasteles todo el año.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegido de la luz',
    ingredients: <String>[
      'una treintena de flores de pensamiento', // FR: une trentaine de fleurs de pensée
      'papel de horno o papel secante', // FR: du papier cuisson ou du papier buvard
      'un libro grande o una prensa de flores', // FR: un gros livre ou une presse à fleurs
      'una caja hermética', // FR: une boîte hermétique
    ],
    steps: <String>[
      // FR: Cueille des fleurs **sans traitement**, bien sèches, en fin de matinée. Coupe la tige au ras de la fleur.
      'Recoge flores **sin tratar**, bien secas, a media mañana. Corta el tallo a ras de la flor.',
      // FR: Pose-les à plat, face visible, entre deux feuilles de papier, sans qu'elles se touchent.
      'Colócalas planas, con la cara visible hacia arriba, entre dos hojas de papel, sin que se toquen.',
      // FR: Glisse le tout dans un gros livre, charge-le, et laisse dix jours au sec. Change le papier au bout de trois jours s'il est humide.
      'Mételo todo en un libro grande, ponle peso y déjalo diez días en seco. Cambia el papel a los tres días si está húmedo.',
      // FR: Décolle-les délicatement à la pointe d'un couteau quand elles sont fines comme du papier.
      'Despégalas con delicadeza con la punta de un cuchillo cuando estén finas como el papel.',
      // FR: Range-les à plat dans la boîte, entre du papier, dans le noir. Pose-les sur un glaçage ou sur des biscuits à peine sortis du four.
      'Guárdalas planas en la caja, entre papel, en la oscuridad. Colócalas sobre un glaseado o sobre galletas recién salidas del horno.',
    ],
  ),
  'pensee/Pensées congelées sur plaque': RecipeText(
    // FR: Pensées congelées sur plaque
    name: 'Pensamientos congelados en bandeja',
    // FR: Un quart d'heure, et des fleurs prêtes à poser sur une glace ou un sorbet en plein hiver.
    description: 'Un cuarto de hora, y flores listas para poner sobre un helado o un sorbete en pleno invierno.',
    // FR: 3 mois au congélateur
    keeps: '3 meses en el congelador',
    ingredients: <String>[
      'una treintena de flores de pensamiento', // FR: une trentaine de fleurs de pensée
      'papel de horno', // FR: du papier cuisson
      'una caja rígida de congelación', // FR: une boîte rigide de congélation
    ],
    steps: <String>[
      // FR: Passe-les rapidement sous un filet d'eau seulement si elles sont sales, et sèche-les en les tamponnant.
      'Pásalas rápidamente bajo un hilo de agua solo si están sucias y sécalas dando toquecitos.',
      // FR: Coupe la tige au ras de la fleur.
      'Corta el tallo a ras de la flor.',
      // FR: Étale-les à plat sur une plaque garnie de papier, sans qu'elles se touchent, et congèle 1 heure.
      'Extiéndelas planas sobre una bandeja forrada con papel, sin que se toquen, y congela 1 hora.',
      // FR: Range-les dans la boîte rigide en couches séparées de papier : elles sont fragiles.
      'Guárdalas en la caja rígida en capas separadas por papel: son frágiles.',
      // FR: Pose-les **encore gelées** sur un dessert glacé ou dans un verre. Décongelées, elles s'affaissent.
      'Colócalas **aún congeladas** sobre un postre helado o en un vaso. Descongeladas, se hunden.',
    ],
  ),
  'pensee/Vinaigre violet aux pensées': RecipeText(
    // FR: Vinaigre violet aux pensées
    name: 'Vinagre violeta de pensamientos',
    // FR: Les pétales teintent le vinaigre d'un violet magnifique et lui donnent une note douce et florale.
    description: 'Los pétalos tiñen el vinagre de un violeta magnífico y le dan una nota suave y floral.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 año en la despensa, protegido de la luz',
    ingredients: <String>[
      '2 buenos puñados de flores de pensamiento oscuras', // FR: 2 bonnes poignées de fleurs de pensée foncées
      '50 cl de vinagre de vino blanco al 6 % como mínimo', // FR: 50 cl de vinaigre de vin blanc à 6 % minimum
      'un tarro limpio', // FR: un bocal propre
    ],
    steps: <String>[
      // FR: Cueille des pensées violettes ou bleu foncé, sans traitement : ce sont elles qui colorent le mieux.
      'Recoge pensamientos violetas o azul oscuro, sin tratar: son los que mejor tiñen.',
      // FR: Retire les tiges et mets les fleurs dans le bocal, sans tasser.
      'Quita los tallos y pon las flores en el tarro, sin apretar.',
      // FR: Couvre de vinaigre pur : les fleurs doivent être **entièrement immergées**.
      'Cubre con vinagre puro: las flores deben quedar **totalmente sumergidas**.',
      // FR: Ferme et laisse infuser deux semaines à l'ombre, en secouant de temps en temps. La couleur arrive en deux jours.
      'Cierra y deja macerar dos semanas a la sombra, agitando de vez en cuando. El color aparece en dos días.',
      // FR: Filtre dans une bouteille propre et garde-la à l'abri de la lumière, qui délave la couleur.
      'Filtra en una botella limpia y guárdala protegida de la luz, que descolora.',
    ],
  ),
  'pensee/Fleurs cristallisées': RecipeText(
    // FR: Fleurs cristallisées
    name: 'Flores cristalizadas',
    // FR: Passées au blanc d'œuf et au sucre, séchées une nuit.
    description: 'Pasadas por clara de huevo y azúcar, secadas una noche.',
  ),
  'pensee/Salade fleurie': RecipeText(
    // FR: Salade fleurie
    name: 'Ensalada con flores',
    // FR: Posées entières au dernier moment sur les feuilles.
    description: 'Puestas enteras en el último momento sobre las hojas.',
  ),
  'pensee/Glaçons fleuris': RecipeText(
    // FR: Glaçons fleuris
    name: 'Cubitos de hielo con flores',
    // FR: Une fleur par alvéole, de l'eau, le congélateur.
    description: 'Una flor por hueco, agua, el congelador.',
  ),

  // ─────────── persil (6 recettes) ───────────
  'persil/Persil haché en glaçons': RecipeText(
    // FR: Persil haché en glaçons
    name: 'Perejil picado en cubitos',
    // FR: Le persil sèche mal mais se congèle très bien : haché une fois, il est prêt pour chaque plat de l'hiver.
    description: 'El perejil se seca mal pero se congela muy bien: picado una vez, está listo para cada plato del invierno.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '4 manojos grandes de perejil', // FR: 4 gros bouquets de persil
      'agua o un chorrito de aceite de oliva', // FR: de l'eau ou un filet d'huile d'olive
      'cubeteras', // FR: des bacs à glaçons
    ],
    steps: <String>[
      // FR: Lave le persil dans une bassine d'eau froide, en le secouant pour faire tomber la terre.
      'Lava el perejil en una palangana de agua fría, agitándolo para que caiga la tierra.',
      // FR: Essore-le à la centrifugeuse et sèche-le dans un torchon : du persil mouillé haché fait de la bouillie.
      'Centrifúgalo y sécalo en un paño: el perejil mojado picado se vuelve papilla.',
      // FR: Effeuille et hache finement au couteau. Garde les tiges pour les bouillons, elles se congèlent aussi.
      'Quita las hojas y pícalas finas con el cuchillo. Guarda los tallos para los caldos, también se congelan.',
      // FR: Tasse le persil dans les bacs et couvre d'un peu d'eau ou d'huile, juste de quoi lier.
      'Apisona el perejil en las cubeteras y cúbrelo con un poco de agua o aceite, justo lo necesario para unirlo.',
      // FR: Congèle jusqu'à ce qu'ils soient durs, puis démoule en sac. Un cube dans la sauce **en fin de cuisson**.
      'Congela hasta que estén duros y desmóldalos en una bolsa. Un cubito en la salsa **al final de la cocción**.',
    ],
  ),
  'persil/Sel au persil': RecipeText(
    // FR: Sel au persil
    name: 'Sal de perejil',
    // FR: Mixé avec du gros sel puis séché, le persil devient un sel vert parfumé pour les pommes de terre et les grillades.
    description: 'Triturado con sal gorda y luego seco, el perejil se convierte en una sal verde aromática para las patatas y las carnes a la plancha.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      '100 g de hojas de perejil', // FR: 100 g de feuilles de persil
      '200 g de sal gorda gris', // FR: 200 g de gros sel gris
      '1 trozo de piel de limón (opcional)', // FR: 1 zeste de citron (facultatif)
      'tarritos herméticos', // FR: des petits bocaux hermétiques
    ],
    steps: <String>[
      // FR: Lave le persil et **sèche-le parfaitement**, feuille par feuille s'il le faut.
      'Lava el perejil y **sécalo perfectamente**, hoja por hoja si hace falta.',
      // FR: Mixe les feuilles avec le gros sel et le zeste par à-coups, jusqu'à un sable vert et humide.
      'Tritura las hojas con la sal gorda y la piel de limón a golpes, hasta obtener una arena verde y húmeda.',
      // FR: Étale en couche fine sur une plaque couverte de papier et sèche au four à **60 °C**, porte entrouverte.
      'Extiéndelo en una capa fina sobre una bandeja cubierta con papel y sécalo en el horno a **60 °C**, con la puerta entreabierta.',
      // FR: Émiette avec une fourchette toutes les 30 minutes pour casser les grumeaux.
      'Desmigaja con un tenedor cada 30 minutos para deshacer los grumos.',
      // FR: Quand il est sec et sableux, laisse refroidir et mets en petits pots. Mixe-le encore un coup si tu le veux plus fin.
      'Cuando esté seco y arenoso, deja enfriar y pásalo a tarritos. Tritúralo una vez más si lo quieres más fino.',
    ],
  ),
  'persil/Pesto de persil aux noix': RecipeText(
    // FR: Pesto de persil aux noix
    name: 'Pesto de perejil y nueces',
    // FR: Plus vert et plus vif que le basilic, il se congèle en petits pots pour les pâtes, les soupes et les poissons.
    description: 'Más verde y más vivo que la albahaca, se congela en tarritos para la pasta, las sopas y los pescados.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '150 g de hojas de perejil liso', // FR: 150 g de feuilles de persil plat
      '60 g de nueces peladas', // FR: 60 g de cerneaux de noix
      '1 diente de ajo', // FR: 1 gousse d'ail
      '15 cl de aceite de oliva', // FR: 15 cl d'huile d'olive
      'el zumo de medio limón, sal', // FR: le jus d'un demi-citron, sel
    ],
    steps: <String>[
      // FR: Fais griller les noix à sec 3 minutes pour enlever l'amertume de la peau.
      'Tuesta las nueces en seco 3 minutos para quitar el amargor de la piel.',
      // FR: Lave le persil et **sèche-le bien** : l'eau fait tourner un pesto.
      'Lava el perejil y **sécalo bien**: el agua corta un pesto.',
      // FR: Mixe persil, noix, ail et sel par à-coups, en versant l'huile en filet. Ajoute le citron à la fin.
      'Tritura el perejil, las nueces, el ajo y la sal a golpes, añadiendo el aceite en un hilo. Añade el limón al final.',
      // FR: Remplis de petits pots ou un bac à glaçons, et couvre d'un filet d'huile pour qu'il ne noircisse pas.
      'Llena tarritos pequeños o una cubetera y cubre con un chorrito de aceite para que no se ennegrezca.',
      // FR: Congèle aussitôt. Avec son ail cru, il ne se garde **qu'au congélateur** ; décongelé, mange-le dans les 2 jours.
      'Congela enseguida. Con su ajo crudo, **solo se conserva en el congelador**; una vez descongelado, cómetelo en 2 días.',
    ],
  ),
  'persil/Persillade': RecipeText(
    // FR: Persillade
    name: 'Persillade',
    // FR: Ail et persil hachés ensemble, jetés à la fin sur tout et n'importe quoi.
    description: 'Ajo y perejil picados juntos, que se echan al final sobre todo lo que se te ocurra.',
    ingredients: <String>[
      '1 manojo de perejil liso', // FR: 1 bouquet de persil plat
      '2 dientes de ajo', // FR: 2 gousses d'ail
      'sal', // FR: sel
    ],
    steps: <String>[
      // FR: Effeuille le persil, garde-le bien sec.
      'Quita las hojas del perejil y mantenlo bien seco.',
      // FR: Hache l'ail et le persil **ensemble** : les deux parfums se mêlent au couteau.
      'Pica el ajo y el perejil **juntos**: los dos aromas se mezclan con el cuchillo.',
      // FR: Jette-la dans la poêle **hors du feu** ou juste avant de servir. Cuite, elle brunit et amère.
      'Échala en la sartén **fuera del fuego** o justo antes de servir. Cocida, se oscurece y amarga.',
    ],
  ),
  'persil/Salsa verde': RecipeText(
    // FR: Salsa verde
    name: 'Salsa verde',
    // FR: Persil, câpres, anchois, citron : la sauce qui réveille un poisson.
    description: 'Perejil, alcaparras, anchoas, limón: la salsa que despierta un pescado.',
    ingredients: <String>[
      '1 manojo grande de perejil liso', // FR: 1 gros bouquet de persil plat
      '2 cucharadas soperas de alcaparras', // FR: 2 cuillères à soupe de câpres
      '4 filetes de anchoa', // FR: 4 filets d'anchois
      '1 limón', // FR: 1 citron
      '10 cl de aceite de oliva, 1 diente de ajo', // FR: 10 cl d'huile d'olive, 1 gousse d'ail
    ],
    steps: <String>[
      // FR: Hache persil, câpres, anchois et ail au couteau, assez gros.
      'Pica el perejil, las alcaparras, las anchoas y el ajo con el cuchillo, bastante grueso.',
      // FR: Ajoute le zeste et le jus du citron.
      'Añade la ralladura y el zumo del limón.',
      // FR: Détends à l'huile : elle doit napper, pas couler.
      'Suelta con el aceite: debe napar, no correr.',
      // FR: Goûte avant de saler — anchois et câpres salent beaucoup.
      'Prueba antes de salar: las anchoas y las alcaparras salan mucho.',
    ],
  ),
  'persil/Poisson braisé au persil': RecipeText(
    // FR: Poisson braisé au persil
    name: 'Pescado guisado al perejil',
    // FR: Un poisson entier farci d'herbes, braisé avec des tomates.
    description: 'Un pescado entero relleno de hierbas, guisado con tomates.',
    ingredients: <String>[
      '1 pescado entero de 1 kg', // FR: 1 poisson entier de 1 kg
      '1 manojo de perejil', // FR: 1 bouquet de persil
      '3 tomates, 1 cebolla', // FR: 3 tomates, 1 oignon
      '2 dientes de ajo, 1 limón', // FR: 2 gousses d'ail, 1 citron
      'aceite, sal, pimienta, guindilla', // FR: huile, sel, poivre, piment
    ],
    steps: <String>[
      // FR: Hache persil, ail, sel, piment. Entaille le poisson et farcis les entailles.
      'Pica el perejil, el ajo, la sal y la guindilla. Haz cortes en el pescado y rellénalos.',
      // FR: Laisse-le prendre le goût 20 minutes au frais.
      'Déjalo tomar sabor 20 minutos en la nevera.',
      // FR: Saisis-le 3 minutes de chaque côté dans l'huile.
      'Dóralo 3 minutos por cada lado en el aceite.',
      // FR: Ajoute oignon et tomates en morceaux, un verre d'eau, couvre.
      'Añade la cebolla y los tomates en trozos, un vaso de agua y tapa.',
      // FR: Braise 15 minutes à feu moyen.
      'Guisa 15 minutos a fuego medio.',
      // FR: Citron pressé dessus au moment de servir.
      'Exprime el limón por encima en el momento de servir.',
    ],
  ),

  // ─────────── petit_pois (6 recettes) ───────────
  'petit_pois/Petits pois blanchis en sachets': RecipeText(
    // FR: Petits pois blanchis en sachets
    name: 'Guisantes blanqueados en bolsitas',
    // FR: Deux minutes dans l'eau bouillante le jour de la cueillette, et ils restent sucrés jusqu'à Noël.
    description: 'Dos minutos en agua hirviendo el mismo día de la cosecha, y se mantienen dulces hasta Navidad.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de guisantes en vaina (unos 800 g desgranados)', // FR: 2 kg de petits pois en cosses (environ 800 g écossés)
      'un recipiente grande de agua y cubitos de hielo', // FR: un grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Écosse les pois **le jour même** de la cueillette : leur sucre se transforme en amidon en quelques heures.
      'Desgrana los guisantes **el mismo día** de la cosecha: su azúcar se transforma en almidón en pocas horas.',
      // FR: Plonge-les dans une grande casserole d'eau bouillante non salée, **2 minutes**.
      'Sumérgelos en una cazuela grande de agua hirviendo sin sal, **2 minutos**.',
      // FR: Verse-les aussitôt dans l'eau glacée, puis égoutte-les.
      'Pásalos enseguida al agua con hielo y escúrrelos.',
      // FR: Étale-les sur un torchon et tamponne-les pour les sécher.
      'Extiéndelos sobre un paño y sécalos dando toquecitos.',
      // FR: Congèle-les étalés sur une plaque, puis verse en sacs : ils restent détachés et tu prends juste la dose.
      'Congélalos extendidos sobre una bandeja y luego pásalos a bolsas: quedan sueltos y coges justo la cantidad que necesitas.',
    ],
  ),
  'petit_pois/Purée de petits pois à la menthe': RecipeText(
    // FR: Purée de petits pois à la menthe
    name: 'Puré de guisantes con menta',
    // FR: Pour les pois un peu trop gros et farineux : en purée congelée, ils font un accompagnement prêt en cinq minutes.
    description: 'Para los guisantes un poco grandes y harinosos: en puré congelado, son una guarnición lista en cinco minutos.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 kg de guisantes desgranados', // FR: 1 kg de petits pois écossés
      '1 cebolla', // FR: 1 oignon
      '30 g de mantequilla', // FR: 30 g de beurre
      '10 hojas de menta', // FR: 10 feuilles de menthe
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Fais fondre l'oignon émincé dans le beurre, sans coloration.
      'Rehoga la cebolla en láminas finas en la mantequilla, sin que tome color.',
      // FR: Ajoute les pois, couvre à peine d'eau, sale et laisse cuire jusqu'à ce qu'ils s'écrasent sous le doigt.
      'Añade los guisantes, cubre apenas con agua, sala y deja cocer hasta que se aplasten con el dedo.',
      // FR: Jette la menthe hors du feu, une minute, pas plus.
      'Echa la menta fuera del fuego, un minuto, no más.',
      // FR: Mixe avec un peu d'eau de cuisson, jusqu'à une purée lisse. Poivre et goûte.
      'Tritura con un poco de agua de cocción hasta obtener un puré fino. Pon pimienta y prueba.',
      // FR: Refroidis vite la purée dans un plat posé sur de l'eau glacée : le vert reste vif.
      'Enfría rápido el puré en una fuente puesta sobre agua con hielo: el verde se mantiene vivo.',
      // FR: Répartis en boîtes d'une portion, à 2 cm du bord, et congèle.
      'Reparte en cajas de una porción, a 2 cm del borde, y congela.',
    ],
  ),
  'petit_pois/Pois secs de garde': RecipeText(
    // FR: Pois secs de garde
    name: 'Guisantes secos para guardar',
    // FR: Laisse les dernières cosses sécher : les pois durs se gardent des années et finissent en soupe de pois cassés.
    description: 'Deja secar las últimas vainas: los guisantes duros se guardan años y acaban en sopa de guisantes secos.',
    // FR: 2 ans au sec, à l'abri de la lumière
    keeps: '2 años en seco, protegido de la luz',
    ingredients: <String>[
      'las vainas de final de temporada, dejadas en la planta', // FR: les cosses de fin de saison, laissées sur pied
      'tarros bien secos', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Laisse les dernières cosses sur les pieds jusqu'à ce qu'elles soient **beiges et parcheminées**.
      'Deja las últimas vainas en las plantas hasta que estén **beis y acartonadas**.',
      // FR: Cueille-les par temps sec et écosse-les. Jette les pois tachés ou percés.
      'Recógelas en tiempo seco y desgrana. Tira los guisantes manchados o picados.',
      // FR: Étale les pois sur un plateau à l'abri, à l'air, et laisse-les finir de sécher 2 semaines.
      'Extiende los guisantes en una bandeja a cubierto, al aire, y déjalos terminar de secar 2 semanas.',
      // FR: Teste : un pois prêt ne marque plus sous l'ongle et casse net sous un coup de marteau.
      'Comprueba: un guisante listo ya no se marca con la uña y se parte limpio de un martillazo.',
      // FR: Passe-les 48 heures au congélateur : ça tue les œufs de bruches qui pourraient éclore dans le bocal.
      'Pásalos 48 horas por el congelador: así matas los huevos de gorgojo que podrían eclosionar en el tarro.',
      // FR: Mets en bocaux bien fermés. Avant de les manger, fais-les tremper une nuit puis cuire environ 1 heure.
      'Pon en tarros bien cerrados. Antes de comerlos, déjalos en remojo una noche y luego cuécelos aproximadamente 1 hora.',
    ],
  ),
  'petit_pois/Petits pois à la française': RecipeText(
    // FR: Petits pois à la française
    name: 'Guisantes a la francesa',
    // FR: Avec laitue, oignons nouveaux et beurre — la recette qui ne change pas.
    description: 'Con lechuga, cebolletas y mantequilla: la receta que no cambia.',
    ingredients: <String>[
      '1 kg de guisantes desgranados', // FR: 1 kg de petits pois écossés
      '1 cogollo de lechuga', // FR: 1 coeur de laitue
      '8 cebolletas', // FR: 8 oignons nouveaux
      '40 g de mantequilla', // FR: 40 g de beurre
      '1 cucharadita de azúcar, sal', // FR: 1 cuillère à café de sucre, sel
    ],
    steps: <String>[
      // FR: Écosse les pois : compte 1 kg en gousses pour 400 g.
      'Desgrana los guisantes: cuenta 1 kg en vainas por 400 g.',
      // FR: Coupe la laitue en lanières, les oignons en deux.
      'Corta la lechuga en tiras y las cebolletas por la mitad.',
      // FR: Dans la cocotte : pois, laitue, oignons, beurre, sucre, sel et 10 cl d'eau.
      'En la cazuela: guisantes, lechuga, cebolletas, mantequilla, azúcar, sal y 10 cl de agua.',
      // FR: Couvre et laisse 20 minutes à feu doux, sans remuer.
      'Tapa y deja 20 minutos a fuego suave, sin remover.',
      // FR: Il ne doit presque plus rester d'eau : juste un jus beurré.
      'Casi no debe quedar agua: solo un jugo con mantequilla.',
    ],
  ),
  'petit_pois/Velouté de petits pois à la menthe': RecipeText(
    // FR: Velouté de petits pois à la menthe
    name: 'Crema de guisantes con menta',
    // FR: Un vert éclatant, à condition de ne pas trop cuire.
    description: 'Un verde brillante, siempre que no se cuezan demasiado.',
    ingredients: <String>[
      '800 g de guisantes', // FR: 800 g de petits pois
      '1 cebolla', // FR: 1 oignon
      '70 cl de caldo', // FR: 70 cl de bouillon
      'unas diez hojas de menta', // FR: une dizaine de feuilles de menthe
      '10 cl de nata, sal, pimienta', // FR: 10 cl de crème, sel, poivre
    ],
    steps: <String>[
      // FR: Fais fondre l'oignon émincé sans le colorer.
      'Rehoga la cebolla en láminas sin que tome color.',
      // FR: Ajoute les pois et le bouillon chaud.
      'Añade los guisantes y el caldo caliente.',
      // FR: 8 minutes seulement : au-delà, le vert tourne au kaki.
      'Solo 8 minutos: más allá, el verde se vuelve caqui.',
      // FR: Mixe avec la menthe, hors du feu.
      'Tritura con la menta, fuera del fuego.',
      // FR: Crème, sel, poivre. Bon chaud ou glacé.
      'Nata, sal, pimienta. Buena caliente o fría.',
    ],
  ),
  'petit_pois/Petits pois carottes': RecipeText(
    // FR: Petits pois carottes
    name: 'Guisantes con zanahorias',
    // FR: Le duo de l'enfance, en frais ça n'a rien à voir avec la conserve.
    description: 'El dúo de la infancia, y en fresco no tiene nada que ver con el de lata.',
    ingredients: <String>[
      '600 g de guisantes', // FR: 600 g de petits pois
      '4 zanahorias', // FR: 4 carottes
      '1 cebolla', // FR: 1 oignon
      '30 g de mantequilla', // FR: 30 g de beurre
      'sal, pimienta, perejil', // FR: sel, poivre, persil
    ],
    steps: <String>[
      // FR: Coupe les carottes en rondelles fines.
      'Corta las zanahorias en rodajas finas.',
      // FR: Fais-les suer au beurre avec l'oignon, 10 minutes.
      'Sofríelas en la mantequilla con la cebolla, 10 minutos.',
      // FR: Ajoute les pois et un fond d'eau, sale.
      'Añade los guisantes y un chorrito de agua, sala.',
      // FR: Couvre et cuis 15 minutes.
      'Tapa y cuece 15 minutos.',
      // FR: Persil, poivre, une noisette de beurre à la fin.
      'Perejil, pimienta y una nuez de mantequilla al final.',
    ],
  ),

  // ─────────── piment (6 recettes) ───────────
  'piment/Piments séchés en guirlande': RecipeText(
    // FR: Piments séchés en guirlande
    name: 'Guindillas secas en ristra',
    // FR: Enfilés et suspendus, les piments sèchent tout seuls et décorent la cuisine jusqu'à la récolte suivante.
    description: 'Ensartadas y colgadas, las guindillas se secan solas y decoran la cocina hasta la cosecha siguiente.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      'guindillas bien maduras, de carne fina', // FR: des piments bien mûrs, à chair fine
      'una aguja gruesa e hilo resistente', // FR: une grosse aiguille et du fil solide
      'guantes', // FR: des gants
    ],
    steps: <String>[
      // FR: Essuie les piments sans les laver : mouillés, ils moisissent au lieu de sécher.
      'Limpia las guindillas con un paño sin lavarlas: mojadas, se enmohecen en vez de secarse.',
      // FR: Mets des gants. Écarte ceux qui ont une tache molle, ils pourriraient la guirlande.
      'Ponte guantes. Aparta las que tengan una mancha blanda, pudrirían la ristra.',
      // FR: Enfile-les par le pédoncule, avec l'aiguille, en les décalant pour qu'ils ne se touchent pas.
      'Ensártalas por el pedúnculo con la aguja, desplazándolas para que no se toquen.',
      // FR: Suspends au sec, au chaud et aéré, 3 à 4 semaines. Les piments charnus sèchent mieux au four à 50 °C.
      'Cuelga en un lugar seco, cálido y ventilado, de 3 a 4 semanas. Las guindillas carnosas se secan mejor en el horno a 50 °C.',
      // FR: Ils sont secs quand ils sont cassants et sonnent creux en les secouant.
      'Están secas cuando son quebradizas y suenan huecas al agitarlas.',
      // FR: Laisse-les suspendus ou mets-les en bocal. Émiette-les ou mouds-les au moment de cuisiner.
      'Déjalas colgadas o ponlas en un tarro. Desmenúzalas o muélelas en el momento de cocinar.',
    ],
  ),
  'piment/Piments fermentés en saumure': RecipeText(
    // FR: Piments fermentés en saumure
    name: 'Guindillas fermentadas en salmuera',
    // FR: La fermentation arrondit le feu et ajoute un goût acidulé : la base de toutes tes sauces piquantes.
    description: 'La fermentación redondea el picante y añade un sabor ácido: la base de todas tus salsas picantes.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 meses en la nevera',
    ingredients: <String>[
      '500 g de guindillas', // FR: 500 g de piments
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      'un tarro de 1 litro con un peso', // FR: un bocal de 1 litre avec un poids
    ],
    steps: <String>[
      // FR: Mets des gants. Retire les pédoncules et coupe les piments en deux dans la longueur.
      'Ponte guantes. Quita los pedúnculos y corta las guindillas por la mitad a lo largo.',
      // FR: Dissous **30 g de sel dans 1 litre d'eau** : c'est la saumure à 3 %.
      'Disuelve **30 g de sal en 1 litro de agua**: es la salmuera al 3 %.',
      // FR: Tasse les piments et l'ail pelé dans un bocal ébouillanté, jusqu'à 3 cm du bord.
      'Apisona las guindillas y el ajo pelado en un tarro escaldado, hasta 3 cm del borde.',
      // FR: Verse la saumure et pose un poids pour **garder tous les piments sous le liquide**. Ce qui dépasse moisit.
      'Vierte la salmuera y pon un peso para **mantener todas las guindillas bajo el líquido**. Lo que sobresalga se enmohece.',
      // FR: Ferme sans serrer et laisse à 18–22 °C, à l'ombre, 2 semaines. Ouvre le couvercle chaque jour pour laisser sortir le gaz.
      'Cierra sin apretar y deja a 18–22 °C, a la sombra, 2 semanas. Abre la tapa cada día para dejar salir el gas.',
      // FR: Quand la saumure est trouble et que ça sent acidulé, c'est prêt. Une mousse blanche se retire, une moisissure colorée et duveteuse veut dire qu'on jette tout.
      'Cuando la salmuera esté turbia y huela a ácido, está lista. Una espuma blanca se retira; un moho de color y velloso significa que hay que tirarlo todo.',
      // FR: Ferme et range au réfrigérateur. Mixe avec un peu de saumure pour en faire une pâte.
      'Cierra y guarda en la nevera. Tritura con un poco de salmuera para hacer una pasta.',
    ],
  ),
  'piment/Piments entiers congelés': RecipeText(
    // FR: Piments entiers congelés
    name: 'Guindillas enteras congeladas',
    // FR: Dix minutes, et tu as des piments frais toute l'année, à couper encore gelés.
    description: 'Diez minutos, y tienes guindillas frescas todo el año, para cortar aún congeladas.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      'guindillas frescas y firmes', // FR: des piments frais et fermes
      'bolsas de congelación', // FR: des sacs de congélation
      'guantes', // FR: des gants
    ],
    steps: <String>[
      // FR: Lave les piments et **sèche-les parfaitement**.
      'Lava las guindillas y **sécalas perfectamente**.',
      // FR: Laisse-les entiers avec leur pédoncule, ou coupe-les en rondelles avec des gants.
      'Déjalas enteras con su pedúnculo, o córtalas en rodajas con guantes.',
      // FR: Mets-les en sac en chassant l'air, et congèle.
      'Ponlas en una bolsa sacando el aire y congela.',
      // FR: Coupe-les encore gelés : ils se tranchent facilement et brûlent moins les doigts. Mous à la décongélation, ils vont dans les plats cuits.
      'Córtalas aún congeladas: se rebanan fácilmente y queman menos los dedos. Blandas al descongelar, van a los platos cocinados.',
    ],
  ),
  'piment/Sauce piquante maison': RecipeText(
    // FR: Sauce piquante maison
    name: 'Salsa picante casera',
    // FR: Piments mixés avec ail, sel et vinaigre, fermentés une semaine.
    description: 'Guindillas trituradas con ajo, sal y vinagre, fermentadas una semana.',
  ),
  'piment/Huile pimentée': RecipeText(
    // FR: Huile pimentée
    name: 'Aceite picante',
    // FR: Piments séchés dans l'huile chaude, jamais bouillante.
    description: 'Guindillas secas en aceite caliente, nunca hirviendo.',
  ),
  'piment/Sauce pili-pili': RecipeText(
    // FR: Sauce pili-pili
    name: 'Salsa pili-pili',
    // FR: La petite sauce piquante maison qui accompagne absolument tout, avec modération !
    description: 'La salsa picante casera que acompaña absolutamente todo, ¡con moderación!',
  ),

  // ─────────── pleurote (6 recettes) ───────────
  'pleurote/Pleurotes séchées': RecipeText(
    // FR: Pleurotes séchées
    name: 'Setas de ostra secas',
    // FR: Fines et peu charnues, elles sèchent vite et gagnent un goût de sous-bois très concentré.
    description: 'Finas y poco carnosas, se secan rápido y ganan un sabor a sotobosque muy concentrado.',
    // FR: 1 an au sec, en bocal hermétique
    keeps: '1 año en seco, en tarro hermético',
    ingredients: <String>[
      '1 kg de setas de ostra', // FR: 1 kg de pleurotes
      'rejillas o bandejas', // FR: des grilles ou plaques
      'tarros bien secos', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Coupe la base dure de la grappe et sépare les pleurotes. Essuie-les sans les mouiller.
      'Corta la base dura del racimo y separa las setas. Límpialas con un paño sin mojarlas.',
      // FR: Déchire les plus grandes en lanières dans le sens des lamelles.
      'Rasga las más grandes en tiras en el sentido de las láminas.',
      // FR: Étale-les en une couche sur des grilles et sèche à 50 °C, porte entrouverte, ou au déshydrateur.
      'Extiéndelas en una sola capa sobre rejillas y sécalas a 50 °C, con la puerta entreabierta, o en el deshidratador.',
      // FR: Elles sont prêtes quand elles se cassent net entre les doigts.
      'Están listas cuando se parten limpias entre los dedos.',
      // FR: Laisse refroidir et mets en bocaux hermétiques. Réhydrate-les 15 minutes dans l'eau tiède avant de les poêler.
      'Deja enfriar y pasa a tarros herméticos. Rehidrátalas 15 minutos en agua tibia antes de saltearlas.',
    ],
  ),
  'pleurote/Pleurotes revenues au congélateur': RecipeText(
    // FR: Pleurotes revenues au congélateur
    name: 'Setas de ostra salteadas para el congelador',
    // FR: Saisies à sec puis au beurre, elles gardent leur texture moelleuse et filent tout droit dans une sauce ou une omelette.
    description: 'Salteadas primero en seco y luego con mantequilla, conservan su textura tierna y van directas a una salsa o a una tortilla.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de setas de ostra', // FR: 1,5 kg de pleurotes
      '30 g de mantequilla', // FR: 30 g de beurre
      '1 chalota', // FR: 1 échalote
      'sal', // FR: sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe la base de la grappe, sépare et déchire les pleurotes en lanières. **Pas d'eau** : essuie-les simplement.
      'Corta la base del racimo, separa y rasga las setas en tiras. **Nada de agua**: límpialas simplemente con un paño.',
      // FR: Fais-les d'abord sauter **à sec** dans une grande poêle chaude, jusqu'à ce que leur eau soit évaporée.
      'Saltéalas primero **en seco** en una sartén grande bien caliente, hasta que se evapore su agua.',
      // FR: Ajoute le beurre et l'échalote émincée, et fais dorer 4 minutes.
      'Añade la mantequilla y la chalota en láminas finas, y dora 4 minutos.',
      // FR: Sale en fin de cuisson.
      'Sala al final de la cocción.',
      // FR: Étale-les sur une plaque pour qu'elles refroidissent vite.
      'Extiéndelas en una bandeja para que se enfríen rápido.',
      // FR: Mets en sacs d'une portion, à plat, et date.
      'Pon en bolsas de una porción, planas, y ponles fecha.',
    ],
  ),
  'pleurote/Pickles de pleurotes à l\'ail': RecipeText(
    // FR: Pickles de pleurotes à l'ail
    name: 'Encurtido de setas de ostra con ajo',
    // FR: Blanchies au vinaigre et à l'ail, elles se servent froides, comme des champignons à la grecque.
    description: 'Escaldadas en vinagre y ajo, se sirven frías, como setas a la griega.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      '800 g de setas de ostra', // FR: 800 g de pleurotes
      '40 cl de vinagre blanco al 8 %', // FR: 40 cl de vinaigre blanc à 8 %
      '40 cl de agua', // FR: 40 cl d'eau
      '15 g de sal, 10 g de azúcar', // FR: 15 g de sel, 10 g de sucre
      '3 dientes de ajo, 1 cucharadita de semillas de cilantro', // FR: 3 gousses d'ail, 1 cuillère à café de graines de coriandre
    ],
    steps: <String>[
      // FR: Sépare les pleurotes et déchire les grandes en lanières. Essuie-les sans les laver.
      'Separa las setas y rasga las grandes en tiras. Límpialas sin lavarlas.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sel et le sucre avec l'ail en lamelles et la coriandre.
      'Lleva a ebullición el vinagre, el agua, la sal y el azúcar con el ajo en láminas y el cilantro.',
      // FR: Plonge les pleurotes dans le liquide et laisse frémir **5 minutes**.
      'Sumerge las setas en el líquido y deja hervir suavemente **5 minutos**.',
      // FR: Répartis-les dans deux bocaux ébouillantés avec l'ail et les graines.
      'Repártelas en dos tarros escaldados con el ajo y las semillas.',
      // FR: Verse le liquide bouillant pour **couvrir entièrement**, ferme et laisse refroidir.
      'Vierte el líquido hirviendo para **cubrir por completo**, cierra y deja enfriar.',
      // FR: Range au réfrigérateur et attends 2 jours avant d'ouvrir.
      'Guarda en la nevera y espera 2 días antes de abrir.',
    ],
  ),
  'pleurote/Pleurotes poêlées à l\'ail': RecipeText(
    // FR: Pleurotes poêlées à l'ail
    name: 'Setas de ostra salteadas con ajo',
    // FR: Déchirées à la main, saisies sans les tasser.
    description: 'Rasgadas a mano, doradas sin apretarlas.',
  ),
  'pleurote/Pleurotes panées façon escalope': RecipeText(
    // FR: Pleurotes panées façon escalope
    name: 'Setas de ostra empanadas estilo escalope',
    // FR: Leur texture fibreuse s'y prête remarquablement.
    description: 'Su textura fibrosa se presta de maravilla.',
  ),
  'pleurote/Fricassée de pleurotes à la crème': RecipeText(
    // FR: Fricassée de pleurotes à la crème
    name: 'Fricasé de setas de ostra a la nata',
    // FR: Avec de l'estragon et un trait de vin blanc.
    description: 'Con estragón y un chorrito de vino blanco.',
  ),

  // ─────────── poireau (6 recettes) ───────────
  'poireau/Poireaux émincés congelés crus': RecipeText(
    // FR: Poireaux émincés congelés crus
    name: 'Puerros en rodajas congelados crudos',
    // FR: Le poireau est un des rares légumes qui se congèlent crus : un quart d'heure et tes soupes d'hiver sont lancées.
    description: 'El puerro es una de las pocas hortalizas que se congelan crudas: un cuarto de hora y tus sopas de invierno están en marcha.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '2 kg de puerros', // FR: 2 kg de poireaux
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe la racine et le vert trop dur, puis fends chaque poireau en deux dans la longueur.
      'Corta la raíz y la parte verde demasiado dura, y abre cada puerro por la mitad a lo largo.',
      // FR: Rince-les sous l'eau en écartant les feuilles : la terre se cache **entre les couches**, tout près du blanc.
      'Acláralos bajo el agua separando las hojas: la tierra se esconde **entre las capas**, muy cerca de lo blanco.',
      // FR: Émince-les en rondelles d'un demi-centimètre, blanc et vert tendre ensemble.
      'Córtalos en rodajas de medio centímetro, lo blanco y lo verde tierno juntos.',
      // FR: Égoutte-les et sèche-les bien dans un torchon. L'eau qui reste fait des blocs de glace.
      'Escúrrelos y sécalos bien en un paño. El agua que queda forma bloques de hielo.',
      // FR: Mets-les en sacs à plat, chasse l'air et note la date. Tu les jetteras **sans décongeler** dans la poêle ou la soupe.
      'Ponlos en bolsas planas, saca el aire y anota la fecha. Los echarás **sin descongelar** en la sartén o en la sopa.',
    ],
  ),
  'poireau/Tronçons de poireaux blanchis': RecipeText(
    // FR: Tronçons de poireaux blanchis
    name: 'Trozos de puerro blanqueados',
    // FR: Blanchis deux minutes, les blancs gardent leur tenue pour un gratin ou des poireaux à la crème en plein hiver.
    description: 'Blanqueados dos minutos, las partes blancas aguantan para un gratinado o unos puerros a la crema en pleno invierno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de partes blancas de puerro', // FR: 2 kg de blancs de poireaux
      'sal gorda', // FR: gros sel
      'un recipiente grande de agua y cubitos de hielo', // FR: un grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Garde le blanc et le vert clair, coupe-les en tronçons de 5 cm.
      'Conserva lo blanco y lo verde claro, y córtalos en trozos de 5 cm.',
      // FR: Rince chaque tronçon en écartant un peu les feuilles pour chasser la terre.
      'Aclara cada trozo separando un poco las hojas para sacar la tierra.',
      // FR: Plonge-les dans une grande eau salée à gros bouillons, **2 minutes** chrono.
      'Sumérgelos en abundante agua con sal a borbotones, **2 minutos** exactos.',
      // FR: Transfère-les aussitôt dans l'eau glacée pour stopper la cuisson et garder le vert.
      'Pásalos enseguida al agua con hielo para parar la cocción y conservar el verde.',
      // FR: Égoutte-les debout dans une passoire, puis presse-les doucement dans un torchon.
      'Escúrrelos de pie en un colador y luego presiónalos suavemente en un paño.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent, congèle 2 heures, puis passe-les en sac.
      'Extiéndelos en una bandeja sin que se toquen, congela 2 horas y luego pásalos a una bolsa.',
    ],
  ),
  'poireau/Rondelles de poireaux séchées': RecipeText(
    // FR: Rondelles de poireaux séchées
    name: 'Rodajas de puerro secas',
    // FR: Séchées au four doux, elles tiennent dans un bocal et parfument une soupe en trois minutes de cuisson.
    description: 'Secas en horno suave, caben en un tarro y perfuman una sopa con tres minutos de cocción.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      '1,5 kg de puerros', // FR: 1,5 kg de poireaux
      'papel de horno', // FR: du papier cuisson
      'tarros bien secos', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Fends les poireaux en deux et rince-les à fond entre les feuilles.
      'Abre los puerros por la mitad y acláralos a fondo entre las hojas.',
      // FR: Émince-les finement, 3 mm environ : plus c'est fin, plus ça sèche vite et régulièrement.
      'Córtalos finos, unos 3 mm: cuanto más finos, más rápido y más uniforme se secan.',
      // FR: Sèche les rondelles dans un torchon, puis étale-les en couche fine sur les plaques.
      'Seca las rodajas en un paño y extiéndelas en una capa fina sobre las bandejas.',
      // FR: Enfourne à **60 °C**, porte entrouverte avec une cuillère en bois pour que l'humidité s'échappe.
      'Hornea a **60 °C**, con la puerta entreabierta con una cuchara de madera para que escape la humedad.',
      // FR: Remue toutes les heures. C'est prêt quand les rondelles **cassent net** et ne plient plus.
      'Remueve cada hora. Están listas cuando las rodajas **se parten limpias** y ya no se doblan.',
      // FR: Laisse refroidir complètement avant de mettre en bocal : tiède, ça condense et ça moisit.
      'Deja enfriar por completo antes de ponerlas en el tarro: tibias, condensan y se enmohecen.',
    ],
  ),
  'poireau/Poireaux vinaigrette': RecipeText(
    // FR: Poireaux vinaigrette
    name: 'Puerros con vinagreta',
    // FR: Tièdes, bien égouttés, avec une vinaigrette à l'échalote.
    description: 'Tibios, bien escurridos, con una vinagreta de chalota.',
    ingredients: <String>[
      '8 puerros medianos', // FR: 8 poireaux moyens
      '1 chalota', // FR: 1 échalote
      '1 cucharadita de mostaza', // FR: 1 cuillère à café de moutarde
      '1 cucharada sopera de vinagre', // FR: 1 cuillère à soupe de vinaigre
      '3 cucharadas soperas de aceite, sal, pimienta', // FR: 3 cuillères à soupe d'huile, sel, poivre
    ],
    steps: <String>[
      // FR: Fends le blanc en deux dans la longueur et rince : la terre se cache entre les feuilles.
      'Abre lo blanco por la mitad a lo largo y aclara: la tierra se esconde entre las hojas.',
      // FR: Cuis 15 minutes à l'eau bouillante salée, jusqu'à ce qu'un couteau traverse sans effort.
      'Cuece 15 minutos en agua hirviendo con sal, hasta que un cuchillo los atraviese sin esfuerzo.',
      // FR: Égoutte-les **debout** dans une passoire, 10 minutes : c'est ce qui évite l'assiette noyée.
      'Escúrrelos **de pie** en un colador, 10 minutos: así evitas el plato inundado.',
      // FR: Vinaigrette : échalote hachée, moutarde, vinaigre, puis l'huile en filet.
      'Vinagreta: chalota picada, mostaza, vinagre y luego el aceite en un hilo.',
      // FR: Nappe les poireaux encore tièdes.
      'Napa los puerros aún tibios.',
    ],
  ),
  'poireau/Flamiche aux poireaux': RecipeText(
    // FR: Flamiche aux poireaux
    name: 'Flamiche de puerros',
    // FR: La tarte du Nord : des poireaux fondus à la crème, sous une pâte.
    description: 'La tarta del Norte de Francia: puerros fundentes a la nata, bajo una masa.',
    ingredients: <String>[
      '1 masa quebrada', // FR: 1 pâte brisée
      '1 kg de puerros', // FR: 1 kg de poireaux
      '20 cl de nata', // FR: 20 cl de crème
      '2 huevos', // FR: 2 oeufs
      '40 g de mantequilla, sal, pimienta, nuez moscada', // FR: 40 g de beurre, sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Émince les blancs de poireaux en fines rondelles.
      'Corta las partes blancas de los puerros en rodajas finas.',
      // FR: Fais-les fondre au beurre à couvert, 25 minutes, sans les colorer.
      'Déjalas ablandar en la mantequilla tapadas, 25 minutos, sin que tomen color.',
      // FR: Laisse-les tiédir et égoutte l'eau rendue, sinon la tarte sera molle.
      'Déjalas templar y escurre el agua que hayan soltado, o la tarta quedará blanda.',
      // FR: Mélange crème, oeufs, sel, poivre, muscade.
      'Mezcla la nata, los huevos, la sal, la pimienta y la nuez moscada.',
      // FR: Garnis la pâte des poireaux, verse l'appareil.
      'Rellena la masa con los puerros y vierte la mezcla.',
      // FR: Four à 190 °C, 35 minutes.
      'Horno a 190 °C, 35 minutos.',
    ],
  ),
  'poireau/Fondue de poireaux': RecipeText(
    // FR: Fondue de poireaux
    name: 'Fondue de puerros',
    // FR: La base qui accompagne un poisson, garnit une quiche ou se mange seule.
    description: 'La base que acompaña un pescado, rellena una quiche o se come sola.',
    ingredients: <String>[
      '6 puerros', // FR: 6 poireaux
      '30 g de mantequilla', // FR: 30 g de beurre
      '10 cl de nata', // FR: 10 cl de crème
      'sal, pimienta', // FR: sel, poivre
    ],
    steps: <String>[
      // FR: Émince les blancs finement, rince, égoutte.
      'Corta lo blanco fino, aclara, escurre.',
      // FR: Beurre dans la sauteuse, les poireaux, une pincée de sel, couvercle.
      'Mantequilla en la sartén honda, los puerros, una pizca de sal, tapa.',
      // FR: Feu très doux 25 minutes. Ils doivent fondre, jamais roussir.
      'Fuego muy suave 25 minutos. Deben deshacerse, nunca dorarse.',
      // FR: Crème hors du feu, poivre, et c'est prêt.
      'Nata fuera del fuego, pimienta, y ya está.',
    ],
  ),

  // ─────────── poirier (6 recettes) ───────────
  'poirier/Demi-poires au sirop léger': RecipeText(
    // FR: Demi-poires au sirop léger
    name: 'Mitades de pera en almíbar ligero',
    // FR: Les poires mûrissent toutes la même semaine : en bocaux, elles attendent sagement jusqu'en hiver.
    description: 'Las peras maduran todas la misma semana: en tarros, esperan pacientes hasta el invierno.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 año en la despensa, 5 días abierto en la nevera',
    ingredients: <String>[
      '3 kg de peras firmes, apenas maduras', // FR: 3 kg de poires fermes, à peine mûres
      '1,5 litros de agua', // FR: 1,5 litre d'eau
      '400 g de azúcar', // FR: 400 g de sucre
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      '1 vaina de vainilla (opcional)', // FR: 1 gousse de vanille (facultatif)
      '4 tarros de un litro con juntas nuevas', // FR: 4 bocaux d'un litre avec joints neufs
    ],
    steps: <String>[
      // FR: Porte l'eau, le sucre et la vanille fendue à ébullition 2 minutes, puis ajoute le jus d'un citron : il garde les poires claires et assure l'acidité.
      'Lleva el agua, el azúcar y la vainilla abierta a ebullición 2 minutos y añade el zumo de un limón: mantiene las peras claras y aporta la acidez.',
      // FR: Épluche les poires, coupe-les en deux, retire le cœur à la cuillère et plonge-les dans de l'eau additionnée du second citron.
      'Pela las peras, córtalas por la mitad, quita el corazón con una cuchara y sumérgelas en agua con el zumo del segundo limón.',
      // FR: Range les demi-poires serrées dans les bocaux et couvre de sirop chaud **jusqu'à 2 cm du bord**. Ferme avec des joints neufs.
      'Coloca las mitades apretadas en los tarros y cubre con almíbar caliente **hasta 2 cm del borde**. Cierra con juntas nuevas.',
      // FR: Stérilise les bocaux **couverts d'eau**, 30 minutes à partir de l'ébullition pour des bocaux d'un litre.
      'Esteriliza los tarros **cubiertos de agua**, 30 minutos desde que hierva para tarros de un litro.',
      // FR: Laisse refroidir dans l'eau, puis vérifie le vide. Un bocal qui n'a pas pris va au frais et se mange dans la semaine.
      'Deja enfriar en el agua y comprueba el vacío. Un tarro que no haya hecho vacío va a la nevera y se come en la semana.',
    ],
  ),
  'poirier/Lamelles de poires séchées': RecipeText(
    // FR: Lamelles de poires séchées
    name: 'Láminas de pera secas',
    // FR: Séchée, la poire devient un bonbon : douce, souple, parfaite dans un muesli ou à côté d'un fromage.
    description: 'Seca, la pera se vuelve un caramelo: dulce, flexible, perfecta en un muesli o junto a un queso.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 meses en tarro, en lugar seco',
    ingredients: <String>[
      '2 kg de peras maduras pero firmes', // FR: 2 kg de poires mûres mais fermes
      '1 litro de agua fría', // FR: 1 litre d'eau froide
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Épluche les poires, retire le cœur et coupe-les en lamelles de **6 mm** dans la hauteur.
      'Pela las peras, quita el corazón y córtalas en láminas de **6 mm** a lo largo.',
      // FR: Trempe les lamelles quelques minutes dans l'eau citronnée pour qu'elles ne noircissent pas.
      'Deja las láminas unos minutos en el agua con limón para que no se ennegrezcan.',
      // FR: Égoutte et éponge-les sur un torchon : la poire est juteuse, plus elle part sèche, plus vite elle sèche.
      'Escúrrelas y sécalas con un paño: la pera es jugosa, cuanto más seca empiece, más rápido se seca.',
      // FR: Étale-les sur des grilles et sèche au four à **65 °C**, porte entrouverte, en les retournant à mi-temps.
      'Extiéndelas sobre rejillas y sécalas en el horno a **65 °C**, con la puerta entreabierta, dándoles la vuelta a mitad de tiempo.',
      // FR: Teste une lamelle refroidie : elle doit plier sans casser et sans laisser de jus.
      'Prueba una lámina ya fría: debe doblarse sin romperse y sin soltar jugo.',
      // FR: Mets en bocal et surveille la buée la première semaine. S'il y en a, remets au four une heure.
      'Pasa a un tarro y vigila el vaho la primera semana. Si lo hay, vuelven al horno una hora.',
    ],
  ),
  'poirier/Quartiers de poires au congélateur': RecipeText(
    // FR: Quartiers de poires au congélateur
    name: 'Gajos de pera en el congelador',
    // FR: Un quart d'heure pour sauver les poires qui mûrissent trop vite : elles finiront en compote, en crumble ou en smoothie.
    description: 'Un cuarto de hora para salvar las peras que maduran demasiado deprisa: acabarán en compota, en crumble o en batido.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '2 kg de peras maduras', // FR: 2 kg de poires mûres
      'el zumo de un limón', // FR: le jus d'un citron
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les poires, retire le cœur et coupe-les en quartiers.
      'Pela las peras, quita el corazón y córtalas en gajos.',
      // FR: Arrose-les aussitôt de jus de citron et mélange : la poire noircit en quelques minutes.
      'Rocíalas enseguida con zumo de limón y mezcla: la pera se ennegrece en pocos minutos.',
      // FR: Étale-les sur une plaque sans qu'elles se touchent et congèle 2 heures.
      'Extiéndelas en una bandeja sin que se toquen y congela 2 horas.',
      // FR: Verse en sac une fois dures. Décongelées, elles sont molles : **pour cuire ou mixer**, pas pour croquer.
      'Pásalas a una bolsa cuando estén duras. Descongeladas, quedan blandas: **para cocinar o triturar**, no para morder.',
    ],
  ),
  'poirier/Poires pochées au vin': RecipeText(
    // FR: Poires pochées au vin
    name: 'Peras escalfadas al vino',
    // FR: Vin rouge, cannelle, badiane : elles prennent une robe profonde.
    description: 'Vino tinto, canela, anís estrellado: adquieren un color profundo.',
  ),
  'poirier/Tarte Bourdaloue': RecipeText(
    // FR: Tarte Bourdaloue
    name: 'Tarta Bourdaloue',
    // FR: Poires et crème d'amandes, le mariage classique.
    description: 'Peras y crema de almendras, el maridaje clásico.',
  ),
  'poirier/Poires au chocolat': RecipeText(
    // FR: Poires au chocolat
    name: 'Peras al chocolate',
    // FR: Pochées, nappées chaud, avec une glace vanille.
    description: 'Escalfadas, bañadas en caliente, con un helado de vainilla.',
  ),

  // ─────────── pois_chiche (6 recettes) ───────────
  'pois_chiche/Pois chiches secs à la remise': RecipeText(
    // FR: Pois chiches secs à la remise
    name: 'Garbanzos secos para la despensa',
    // FR: Bien secs, ils se gardent des années : c'est comme ça qu'on stocke toute une récolte de pois chiches.
    description: 'Bien secos, se guardan años: así se almacena toda una cosecha de garbanzos.',
    // FR: 2 ans au sec, à l'abri de la lumière
    keeps: '2 años en seco, protegido de la luz',
    ingredients: <String>[
      'las plantas de garbanzo bien amarillas', // FR: les plants de pois chiches bien jaunis
      'cajas de madera o una sábana vieja', // FR: des cagettes ou un vieux drap
      'un saco de tela', // FR: un sac de toile
      'tarros de cristal bien secos', // FR: des bocaux en verre bien secs
    ],
    steps: <String>[
      // FR: Arrache les plants quand ils sont jaunes et que les gousses **sonnent** quand tu les secoues.
      'Arranca las plantas cuando estén amarillas y las vainas **suenen** al agitarlas.',
      // FR: Étale-les en couche fine dans un endroit sec et aéré, à l'abri de la pluie, pendant 2 semaines.
      'Extiéndelas en una capa fina en un lugar seco y ventilado, a cubierto de la lluvia, durante 2 semanas.',
      // FR: Écosse à la main, ou tape les plants dans un sac de toile, puis vanne les débris devant un ventilateur.
      'Desgrana a mano, o golpea las plantas dentro de un saco de tela y luego aventa los restos delante de un ventilador.',
      // FR: Croque un grain : il doit être **dur comme un caillou**, impossible à marquer à l'ongle. Sinon, laisse sécher quelques jours de plus.
      'Muerde un grano: debe estar **duro como una piedra**, imposible de marcar con la uña. Si no, déjalo secar unos días más.',
      // FR: Passe les grains 48 heures au congélateur : ça tue les œufs de bruche cachés à l'intérieur.
      'Pasa los granos 48 horas por el congelador: así matas los huevos de gorgojo escondidos dentro.',
      // FR: Range-les en bocaux fermés, au sec. Ils se mangent toujours **trempés puis bien cuits**, jamais crus.
      'Guárdalos en tarros cerrados, en seco. Se comen siempre **en remojo y bien cocidos**, nunca crudos.',
    ],
  ),
  'pois_chiche/Pois chiches cuits en portions': RecipeText(
    // FR: Pois chiches cuits en portions
    name: 'Garbanzos cocidos en porciones',
    // FR: Un seul trempage pour un mois de repas : des sachets prêts à remplacer les boîtes de conserve.
    description: 'Un solo remojo para un mes de comidas: bolsitas listas para sustituir los botes de conserva.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 kg de garbanzos secos', // FR: 1 kg de pois chiches secs
      '1 cucharadita de bicarbonato', // FR: 1 cuillère à café de bicarbonate
      '1 cucharada sopera de sal', // FR: 1 cuillère à soupe de sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Trie les pois chiches pour retirer cailloux et grains abîmés, puis rince-les.
      'Selecciona los garbanzos para quitar piedrecitas y granos estropeados, y acláralos.',
      // FR: Fais-les tremper **12 heures** dans trois fois leur volume d'eau froide avec le bicarbonate : ils doublent de volume.
      'Ponlos en remojo **12 horas** en tres veces su volumen de agua fría con el bicarbonato: doblan su volumen.',
      // FR: Jette l'eau de trempage, couvre d'eau neuve et cuis à petit frémissement, sans saler au début.
      'Tira el agua del remojo, cubre con agua nueva y cuece a fuego suave, sin salar al principio.',
      // FR: Sale en fin de cuisson et vérifie : un pois chiche cuit s'écrase **sans effort** entre deux doigts. Pas cuit, pas mangé.
      'Sala al final de la cocción y comprueba: un garbanzo cocido se aplasta **sin esfuerzo** entre dos dedos. Si no está cocido, no se come.',
      // FR: Égoutte-les et étale-les sur un plateau pour qu'ils refroidissent vite.
      'Escúrrelos y extiéndelos en una bandeja para que se enfríen rápido.',
      // FR: Répartis en sachets de 250 g, l'équivalent d'une boîte, aplatis et chasse l'air. Ils vont directement dans le plat, sans décongeler.
      'Reparte en bolsitas de 250 g, el equivalente a un bote, aplánalas y saca el aire. Van directamente al plato, sin descongelar.',
    ],
  ),
  'pois_chiche/Pois chiches verts blanchis': RecipeText(
    // FR: Pois chiches verts blanchis
    name: 'Garbanzos verdes blanqueados',
    // FR: Cueillis encore verts, ils ont un goût de petit pois sucré : deux minutes d'eau bouillante et ils t'attendent au congélateur.
    description: 'Recogidos aún verdes, saben a guisante dulce: dos minutos de agua hirviendo y te esperan en el congelador.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '500 g de vainas de garbanzo verde', // FR: 500 g de gousses de pois chiches verts
      'sal gorda', // FR: gros sel
      'una ensaladera grande de agua con hielo', // FR: un grand saladier d'eau glacée
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Écosse les gousses bien pleines et encore vertes : chacune donne un ou deux grains.
      'Desgrana las vainas bien llenas y todavía verdes: cada una da uno o dos granos.',
      // FR: Rince les grains dans une passoire sous l'eau froide.
      'Aclara los granos en un colador bajo agua fría.',
      // FR: Blanchis-les **2 minutes** dans une grande eau bouillante salée.
      'Blanquéalos **2 minutos** en abundante agua hirviendo con sal.',
      // FR: Plonge-les aussitôt dans l'eau glacée : c'est ce qui garde leur vert tendre.
      'Sumérgelos enseguida en agua con hielo: eso es lo que conserva su verde tierno.',
      // FR: Égoutte-les et sèche-les sur un torchon, chaque goutte restée devient du givre.
      'Escúrrelos y sécalos sobre un paño, cada gota que quede se convierte en escarcha.',
      // FR: Mets-les en sachets à plat. Le jour venu, cuis-les encore **10 minutes** avant de les manger, comme des petits pois.
      'Ponlos en bolsitas planas. Llegado el día, cuécelos otros **10 minutos** antes de comerlos, como los guisantes.',
    ],
  ),
  'pois_chiche/Houmous': RecipeText(
    // FR: Houmous
    name: 'Hummus',
    // FR: Tahini, citron, ail, et un filet d'huile par-dessus.
    description: 'Tahini, limón, ajo y un chorrito de aceite por encima.',
  ),
  'pois_chiche/Falafels': RecipeText(
    // FR: Falafels
    name: 'Falafels',
    // FR: Crus et trempés, jamais cuits : c'est le secret.
    description: 'Crudos y en remojo, nunca cocidos: ese es el secreto.',
  ),
  'pois_chiche/Pois chiches rôtis épicés': RecipeText(
    // FR: Pois chiches rôtis épicés
    name: 'Garbanzos asados especiados',
    // FR: À grignoter, croquants, au paprika fumé.
    description: 'Para picar, crujientes, con pimentón ahumado.',
  ),

  // ─────────── pois_mange_tout (6 recettes) ───────────
  'pois_mange_tout/Mange-tout blanchis congelés': RecipeText(
    // FR: Mange-tout blanchis congelés
    name: 'Tirabeques blanqueados congelados',
    // FR: Deux minutes de blanchiment et ils filent au congélateur, prêts pour le wok sans passer par la planche.
    description: 'Dos minutos de blanqueado y al congelador, listos para el wok sin pasar por la tabla.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de tirabeques', // FR: 1,5 kg de pois mange-tout
      'sal gorda', // FR: gros sel
      'una ensaladera grande de agua y cubitos de hielo', // FR: un grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Équeute-les en tirant le fil des deux côtés, d'un seul geste.
      'Quítales las puntas tirando del hilo por los dos lados, de un solo gesto.',
      // FR: Plonge-les par fournées dans une grande eau salée bouillante, **2 minutes**.
      'Sumérgelos por tandas en abundante agua con sal hirviendo, **2 minutos**.',
      // FR: Fais-les tomber dans l'eau glacée : le vert devient éclatant et se fixe.
      'Échalos al agua con hielo: el verde se vuelve brillante y se fija.',
      // FR: Égoutte et sèche-les bien dans un torchon.
      'Escurre y sécalos bien en un paño.',
      // FR: Congèle-les étalés sur une plaque, puis mets-les en sac. Ils iront gelés dans le wok chaud.
      'Congélalos extendidos sobre una bandeja y luego ponlos en una bolsa. Irán congelados al wok caliente.',
    ],
  ),
  'pois_mange_tout/Pickles de mange-tout au gingembre': RecipeText(
    // FR: Pickles de mange-tout au gingembre
    name: 'Encurtido de tirabeques con jengibre',
    // FR: Croquants, acidulés, un peu piquants : un pickle à l'asiatique pour accompagner un bol de riz.
    description: 'Crujientes, ácidos, un poco picantes: un encurtido asiático para acompañar un cuenco de arroz.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      '500 g de tirabeques', // FR: 500 g de pois mange-tout
      '1 trozo de jengibre de 3 cm', // FR: 1 morceau de gingembre de 3 cm
      '25 cl de vinagre de arroz o de sidra al 6 %', // FR: 25 cl de vinaigre de riz ou de cidre à 6 %
      '25 cl de agua', // FR: 25 cl d'eau
      '2 cucharadas soperas de azúcar', // FR: 2 cuillères à soupe de sucre
      '1 cucharadita de sal', // FR: 1 cuillère à café de sel
    ],
    steps: <String>[
      // FR: Équeute les mange-tout et retire le fil. Épluche le gingembre et taille-le en fines lamelles.
      'Quita las puntas de los tirabeques y el hilo. Pela el jengibre y córtalo en láminas finas.',
      // FR: Range les cosses debout dans les bocaux, en glissant le gingembre entre elles.
      'Coloca las vainas de pie en los tarros, deslizando el jengibre entre ellas.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Lleva a ebullición el vinagre, el agua, el azúcar y la sal.',
      // FR: Laisse tiédir 5 minutes, puis verse pour **couvrir entièrement** : trop bouillant, il cuirait les cosses.
      'Deja templar 5 minutos y vierte para **cubrir por completo**: demasiado hirviendo, cocería las vainas.',
      // FR: Ferme et range au réfrigérateur. Ils sont bons dès le surlendemain.
      'Cierra y guarda en la nevera. Están buenos a partir del tercer día.',
    ],
  ),
  'pois_mange_tout/Mange-tout fermentés à l\'aneth': RecipeText(
    // FR: Mange-tout fermentés à l'aneth
    name: 'Tirabeques fermentados con eneldo',
    // FR: Une semaine en saumure, et ils prennent une acidité vive tout en restant croquants.
    description: 'Una semana en salmuera, y cogen una acidez viva sin dejar de ser crujientes.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '600 g de tirabeques', // FR: 600 g de pois mange-tout
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '2 dientes de ajo', // FR: 2 gousses d'ail
      'unas ramitas de eneldo', // FR: quelques brins d'aneth
    ],
    steps: <String>[
      // FR: Dissous **30 g de sel dans 1 litre d'eau** pour faire la saumure.
      'Disuelve **30 g de sal en 1 litro de agua** para hacer la salmuera.',
      // FR: Équeute les mange-tout et retire le fil. Choisis-les jeunes et fermes, les gros deviennent mous.
      'Quita las puntas de los tirabeques y el hilo. Elígelos jóvenes y firmes, los grandes quedan blandos.',
      // FR: Tasse-les dans un bocal avec l'ail écrasé et l'aneth, jusqu'à 3 cm du bord.
      'Apisónalos en un tarro con el ajo machacado y el eneldo, hasta 3 cm del borde.',
      // FR: Verse la saumure pour couvrir et pose un poids : tout doit rester **sous la saumure**.
      'Vierte la salmuera para cubrir y pon un peso: todo debe quedar **bajo la salmuera**.',
      // FR: Laisse une semaine à 18–22 °C, couvercle posé sans serrer, à l'abri du soleil.
      'Deja una semana a 18–22 °C, con la tapa puesta sin apretar, protegido del sol.',
      // FR: Goûte, et dès que l'acidité te plaît, ferme bien et passe au réfrigérateur.
      'Prueba, y en cuanto la acidez te guste, cierra bien y pasa a la nevera.',
    ],
  ),
  'pois_mange_tout/Pois gourmands sautés au wok': RecipeText(
    // FR: Pois gourmands sautés au wok
    name: 'Tirabeques salteados al wok',
    // FR: Deux minutes à feu vif, sésame et sauce soja.
    description: 'Dos minutos a fuego vivo, sésamo y salsa de soja.',
  ),
  'pois_mange_tout/Salade de pois gourmands croquants': RecipeText(
    // FR: Salade de pois gourmands croquants
    name: 'Ensalada de tirabeques crujientes',
    // FR: Blanchis trente secondes, glacés à l'eau froide.
    description: 'Blanqueados treinta segundos, enfriados en agua fría.',
  ),
  'pois_mange_tout/Pois gourmands à la crème de menthe': RecipeText(
    // FR: Pois gourmands à la crème de menthe
    name: 'Tirabeques con crema de menta',
    // FR: Une crème légère à la menthe fraîche du jardin.
    description: 'Una crema ligera con menta fresca del huerto.',
  ),

  // ─────────── poivron (6 recettes) ───────────
  'poivron/Lanières de poivrons congelées': RecipeText(
    // FR: Lanières de poivrons congelées
    name: 'Tiras de pimiento congeladas',
    // FR: Pas besoin de blanchir : coupés crus et congelés à plat, ils filent droit dans les poêlées et les sauces.
    description: 'No hace falta blanquear: cortados crudos y congelados planos, van directos a los salteados y a las salsas.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de pimientos de todos los colores', // FR: 2 kg de poivrons de toutes les couleurs
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les poivrons et essuie-les bien.
      'Lava los pimientos y sécalos bien.',
      // FR: Ouvre-les, retire le pédoncule, les graines et les côtes blanches, puis taille des lanières.
      'Ábrelos, quita el pedúnculo, las semillas y las costillas blancas, y corta tiras.',
      // FR: Étale-les sur une plaque **sans qu'elles se touchent** et congèle 2 heures.
      'Extiéndelas en una bandeja **sin que se toquen** y congela 2 horas.',
      // FR: Verse-les en sacs une fois dures, chasse l'air et note la date.
      'Pásalas a bolsas cuando estén duras, saca el aire y anota la fecha.',
      // FR: À l'usage, jette-les gelées dans la poêle chaude. Décongelés ils sont mous : pour cuire, pas pour une salade.
      'Al usarlas, échalas congeladas a la sartén caliente. Descongeladas quedan blandas: para cocinar, no para una ensalada.',
    ],
  ),
  'poivron/Pickles de poivrons aigres-doux': RecipeText(
    // FR: Pickles de poivrons aigres-doux
    name: 'Encurtido de pimientos agridulce',
    // FR: Rouges, jaunes et verts dans le même bocal : un condiment qui réveille une assiette de riz ou un sandwich.
    description: 'Rojos, amarillos y verdes en el mismo tarro: un condimento que despierta un plato de arroz o un bocadillo.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '1 kg de pimientos', // FR: 1 kg de poivrons
      '1 cebolla', // FR: 1 oignon
      '50 cl de vinagre de sidra al 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '50 cl de agua', // FR: 50 cl d'eau
      '100 g de azúcar', // FR: 100 g de sucre
      '1 cucharada sopera de sal fina', // FR: 1 cuillère à soupe de sel fin
    ],
    steps: <String>[
      // FR: Épépine les poivrons et coupe-les en lanières d'un doigt. Émince l'oignon finement.
      'Quita las semillas de los pimientos y córtalos en tiras del ancho de un dedo. Corta la cebolla en láminas finas.',
      // FR: Tasse poivrons et oignon dans des bocaux propres, en mélangeant les couleurs.
      'Apisona los pimientos y la cebolla en tarros limpios, mezclando los colores.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre et le sel.
      'Lleva a ebullición el vinagre, el agua, el azúcar y la sal.',
      // FR: Verse bouillant sur les légumes jusqu'à **les couvrir entièrement**, en laissant 1 cm sous le bord.
      'Vierte hirviendo sobre las verduras hasta **cubrirlas por completo**, dejando 1 cm bajo el borde.',
      // FR: Tapote les bocaux pour chasser les bulles d'air, complète si besoin, et ferme.
      'Golpea suavemente los tarros para sacar las burbujas de aire, completa si hace falta y cierra.',
      // FR: Une fois froids, range-les au réfrigérateur. Attends 3 jours avant d'y goûter.
      'Una vez fríos, guárdalos en la nevera. Espera 3 días antes de probarlos.',
    ],
  ),
  'poivron/Paprika maison': RecipeText(
    // FR: Paprika maison
    name: 'Pimentón casero',
    // FR: Des poivrons rouges séchés puis moulus : une poudre douce et fruitée qui n'a rien à voir avec celle du commerce.
    description: 'Pimientos rojos secados y luego molidos: un polvo suave y afrutado que no tiene nada que ver con el del súper.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      '2 kg de pimientos rojos bien maduros', // FR: 2 kg de poivrons rouges bien mûrs
      'papel de horno', // FR: du papier cuisson
      'un tarro pequeño de cristal bien seco', // FR: un petit pot en verre bien sec
    ],
    steps: <String>[
      // FR: Épépine les poivrons, retire les côtes blanches et coupe-les en lanières fines de 1 cm.
      'Quita las semillas de los pimientos, retira las costillas blancas y corta tiras finas de 1 cm.',
      // FR: Étale-les peau dessous sur les plaques et enfourne à **60 °C**, porte entrouverte.
      'Extiéndelas con la piel hacia abajo sobre las bandejas y hornea a **60 °C**, con la puerta entreabierta.',
      // FR: Retourne-les de temps en temps. Elles doivent être **cassantes**, pas souples : une lanière souple moisira dans le pot.
      'Dales la vuelta de vez en cuando. Deben quedar **quebradizas**, no flexibles: una tira flexible se enmohecerá en el tarro.',
      // FR: Laisse refroidir, puis mixe en poudre fine au moulin à café, par petites quantités.
      'Deja enfriar y tritura hasta obtener un polvo fino en un molinillo de café, en pequeñas cantidades.',
      // FR: Tamise et mets en pot. Il en faut beaucoup : 2 kg donnent à peine un petit pot.
      'Tamiza y pasa a un tarro. Hacen falta muchos: 2 kg dan apenas un tarrito.',
    ],
  ),
  'poivron/Poivrons marinés à l\'huile': RecipeText(
    // FR: Poivrons marinés à l'huile
    name: 'Pimientos marinados en aceite',
    // FR: Grillés, pelés, couchés dans l'huile d'olive à l'ail : ils se gardent des semaines.
    description: 'Asados, pelados, tumbados en aceite de oliva con ajo: se guardan semanas.',
    ingredients: <String>[
      '6 pimientos carnosos', // FR: 6 poivrons charnus
      'Aceite de oliva', // FR: Huile d'olive
      '2 dientes de ajo', // FR: 2 gousses d'ail
      'Sal, orégano o albahaca', // FR: Sel, origan ou basilic
    ],
    steps: <String>[
      // FR: Passe les poivrons entiers sous le gril jusqu'à ce que la peau noircisse et cloque, en les retournant.
      'Pasa los pimientos enteros bajo el grill hasta que la piel se ennegrezca y se ampolle, dándoles la vuelta.',
      // FR: Enferme-les chauds dans un sac ou un saladier couvert : la vapeur décolle la peau toute seule.
      'Enciérralos calientes en una bolsa o en un recipiente tapado: el vapor despega la piel solo.',
      // FR: Pèle-les, ôte les graines, coupe-les en lanières. Ne les rince pas, tu perdrais le jus.
      'Pélalos, quita las semillas y córtalos en tiras. No los aclares, perderías el jugo.',
      // FR: Range les lanières en bocal avec l'ail en lamelles et les herbes, couvre entièrement d'huile.
      'Coloca las tiras en un tarro con el ajo en láminas y las hierbas, cubre por completo con aceite.',
      // FR: Au frais. Meilleurs au bout de deux jours.
      'En la nevera. Mejores a los dos días.',
    ],
  ),
  'poivron/Poivrons farcis': RecipeText(
    // FR: Poivrons farcis
    name: 'Pimientos rellenos',
    // FR: Riz, viande ou lentilles, herbes : un plat complet au four.
    description: 'Arroz, carne o lentejas, hierbas: un plato completo al horno.',
  ),
  'poivron/Piperade': RecipeText(
    // FR: Piperade
    name: 'Piperrada',
    // FR: Poivrons, tomates et oignons mijotés, liés aux œufs — le Pays basque dans une poêle.
    description: 'Pimientos, tomates y cebollas cocidos a fuego lento, ligados con huevos: el País Vasco en una sartén.',
  ),

  // ─────────── pomme_de_terre (6 recettes) ───────────
  'pomme_de_terre/Frites maison précuites congelées': RecipeText(
    // FR: Frites maison précuites congelées
    name: 'Patatas fritas caseras precocidas congeladas',
    // FR: Coupées et blanchies d'avance, elles passent du congélateur à la friteuse ou au four, comme celles du commerce.
    description: 'Cortadas y blanqueadas de antemano, pasan del congelador a la freidora o al horno, como las del súper.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de patatas harinosas (bintje)', // FR: 1,5 kg de pommes de terre farineuses (bintje)
      'sal gorda', // FR: gros sel
      'una ensaladera grande de agua con hielo', // FR: un grand saladier d'eau glacée
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les pommes de terre et coupe-les en frites de 1 cm, toutes pareilles.
      'Pela las patatas y córtalas en bastones de 1 cm, todos iguales.',
      // FR: Rince-les à grande eau jusqu'à ce qu'elle soit claire : l'amidon en surface les fait coller.
      'Acláralas con abundante agua hasta que salga clara: el almidón de la superficie las hace pegarse.',
      // FR: Plonge-les par fournées dans l'eau bouillante salée et compte **3 minutes** : elles doivent rester fermes.
      'Sumérgelas por tandas en agua hirviendo con sal y cuenta **3 minutos**: deben quedar firmes.',
      // FR: Plonge-les dans l'eau glacée, puis égoutte.
      'Pásalas al agua con hielo y escúrrelas.',
      // FR: Sèche-les très bien sur un torchon : l'eau qui reste fait des projections à la cuisson.
      'Sécalas muy bien sobre un paño: el agua que queda salpica al cocinarlas.',
      // FR: Étale-les sur une plaque, congèle 2 heures, puis mets en sac. Cuis-les **sans décongeler**, au four à 220 °C ou à la friteuse.
      'Extiéndelas en una bandeja, congela 2 horas y luego pásalas a una bolsa. Cocínalas **sin descongelar**, al horno a 220 °C o en la freidora.',
    ],
  ),
  'pomme_de_terre/Purée maison en portions': RecipeText(
    // FR: Purée maison en portions
    name: 'Puré casero en porciones',
    // FR: Crue, la pomme de terre devient noire et farineuse au congélateur ; en purée bien beurrée, elle se garde très bien.
    description: 'Cruda, la patata se pone negra y harinosa en el congelador; en puré con buena mantequilla, se conserva muy bien.',
    // FR: 4 mois au congélateur
    keeps: '4 meses en el congelador',
    ingredients: <String>[
      '2 kg de patatas', // FR: 2 kg de pommes de terre
      '100 g de mantequilla', // FR: 100 g de beurre
      '30 cl de leche', // FR: 30 cl de lait
      'sal, nuez moscada', // FR: sel, muscade
      'cajas de congelación', // FR: des boîtes de congélation
    ],
    steps: <String>[
      // FR: Épluche les pommes de terre et coupe-les en morceaux réguliers.
      'Pela las patatas y córtalas en trozos regulares.',
      // FR: Cuis-les à l'eau salée, départ eau froide, jusqu'à ce qu'elles s'écrasent sous la fourchette.
      'Cuécelas en agua con sal, empezando con agua fría, hasta que se aplasten con el tenedor.',
      // FR: Égoutte et passe-les au moulin à légumes, **jamais au mixeur** : elles deviendraient collantes.
      'Escúrrelas y pásalas por el pasapurés, **nunca por la batidora**: se volverían pegajosas.',
      // FR: Incorpore le beurre puis le lait chaud. **Bien beurrée**, elle supporte mieux la congélation.
      'Incorpora la mantequilla y luego la leche caliente. **Con buena mantequilla**, aguanta mejor la congelación.',
      // FR: Laisse refroidir complètement, couvert d'un film au contact.
      'Deja enfriar por completo, tapado con film en contacto.',
      // FR: Répartis en portions d'un repas et congèle. Réchauffe doucement avec un trait de lait en remuant.
      'Reparte en porciones de una comida y congela. Recalienta despacio con un chorrito de leche, removiendo.',
    ],
  ),
  'pomme_de_terre/Lamelles de pomme de terre déshydratées': RecipeText(
    // FR: Lamelles de pomme de terre déshydratées
    name: 'Láminas de patata deshidratadas',
    // FR: Précuites puis séchées, elles se gardent au placard et regonflent en vingt minutes dans un gratin ou une soupe.
    description: 'Precocidas y luego secadas, se guardan en la despensa y se rehidratan en veinte minutos en un gratinado o una sopa.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      '2 kg de patatas firmes', // FR: 2 kg de pommes de terre fermes
      'papel de horno', // FR: du papier cuisson
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Épluche et coupe en lamelles de 3 mm, à la mandoline.
      'Pela y corta en láminas de 3 mm, con la mandolina.',
      // FR: Rince-les dans plusieurs eaux jusqu'à ce qu'elle reste claire.
      'Acláralas en varias aguas hasta que el agua quede clara.',
      // FR: Plonge-les dans l'eau bouillante **5 minutes** : précuites, elles ne noircissent pas en séchant.
      'Sumérgelas en agua hirviendo **5 minutos**: precocidas, no se ennegrecen al secarse.',
      // FR: Rafraîchis-les à l'eau froide et étale-les sur un torchon pour les sécher.
      'Refréscalas con agua fría y extiéndelas sobre un paño para secarlas.',
      // FR: Dispose-les en une seule couche sur des plaques, et sèche au four à **60 °C**, porte entrouverte, ou au déshydrateur.
      'Colócalas en una sola capa sobre bandejas y sécalas en el horno a **60 °C**, con la puerta entreabierta, o en el deshidratador.',
      // FR: Elles sont prêtes quand elles cassent net comme du verre. Laisse refroidir et range en bocal fermé.
      'Están listas cuando se parten limpias como el cristal. Deja enfriar y guarda en un tarro cerrado.',
    ],
  ),
  'pomme_de_terre/Gratin dauphinois': RecipeText(
    // FR: Gratin dauphinois
    name: 'Gratinado de patatas a la delfinesa',
    // FR: Des lamelles fines qui fondent dans la crème et l'ail, une heure au four.
    description: 'Láminas finas que se funden en la nata y el ajo, una hora al horno.',
    ingredients: <String>[
      '1 kg de patatas de carne firme', // FR: 1 kg de pommes de terre à chair ferme
      '40 cl de nata líquida', // FR: 40 cl de crème liquide
      '20 cl de leche', // FR: 20 cl de lait
      '1 diente de ajo', // FR: 1 gousse d'ail
      'Nuez moscada, sal, pimienta', // FR: Noix de muscade, sel, poivre
    ],
    steps: <String>[
      // FR: Épluche les pommes de terre et coupe-les en rondelles de 2 mm. Ne les rince pas : l'amidon fait tenir le gratin.
      'Pela las patatas y córtalas en rodajas de 2 mm. No las aclares: el almidón hace que el gratinado cuaje.',
      // FR: Frotte le plat avec la gousse d'ail coupée en deux, puis beurre-le.
      'Frota la fuente con el diente de ajo cortado por la mitad y úntala con mantequilla.',
      // FR: Chauffe la crème et le lait avec la muscade, le sel et le poivre, sans faire bouillir.
      'Calienta la nata y la leche con la nuez moscada, la sal y la pimienta, sin que hiervan.',
      // FR: Range les rondelles en couches serrées, verse le mélange chaud dessus jusqu'à les couvrir.
      'Coloca las rodajas en capas apretadas y vierte por encima la mezcla caliente hasta cubrirlas.',
      // FR: Four à 160 °C. Le gratin est prêt quand la pointe d'un couteau traverse sans résistance.
      'Horno a 160 °C. El gratinado está listo cuando la punta de un cuchillo lo atraviesa sin resistencia.',
      // FR: Laisse reposer dix minutes avant de servir : il se tient mieux à la découpe.
      'Déjalo reposar diez minutos antes de servir: se corta mejor.',
    ],
  ),
  'pomme_de_terre/Pommes de terre sautées à l\'ail': RecipeText(
    // FR: Pommes de terre sautées à l'ail
    name: 'Patatas salteadas con ajo',
    // FR: Croustillantes dehors, fondantes dedans, avec du persil du jardin.
    description: 'Crujientes por fuera, tiernas por dentro, con perejil del huerto.',
  ),
  'pomme_de_terre/Soupe poireaux-pommes de terre': RecipeText(
    // FR: Soupe poireaux-pommes de terre
    name: 'Sopa de puerros y patatas',
    // FR: La soupe de tous les hivers, celle qu'on refait sans recette.
    description: 'La sopa de todos los inviernos, la que se hace sin receta.',
    ingredients: <String>[
      '4 puerros', // FR: 4 poireaux
      '4 patatas', // FR: 4 pommes de terre
      '1 l de agua o de caldo', // FR: 1 l d'eau ou de bouillon
      'Una nuez de mantequilla, sal, pimienta', // FR: Une noix de beurre, sel, poivre
    ],
    steps: <String>[
      // FR: Fends les poireaux en quatre dans la longueur et rince-les bien : la terre se cache entre les feuilles.
      'Abre los puerros en cuatro a lo largo y acláralos bien: la tierra se esconde entre las hojas.',
      // FR: Fais-les suer au beurre à feu doux, sans les colorer.
      'Sofríelos en la mantequilla a fuego suave, sin que tomen color.',
      // FR: Ajoute les pommes de terre en gros cubes et l'eau. Sale peu : tu rectifieras à la fin.
      'Añade las patatas en cubos grandes y el agua. Sala poco: rectificarás al final.',
      // FR: Laisse frémir à couvert jusqu'à ce que les cubes s'écrasent à la fourchette.
      'Deja hervir a fuego suave tapado hasta que los cubos se aplasten con el tenedor.',
      // FR: Mixe, ou écrase grossièrement si tu aimes les morceaux. Rectifie le sel.
      'Tritura, o aplasta de forma rústica si te gustan los trozos. Rectifica de sal.',
    ],
  ),

  // ─────────── pommier (6 recettes) ───────────
  'pommier/Compote de pommes en bocaux': RecipeText(
    // FR: Compote de pommes en bocaux
    name: 'Compota de manzana en tarros',
    // FR: Les pommes tombées, les tachées, les petites : tout finit en bocaux qui tiennent jusqu'à la récolte suivante.
    description: 'Las manzanas caídas, las manchadas, las pequeñas: todo acaba en tarros que duran hasta la cosecha siguiente.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 año en la despensa, 5 días abierto en la nevera',
    ingredients: <String>[
      '3 kg de manzanas', // FR: 3 kg de pommes
      '150 a 300 g de azúcar, según la acidez', // FR: 150 à 300 g de sucre, selon l'acidité
      '20 cl de agua', // FR: 20 cl d'eau
      'el zumo de un limón', // FR: le jus d'un citron
      '6 tarros de 50 cl con juntas o tapas nuevas', // FR: 6 bocaux de 50 cl avec joints ou couvercles neufs
    ],
    steps: <String>[
      // FR: Épluche, épépine et coupe les pommes en morceaux, en les arrosant de citron au fur et à mesure.
      'Pela, quita las pepitas y corta las manzanas en trozos, rociándolas con limón según avanzas.',
      // FR: Cuis-les à couvert avec l'eau et le sucre, à feu doux, en remuant, jusqu'à ce qu'elles s'écrasent.
      'Cuécelas tapadas con el agua y el azúcar, a fuego suave, removiendo, hasta que se aplasten.',
      // FR: Écrase à la fourchette pour une compote rustique, ou passe au moulin à légumes pour une compote lisse.
      'Aplasta con un tenedor para una compota rústica, o pasa por el pasapurés para una compota fina.',
      // FR: Remplis les bocaux propres de compote chaude **jusqu'à 2 cm du bord**, essuie les bords et ferme avec des joints neufs.
      'Llena los tarros limpios de compota caliente **hasta 2 cm del borde**, limpia los bordes y cierra con juntas nuevas.',
      // FR: Pose les bocaux dans une grande marmite, **couverts d'eau**, et stérilise **25 minutes à 100 °C**, à compter de l'ébullition.
      'Coloca los tarros en una olla grande, **cubiertos de agua**, y esteriliza **25 minutos a 100 °C**, contados desde que hierva.',
      // FR: Laisse refroidir dans l'eau, puis vérifie : couvercle creusé ou joint qui tient. Sinon, au frais et à manger dans la semaine.
      'Deja enfriar en el agua y comprueba: tapa hundida o junta que aguanta. Si no, a la nevera y a comer en la semana.',
    ],
  ),
  'pommier/Rondelles de pommes séchées': RecipeText(
    // FR: Rondelles de pommes séchées
    name: 'Rodajas de manzana secas',
    // FR: Quatre heures de four doux, et des chips de pomme souples à grignoter tout l'hiver.
    description: 'Cuatro horas de horno suave, y chips de manzana flexibles para picotear todo el invierno.',
    // FR: 6 mois en bocal, au sec
    keeps: '6 meses en tarro, en lugar seco',
    ingredients: <String>[
      '2 kg de manzanas firmes', // FR: 2 kg de pommes fermes
      '1 litro de agua fría', // FR: 1 litre d'eau froide
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Évide les pommes avec un vide-pomme, épluche-les si tu veux, et coupe des rondelles de **5 mm**, toutes pareilles.
      'Quita el corazón de las manzanas con un descorazonador, pélalas si quieres y corta rodajas de **5 mm**, todas iguales.',
      // FR: Plonge-les au fur et à mesure dans l'eau citronnée : c'est ce qui les empêche de brunir.
      'Sumérgelas según las cortes en el agua con limón: es lo que evita que se oscurezcan.',
      // FR: Égoutte et éponge-les sur un torchon propre.
      'Escúrrelas y sécalas con un paño limpio.',
      // FR: Étale-les sans chevauchement sur des grilles et sèche au four à **70 °C**, porte entrouverte avec une cuillère en bois. Retourne-les à mi-temps.
      'Extiéndelas sin que se solapen sobre rejillas y sécalas en el horno a **70 °C**, con la puerta entreabierta con una cuchara de madera. Dales la vuelta a mitad de tiempo.',
      // FR: Teste une rondelle refroidie : souple comme du cuir, sans aucune humidité quand tu la plies en deux.
      'Prueba una rodaja ya fría: flexible como el cuero, sin nada de humedad al doblarla por la mitad.',
      // FR: Mets-les en bocal et secoue-le chaque jour pendant une semaine. S'il se forme de la buée, retour au four.
      'Pásalas a un tarro y agítalo cada día durante una semana. Si se forma vaho, vuelven al horno.',
    ],
  ),
  'pommier/Quartiers de pommes congelés': RecipeText(
    // FR: Quartiers de pommes congelés
    name: 'Gajos de manzana congelados',
    // FR: Vingt minutes, et tu as des pommes prêtes pour une tarte ou un crumble, sans éplucher le soir venu.
    description: 'Veinte minutos, y tienes manzanas listas para una tarta o un crumble, sin pelar cuando llega la noche.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '2 kg de manzanas', // FR: 2 kg de pommes
      'el zumo de un limón', // FR: le jus d'un citron
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche, épépine et coupe les pommes en quartiers ou en lamelles épaisses.
      'Pela, quita las pepitas y corta las manzanas en gajos o en láminas gruesas.',
      // FR: Arrose-les de jus de citron et mélange bien : **sans citron**, elles brunissent au congélateur.
      'Rocíalas con zumo de limón y mezcla bien: **sin limón**, se oscurecen en el congelador.',
      // FR: Étale-les sur une plaque sans qu'elles se touchent et congèle 2 heures.
      'Extiéndelas en una bandeja sin que se toquen y congela 2 horas.',
      // FR: Verse-les en sac une fois dures. Elles vont directement dans une tarte, un crumble ou une compote, sans décongeler.
      'Pásalas a una bolsa cuando estén duras. Van directamente a una tarta, un crumble o una compota, sin descongelar.',
    ],
  ),
  'pommier/Tarte aux pommes': RecipeText(
    // FR: Tarte aux pommes
    name: 'Tarta de manzana',
    // FR: Des quartiers rangés en rosace sur une compote, et du sucre qui caramélise.
    description: 'Gajos colocados en roseta sobre una compota, y azúcar que se carameliza.',
    ingredients: <String>[
      '1 masa quebrada', // FR: 1 pâte brisée
      '6 manzanas (4 para la compota, 2 para encima)', // FR: 6 pommes (4 pour la compote, 2 pour le dessus)
      '50 g de azúcar', // FR: 50 g de sucre
      'Una nuez de mantequilla', // FR: Une noix de beurre
      'Canela (opcional)', // FR: Cannelle (facultatif)
    ],
    steps: <String>[
      // FR: Épluche quatre pommes, coupe-les en morceaux et fais-les compoter à couvert avec deux cuillères d'eau.
      'Pela cuatro manzanas, córtalas en trozos y haz una compota tapada con dos cucharadas de agua.',
      // FR: Écrase la compote à la fourchette, sucre-la légèrement. Laisse tiédir.
      'Aplasta la compota con un tenedor, endúlzala ligeramente. Deja templar.',
      // FR: Étale la pâte dans le moule, pique le fond, étale la compote dessus.
      'Extiende la masa en el molde, pincha el fondo y reparte la compota por encima.',
      // FR: Taille les deux pommes restantes en lamelles fines et range-les en rosace, en les faisant se chevaucher.
      'Corta las dos manzanas restantes en láminas finas y colócalas en roseta, solapándolas.',
      // FR: Parsème de noisettes de beurre et du reste de sucre.
      'Esparce nuececitas de mantequilla y el resto del azúcar.',
      // FR: Four à 190 °C jusqu'à ce que les bords des lamelles brunissent.
      'Horno a 190 °C hasta que los bordes de las láminas se doren.',
    ],
  ),
  'pommier/Compote maison': RecipeText(
    // FR: Compote maison
    name: 'Compota casera',
    // FR: Sans sucre ajouté si les pommes sont mûres — elles suffisent.
    description: 'Sin azúcar añadido si las manzanas están maduras: con ellas basta.',
  ),
  'pommier/Pommes au four': RecipeText(
    // FR: Pommes au four
    name: 'Manzanas al horno',
    // FR: Évidées, remplies de beurre, de sucre et d'une noix.
    description: 'Sin corazón, rellenas de mantequilla, azúcar y una nuez.',
  ),

  // ─────────── potimarron (6 recettes) ───────────
  'potimarron/Purée de potimarron en portions': RecipeText(
    // FR: Purée de potimarron en portions
    name: 'Puré de calabaza potimarron en porciones',
    // FR: Rôti puis écrasé, il donne une purée dense et sucrée, prête pour un velouté, un gâteau ou un gratin.
    description: 'Asada y luego aplastada, da un puré denso y dulce, listo para una crema, un pastel o un gratinado.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '2 calabazas potimarron (unos 3 kg)', // FR: 2 potimarrons (environ 3 kg)
      '1 cucharada sopera de aceite', // FR: 1 cuillère à soupe d'huile
      'sal', // FR: sel
      'cajas o bolsas de congelación', // FR: des boîtes ou sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les potimarrons en deux, retire les graines, puis taille en quartiers. Garde la peau : elle fond à la cuisson.
      'Corta las calabazas por la mitad, quita las semillas y córtalas en gajos. Conserva la piel: se deshace al cocinarse.',
      // FR: Enfourne les quartiers huilés à 200 °C, jusqu'à ce qu'un couteau s'y enfonce tout seul.
      'Hornea los gajos untados de aceite a 200 °C, hasta que un cuchillo entre solo.',
      // FR: Mixe la chair avec sa peau. Rôtie plutôt que bouillie, la purée est moins aqueuse et plus sucrée.
      'Tritura la pulpa con su piel. Asado en vez de hervido, el puré es menos acuoso y más dulce.',
      // FR: Laisse refroidir complètement, étalée dans un plat.
      'Deja enfriar por completo, extendido en una fuente.',
      // FR: Répartis en portions de 500 g en laissant 2 cm de vide, ferme et date.
      'Reparte en porciones de 500 g dejando 2 cm de vacío, cierra y pon fecha.',
    ],
  ),
  'potimarron/Dés de potimarron crus congelés': RecipeText(
    // FR: Dés de potimarron crus congelés
    name: 'Dados de calabaza potimarron crudos congelados',
    // FR: Pas besoin de blanchir : coupé en dés et congelé sur plaque, il file tout droit au four ou dans la soupe.
    description: 'No hace falta blanquear: cortada en dados y congelada en bandeja, va directa al horno o a la sopa.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 calabazas potimarron (unos 3 kg)', // FR: 2 potimarrons (environ 3 kg)
      'una bandeja', // FR: une plaque
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave et essuie la peau des potimarrons.
      'Lava y seca la piel de las calabazas.',
      // FR: Coupe-les en quartiers, retire les graines, puis taille en dés de 2 cm, avec la peau.
      'Córtalas en gajos, quita las semillas y corta en dados de 2 cm, con la piel.',
      // FR: Sèche les dés sur un torchon si la chair est humide.
      'Seca los dados en un paño si la pulpa está húmeda.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent et congèle 2 heures.
      'Extiéndelos en una bandeja sin que se toquen y congela 2 horas.',
      // FR: Verse-les en sacs une fois durs, et date. Cuis-les encore gelés : au four, ils rôtissent très bien.
      'Pásalos a bolsas cuando estén duros y pon fecha. Cuécelos aún congelados: al horno, se asan muy bien.',
    ],
  ),
  'potimarron/Pickles de potimarron épicés': RecipeText(
    // FR: Pickles de potimarron épicés
    name: 'Encurtido de calabaza potimarron especiado',
    // FR: En fines lamelles au vinaigre et aux épices, il devient un condiment orange vif pour les fromages et les plats froids.
    description: 'En láminas finas con vinagre y especias, se convierte en un condimento naranja vivo para los quesos y los platos fríos.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '1 kg de pulpa de calabaza potimarron pelada', // FR: 1 kg de chair de potimarron épluchée
      '40 cl de vinagre blanco al 8 %', // FR: 40 cl de vinaigre blanc à 8 %
      '40 cl de agua', // FR: 40 cl d'eau
      '15 g de sal, 80 g de azúcar', // FR: 15 g de sel, 80 g de sucre
      '1 rama de canela, 1 trozo de jengibre de 3 cm', // FR: 1 bâton de cannelle, 1 morceau de gingembre de 3 cm
    ],
    steps: <String>[
      // FR: Épluche le potimarron, retire les graines et taille la chair en fines lamelles de 3 mm.
      'Pela la calabaza, quita las semillas y corta la pulpa en láminas finas de 3 mm.',
      // FR: Fais bouillir le vinaigre, l'eau, le sel, le sucre, la cannelle et le gingembre en lamelles, 5 minutes.
      'Hierve el vinagre, el agua, la sal, el azúcar, la canela y el jengibre en láminas, 5 minutos.',
      // FR: Ajoute les lamelles et laisse frémir **2 minutes** : elles doivent rester fermes.
      'Añade las láminas y deja hervir suavemente **2 minutos**: deben quedar firmes.',
      // FR: Répartis les lamelles dans trois bocaux ébouillantés.
      'Reparte las láminas en tres tarros escaldados.',
      // FR: Verse le liquide bouillant pour **couvrir entièrement**, ferme et laisse refroidir.
      'Vierte el líquido hirviendo para **cubrir por completo**, cierra y deja enfriar.',
      // FR: Range au réfrigérateur et attends 3 jours avant d'ouvrir.
      'Guarda en la nevera y espera 3 días antes de abrir.',
    ],
  ),
  'potimarron/Velouté de potimarron': RecipeText(
    // FR: Velouté de potimarron
    name: 'Crema de calabaza potimarron',
    // FR: Sa peau se mange : pas d'épluchage, et un goût de châtaigne.
    description: 'Su piel se come: sin pelar, y con un sabor a castaña.',
    ingredients: <String>[
      '1 calabaza potimarron (1,2 kg)', // FR: 1 potimarron (1,2 kg)
      '1 cebolla', // FR: 1 oignon
      '70 cl de caldo', // FR: 70 cl de bouillon
      '10 cl de nata', // FR: 10 cl de crème
      'sal, pimienta, nuez moscada', // FR: sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Lave le potimarron, coupe-le en cubes **sans l'éplucher** : la peau fond à la cuisson.
      'Lava la calabaza y córtala en cubos **sin pelarla**: la piel se deshace al cocinarse.',
      // FR: Fais fondre l'oignon, ajoute les cubes.
      'Rehoga la cebolla y añade los cubos.',
      // FR: Mouille au bouillon, à hauteur.
      'Moja con el caldo, hasta cubrir.',
      // FR: Cuis 25 minutes à couvert.
      'Cuece 25 minutos tapado.',
      // FR: Mixe, crème hors du feu, muscade.
      'Tritura, nata fuera del fuego, nuez moscada.',
    ],
  ),
  'potimarron/Potimarron rôti au four': RecipeText(
    // FR: Potimarron rôti au four
    name: 'Calabaza potimarron asada al horno',
    // FR: En quartiers, à l'huile et au romarin : le four fait tout le travail.
    description: 'En gajos, con aceite y romero: el horno hace todo el trabajo.',
    ingredients: <String>[
      '1 calabaza potimarron', // FR: 1 potimarron
      '3 cucharadas soperas de aceite de oliva', // FR: 3 cuillères à soupe d'huile d'olive
      '2 dientes de ajo', // FR: 2 gousses d'ail
      'romero, sal gorda, pimienta', // FR: romarin, gros sel, poivre
    ],
    steps: <String>[
      // FR: Coupe le potimarron en quartiers, retire les graines, garde la peau.
      'Corta la calabaza en gajos, quita las semillas, conserva la piel.',
      // FR: Enrobe d'huile, ajoute l'ail en chemise et le romarin.
      'Úntala de aceite, añade el ajo con piel y el romero.',
      // FR: Four à 200 °C, 35 minutes. Retourne les quartiers à mi-cuisson.
      'Horno a 200 °C, 35 minutos. Dale la vuelta a los gajos a mitad de cocción.',
      // FR: Gros sel et poivre à la sortie.
      'Sal gorda y pimienta al sacarla.',
    ],
  ),
  'potimarron/Tarte au potimarron': RecipeText(
    // FR: Tarte au potimarron
    name: 'Tarta de calabaza potimarron',
    // FR: Entre la tarte et le flan, à peine sucrée, très réconfortante.
    description: 'Entre la tarta y el flan, apenas dulce, muy reconfortante.',
    ingredients: <String>[
      '1 masa quebrada', // FR: 1 pâte brisée
      '800 g de calabaza potimarron', // FR: 800 g de potimarron
      '2 huevos, 20 cl de nata', // FR: 2 oeufs, 20 cl de crème
      '60 g de azúcar', // FR: 60 g de sucre
      'canela, nuez moscada, sal', // FR: cannelle, muscade, sel
    ],
    steps: <String>[
      // FR: Cuis le potimarron en cubes 20 minutes à la vapeur.
      'Cuece la calabaza en cubos 20 minutos al vapor.',
      // FR: Écrase-le et laisse-le refroidir, bien égoutté.
      'Aplástala y déjala enfriar, bien escurrida.',
      // FR: Mélange avec oeufs, crème, sucre, cannelle, muscade, une pincée de sel.
      'Mezcla con los huevos, la nata, el azúcar, la canela, la nuez moscada y una pizca de sal.',
      // FR: Verse sur la pâte étalée et piquée.
      'Vierte sobre la masa extendida y pinchada.',
      // FR: Four à 180 °C, 40 minutes : le centre doit être juste pris.
      'Horno a 180 °C, 40 minutos: el centro debe quedar justo cuajado.',
    ],
  ),

  // ─────────── potiron (6 recettes) ───────────
  'potiron/Purée de potiron en portions': RecipeText(
    // FR: Purée de potiron en portions
    name: 'Puré de calabaza en porciones',
    // FR: Cuit à la vapeur et écrasé, un potiron entier tient dans quelques boîtes, prêtes pour les soupes, gnocchis et gâteaux.
    description: 'Cocida al vapor y aplastada, una calabaza entera cabe en unas pocas cajas, listas para sopas, ñoquis y pasteles.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1 calabaza de unos 3 kg', // FR: 1 potiron d'environ 3 kg
      'cajas de congelación', // FR: des boîtes de congélation
    ],
    steps: <String>[
      // FR: Coupe le potiron en quartiers, retire graines et filaments, puis épluche et coupe en gros cubes.
      'Corta la calabaza en gajos, quita las semillas y las hebras, luego pela y corta en cubos grandes.',
      // FR: Cuis à la vapeur jusqu'à ce que la chair s'écrase sous la fourchette.
      'Cuece al vapor hasta que la pulpa se aplaste con el tenedor.',
      // FR: Laisse égoutter 10 minutes dans une passoire : une purée trop aqueuse fait des glaçons.
      'Deja escurrir 10 minutos en un colador: un puré demasiado acuoso forma bloques de hielo.',
      // FR: Écrase ou mixe sans rien ajouter, ni sel ni beurre : tu assaisonneras selon le plat.
      'Aplasta o tritura sin añadir nada, ni sal ni mantequilla: sazonarás según el plato.',
      // FR: Laisse refroidir complètement.
      'Deja enfriar por completo.',
      // FR: Répartis par portions de 500 g en laissant 2 cm de vide, et note la date.
      'Reparte en porciones de 500 g dejando 2 cm de vacío, y anota la fecha.',
    ],
  ),
  'potiron/Cubes de potiron crus congelés': RecipeText(
    // FR: Cubes de potiron crus congelés
    name: 'Cubos de calabaza crudos congelados',
    // FR: Un potiron entamé pourrit vite : en cubes crus, il file au congélateur en vingt minutes et va directement dans la soupe.
    description: 'Una calabaza empezada se pudre rápido: en cubos crudos, va al congelador en veinte minutos y pasa directamente a la sopa.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      '1 calabaza de unos 3 kg', // FR: 1 potiron d'environ 3 kg
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe le potiron en quartiers, retire graines et filaments à la cuillère.
      'Corta la calabaza en gajos, quita las semillas y las hebras con una cuchara.',
      // FR: Épluche chaque quartier posé à plat et coupe la chair en cubes de 3 cm.
      'Pela cada gajo apoyado plano y corta la pulpa en cubos de 3 cm.',
      // FR: Étale les cubes sur une plaque sans qu'ils se touchent et congèle 2 heures.
      'Extiende los cubos en una bandeja sin que se toquen y congela 2 horas.',
      // FR: Verse-les en sac, chasse l'air. **Cuis-les sans décongeler** : en soupe, en curry ou rôtis au four.
      'Pásalos a una bolsa, saca el aire. **Cuécelos sin descongelar**: en sopa, en curry o asados al horno.',
    ],
  ),
  'potiron/Potiron aigre-doux au vinaigre': RecipeText(
    // FR: Potiron aigre-doux au vinaigre
    name: 'Calabaza agridulce en vinagre',
    // FR: Une recette danoise : des cubes de potiron confits dans un vinaigre sucré au gingembre, à servir avec la viande froide.
    description: 'Una receta danesa: cubos de calabaza confitados en un vinagre azucarado con jengibre, para servir con la carne fría.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '1,5 kg de pulpa de calabaza', // FR: 1,5 kg de chair de potiron
      '50 cl de vinagre de sidra al 6 %', // FR: 50 cl de vinaigre de cidre à 6 %
      '30 cl de agua', // FR: 30 cl d'eau
      '300 g de azúcar', // FR: 300 g de sucre
      '1 trozo de jengibre de 3 cm', // FR: 1 morceau de gingembre de 3 cm
      '1 rama de canela', // FR: 1 bâton de cannelle
    ],
    steps: <String>[
      // FR: Coupe la chair en cubes de 2 cm, bien réguliers pour qu'ils cuisent pareil.
      'Corta la pulpa en cubos de 2 cm, bien regulares para que se cuezan por igual.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sucre, le gingembre en lamelles et la cannelle.
      'Lleva a ebullición el vinagre, el agua, el azúcar, el jengibre en láminas y la canela.',
      // FR: Plonge les cubes et laisse frémir jusqu'à ce qu'ils deviennent translucides mais **restent entiers**.
      'Sumerge los cubos y deja hervir suavemente hasta que se vuelvan translúcidos pero **sigan enteros**.',
      // FR: Sors-les à l'écumoire et remplis des bocaux propres jusqu'à 2 cm du bord.
      'Sácalos con una espumadera y llena tarros limpios hasta 2 cm del borde.',
      // FR: Fais réduire le sirop 5 minutes à feu vif.
      'Reduce el almíbar 5 minutos a fuego vivo.',
      // FR: Verse-le bouillant pour **couvrir entièrement** le potiron, ferme, laisse refroidir et range au réfrigérateur.
      'Viértelo hirviendo para **cubrir por completo** la calabaza, cierra, deja enfriar y guarda en la nevera.',
    ],
  ),
  'potiron/Soupe de potiron au lait de coco': RecipeText(
    // FR: Soupe de potiron au lait de coco
    name: 'Sopa de calabaza con leche de coco',
    // FR: Le lait de coco adoucit le potiron et lui donne du corps.
    description: 'La leche de coco suaviza la calabaza y le da cuerpo.',
    ingredients: <String>[
      '1 kg de calabaza', // FR: 1 kg de potiron
      '40 cl de leche de coco', // FR: 40 cl de lait de coco
      '1 cebolla, 1 diente de ajo', // FR: 1 oignon, 1 gousse d'ail
      '1 cucharadita de jengibre rallado', // FR: 1 cuillère à café de gingembre râpé
      '50 cl de caldo, sal, pimienta', // FR: 50 cl de bouillon, sel, poivre
    ],
    steps: <String>[
      // FR: Épluche le potiron et coupe-le en gros cubes. Garde les graines : grillées au four, elles font un en-cas.
      'Pela la calabaza y córtala en cubos grandes. Guarda las semillas: tostadas al horno, son un tentempié.',
      // FR: Fais fondre oignon, ail et gingembre dans un peu d'huile.
      'Rehoga la cebolla, el ajo y el jengibre en un poco de aceite.',
      // FR: Ajoute le potiron et le bouillon, à hauteur.
      'Añade la calabaza y el caldo, hasta cubrir.',
      // FR: Cuis 25 minutes à couvert.
      'Cuece 25 minutos tapado.',
      // FR: Verse le lait de coco, mixe, rectifie. Ne fais plus bouillir après : le coco se sépare.
      'Vierte la leche de coco, tritura y rectifica. No vuelvas a hervir después: el coco se corta.',
    ],
  ),
  'potiron/Gratin de potiron': RecipeText(
    // FR: Gratin de potiron
    name: 'Gratinado de calabaza',
    // FR: Fondant dessous, gratiné dessus, avec une pointe de muscade.
    description: 'Tierno por debajo, gratinado por encima, con un toque de nuez moscada.',
    ingredients: <String>[
      '1,2 kg de calabaza', // FR: 1,2 kg de potiron
      '20 cl de nata', // FR: 20 cl de crème
      '2 huevos', // FR: 2 oeufs
      '120 g de comté rallado', // FR: 120 g de comté râpé
      '2 cucharadas soperas de pan rallado, sal, pimienta, nuez moscada', // FR: 2 cuillères à soupe de chapelure, sel, poivre, muscade
    ],
    steps: <String>[
      // FR: Coupe le potiron en cubes et cuis-le 15 minutes.
      'Corta la calabaza en cubos y cuécela 15 minutos.',
      // FR: Égoutte-le très soigneusement et écrase-le à la fourchette : le potiron est gorgé d'eau.
      'Escúrrela con mucho cuidado y aplástala con un tenedor: la calabaza está llena de agua.',
      // FR: Mélange avec crème, oeufs, la moitié du fromage, muscade, sel, poivre.
      'Mezcla con la nata, los huevos, la mitad del queso, la nuez moscada, la sal y la pimienta.',
      // FR: Verse dans le plat, reste de fromage et chapelure par-dessus.
      'Vierte en la fuente, con el resto del queso y el pan rallado por encima.',
      // FR: Four à 180 °C, 40 minutes.
      'Horno a 180 °C, 40 minutos.',
    ],
  ),
  'potiron/Soupe au potiron': RecipeText(
    // FR: Soupe au potiron
    name: 'Sopa de calabaza',
    // FR: La version sans détour : potiron, pomme de terre, un peu de beurre.
    description: 'La versión directa: calabaza, patata, un poco de mantequilla.',
    ingredients: <String>[
      '800 g de calabaza', // FR: 800 g de potiron
      '2 patatas', // FR: 2 pommes de terre
      '1 cebolla', // FR: 1 oignon
      '80 cl de agua o de caldo', // FR: 80 cl d'eau ou de bouillon
      '30 g de mantequilla, sal, pimienta', // FR: 30 g de beurre, sel, poivre
    ],
    steps: <String>[
      // FR: Coupe potiron, pommes de terre et oignon en cubes.
      'Corta la calabaza, las patatas y la cebolla en cubos.',
      // FR: Mets tout dans la casserole, mouille à hauteur, sale.
      'Pon todo en la cazuela, moja hasta cubrir, sala.',
      // FR: Cuis 25 minutes, jusqu'à ce que tout s'écrase.
      'Cuece 25 minutos, hasta que todo se aplaste.',
      // FR: Mixe avec le beurre : c'est lui qui fait le velouté.
      'Tritura con la mantequilla: es ella la que da la cremosidad.',
    ],
  ),


  // ─────────── pourpier (6 recettes) ───────────
  'pourpier/Pourpier au vinaigre': RecipeText(
    // FR: Pourpier au vinaigre
    name: 'Verdolaga en vinagre',
    // FR: Comme on le faisait autrefois dans le Midi : les tiges charnues au vinaigre se croquent comme des cornichons.
    description: 'Como se hacía antiguamente en el Mediodía francés: los tallos carnosos en vinagre se comen crujientes como pepinillos.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '500 g de tallos y hojas de verdolaga', // FR: 500 g de tiges et feuilles de pourpier
      '25 cl de vinagre blanco al 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl de agua', // FR: 25 cl d'eau
      '10 g de sal, 15 g de azúcar', // FR: 10 g de sel, 15 g de sucre
      '1 diente de ajo, 1 cucharadita de granos de pimienta', // FR: 1 gousse d'ail, 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Lave le pourpier dans plusieurs eaux : il pousse au ras du sol et garde du sable.
      'Lava la verdolaga con varias aguas: crece pegada al suelo y se queda con arena.',
      // FR: Coupe-le en tronçons de 5 cm en gardant les feuilles attachées aux tiges.
      'Córtala en trozos de 5 cm dejando las hojas unidas a los tallos.',
      // FR: Tasse-le dans deux bocaux ébouillantés avec l'ail coupé en deux et le poivre.
      'Apriétala en dos tarros escaldados con el ajo cortado por la mitad y la pimienta.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre.
      'Hierve el vinagre, el agua, la sal y el azúcar.',
      // FR: Verse bouillant pour **couvrir entièrement** le pourpier, ferme et laisse refroidir.
      'Vierte el líquido hirviendo para **cubrir por completo** la verdolaga, cierra y deja enfriar.',
      // FR: Range au réfrigérateur et attends 3 jours avant d'y goûter.
      'Guárdala en la nevera y espera 3 días antes de probarla.',
    ],
  ),
  'pourpier/Pourpier blanchi congelé': RecipeText(
    // FR: Pourpier blanchi congelé
    name: 'Verdolaga escaldada y congelada',
    // FR: Une minute dans l'eau, et sa texture charnue t'attend pour les soupes et les omelettes d'hiver.
    description: 'Un minuto en el agua, y su textura carnosa te espera para las sopas y las tortillas de invierno.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 kg de verdolaga', // FR: 1 kg de pourpier
      'sal gorda', // FR: gros sel
      '1 ensaladera grande con agua y cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave le pourpier dans plusieurs eaux et retire les racines.
      'Lava la verdolaga con varias aguas y quita las raíces.',
      // FR: Coupe-le en tronçons de 3 cm.
      'Córtala en trozos de 3 cm.',
      // FR: Plonge-le dans une grande eau bouillante salée **1 minute**.
      'Sumérgela **1 minuto** en una olla grande de agua hirviendo con sal.',
      // FR: Transfère aussitôt dans l'eau glacée.
      'Pásala enseguida al agua con hielo.',
      // FR: Égoutte puis presse légèrement : il rend beaucoup d'eau.
      'Escúrrela y presiónala ligeramente: suelta mucha agua.',
      // FR: Mets en sacs d'une portion, à plat, et date-les.
      'Ponla en bolsas de una ración, planas, y anota la fecha.',
    ],
  ),
  'pourpier/Pourpier lacto-fermenté': RecipeText(
    // FR: Pourpier lacto-fermenté
    name: 'Verdolaga lactofermentada',
    // FR: En saumure quelques jours, il devient acidulé et garde son croquant juteux.
    description: 'En salmuera unos días, se vuelve acidulada y conserva su crujiente jugoso.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '600 g de verdolaga', // FR: 600 g de pourpier
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '2 dientes de ajo', // FR: 2 gousses d'ail
      'unas ramitas de eneldo', // FR: quelques brins d'aneth
    ],
    steps: <String>[
      // FR: Fais dissoudre **30 g de sel dans 1 litre d'eau** : saumure à 3 %.
      'Disuelve **30 g de sal en 1 litro de agua**: salmuera al 3 %.',
      // FR: Lave soigneusement le pourpier dans plusieurs eaux et égoutte-le.
      'Lava con cuidado la verdolaga con varias aguas y escúrrela.',
      // FR: Tasse-le en tronçons dans deux bocaux avec l'ail et l'aneth, jusqu'à 3 cm du bord.
      'Apriétala en trozos en dos tarros con el ajo y el eneldo, hasta 3 cm del borde.',
      // FR: Couvre de saumure et pose un poids pour que tout reste **sous la saumure**.
      'Cubre con la salmuera y pon un peso para que todo quede **bajo la salmuera**.',
      // FR: Ferme sans serrer et laisse fermenter 5 à 7 jours à 18–22 °C, sur une assiette.
      'Cierra sin apretar y deja fermentar de 5 a 7 días a 18–22 °C, sobre un plato.',
      // FR: Quand c'est acidulé, serre les couvercles et range au réfrigérateur.
      'Cuando esté acidulada, aprieta las tapas y guárdala en la nevera.',
    ],
  ),
  'pourpier/Salade de pourpier': RecipeText(
    // FR: Salade de pourpier
    name: 'Ensalada de verdolaga',
    // FR: Charnu et citronné, cru avec de la tomate et de la feta.
    description: 'Carnosa y con toque de limón, cruda con tomate y feta.',
  ),
  'pourpier/Pourpier sauté à l\'ail': RecipeText(
    // FR: Pourpier sauté à l'ail
    name: 'Verdolaga salteada con ajo',
    // FR: Quelques secondes à la poêle, pas plus.
    description: 'Unos segundos en la sartén, no más.',
  ),
  'pourpier/Soupe de pourpier à la turque': RecipeText(
    // FR: Soupe de pourpier à la turque
    name: 'Sopa de verdolaga a la turca',
    // FR: Avec du yaourt et du riz, acidulée et nourrissante.
    description: 'Con yogur y arroz, acidulada y reconfortante.',
  ),

  // ─────────── prunier (6 recettes) ───────────
  'prunier/Pruneaux maison': RecipeText(
    // FR: Pruneaux maison
    name: 'Ciruelas pasas caseras',
    // FR: Un prunier croule toujours d'un coup : séchées lentement, les prunes deviennent des pruneaux pour toute l'année.
    description: 'Un ciruelo siempre da todo de golpe: secadas despacio, las ciruelas se convierten en ciruelas pasas para todo el año.',
    // FR: 1 an en bocal, au sec
    keeps: '1 año en tarro, en lugar seco',
    ingredients: <String>[
      '3 kg de ciruelas d\'Ente o quetsche bien maduras', // FR: 3 kg de prunes d'Ente ou de quetsches bien mûres
      'rejillas de horno', // FR: des grilles de four
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Lave les prunes et garde seulement les plus mûres, celles qui se détachent toutes seules de l'arbre.
      'Lava las ciruelas y quédate solo con las más maduras, las que se sueltan solas del árbol.',
      // FR: Plonge-les **30 secondes** dans l'eau bouillante : la peau se fendille et l'eau s'évapore mieux.
      'Sumérgelas **30 segundos** en agua hirviendo: la piel se agrieta y el agua se evapora mejor.',
      // FR: Rafraîchis-les à l'eau froide, puis égoutte-les et sèche-les sur un torchon.
      'Refréscalas con agua fría, luego escúrrelas y sécalas con un paño.',
      // FR: Range-les entières sur des grilles et sèche au four à **60 °C**, porte entrouverte. Tu peux le faire en deux ou trois séances.
      'Colócalas enteras sobre rejillas y sécalas en el horno a **60 °C**, con la puerta entreabierta. Puedes hacerlo en dos o tres tandas.',
      // FR: Teste : le pruneau est ridé, souple, et ne laisse aucun jus quand tu le pinces.
      'Compruébalo: la ciruela pasa está arrugada, blanda, y no suelta nada de jugo cuando la aprietas.',
      // FR: Laisse refroidir et mets en bocal. Surveille la buée la première semaine, sinon remets au four.
      'Deja enfriar y pásalas a un tarro. Vigila el vaho la primera semana; si aparece, vuelven al horno.',
    ],
  ),
  'prunier/Moitiés de prunes au sirop': RecipeText(
    // FR: Moitiés de prunes au sirop
    name: 'Mitades de ciruela en almíbar',
    // FR: Quetsches ou reines-claudes en bocaux, prêtes pour une tarte d'hiver en dix minutes.
    description: 'Quetsches o claudias en tarros, listas para una tarta de invierno en diez minutos.',
    // FR: 1 an au placard, 5 jours ouvert au réfrigérateur
    keeps: '1 año en la despensa, 5 días abierto en la nevera',
    ingredients: <String>[
      '2 kg de ciruelas firmes', // FR: 2 kg de prunes fermes
      '1 litro de agua', // FR: 1 litre d'eau
      '300 g de azúcar', // FR: 300 g de sucre
      '5 tarros de 50 cl con juntas nuevas', // FR: 5 bocaux de 50 cl avec joints neufs
    ],
    steps: <String>[
      // FR: Lave les prunes et écarte celles qui sont abîmées ou trop molles.
      'Lava las ciruelas y aparta las que estén estropeadas o demasiado blandas.',
      // FR: Coupe-les en deux et retire le noyau.
      'Pártelas por la mitad y quita el hueso.',
      // FR: Porte l'eau et le sucre à ébullition 2 minutes pour faire le sirop.
      'Lleva el agua y el azúcar a ebullición durante 2 minutos para hacer el almíbar.',
      // FR: Range les moitiés côté peau vers l'extérieur, couvre de sirop chaud **jusqu'à 2 cm du bord** et ferme avec des joints neufs.
      'Coloca las mitades con la piel hacia fuera, cúbrelas con almíbar caliente **hasta 2 cm del borde** y cierra con juntas nuevas.',
      // FR: Stérilise les bocaux couverts d'eau, 25 minutes à partir de l'ébullition.
      'Esteriliza los tarros cubiertos de agua, 25 minutos desde que hierva.',
      // FR: Laisse refroidir dans l'eau, puis vérifie le vide. Un bocal qui n'a pas pris va au frais et se mange vite.
      'Deja enfriar en el agua y comprueba el vacío. Un tarro que no haya hecho vacío va a la nevera y se come pronto.',
    ],
  ),
  'prunier/Demi-prunes congelées': RecipeText(
    // FR: Demi-prunes congelées
    name: 'Mitades de ciruela congeladas',
    // FR: Dénoyautées et posées sur plaque, elles sortent du congélateur une à une pour une tarte ou un crumble.
    description: 'Deshuesadas y puestas en la bandeja, salen del congelador una a una para una tarta o un crumble.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de ciruelas maduras pero firmes', // FR: 2 kg de prunes mûres mais fermes
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave les prunes et sèche-les bien sur un torchon.
      'Lava las ciruelas y sécalas bien con un paño.',
      // FR: Coupe-les en deux et retire le noyau.
      'Pártelas por la mitad y quita el hueso.',
      // FR: Pose-les côté coupé vers le haut sur une plaque, **sans qu'elles se touchent**, et congèle 3 heures.
      'Colócalas con el lado cortado hacia arriba sobre una bandeja, **sin que se toquen**, y congela 3 horas.',
      // FR: Verse-les en sac une fois dures. Sur une tarte, pose-les encore congelées : elles rendent moins de jus.
      'Pásalas a una bolsa cuando estén duras. En una tarta, ponlas todavía congeladas: sueltan menos jugo.',
    ],
  ),
  'prunier/Tarte aux prunes': RecipeText(
    // FR: Tarte aux prunes
    name: 'Tarta de ciruelas',
    // FR: Coupées en deux, côté chair vers le haut, sur de la poudre d'amandes.
    description: 'Partidas por la mitad, con la carne hacia arriba, sobre almendra molida.',
  ),
  'prunier/Confiture de prunes': RecipeText(
    // FR: Confiture de prunes
    name: 'Mermelada de ciruela',
    // FR: Épaisse et foncée, la plus facile des confitures.
    description: 'Espesa y oscura, la más fácil de las mermeladas.',
  ),
  'prunier/Prunes rôties au thym': RecipeText(
    // FR: Prunes rôties au thym
    name: 'Ciruelas asadas con tomillo',
    // FR: Salées-sucrées, pour accompagner un canard.
    description: 'Entre dulce y salado, para acompañar un pato.',
  ),

  // ─────────── radis (6 recettes) ───────────
  'radis/Pickles de radis roses': RecipeText(
    // FR: Pickles de radis roses
    name: 'Pickles de rábanos rosas',
    // FR: Vingt minutes, et une botte qui allait ramollir devient un condiment rose vif pour tout le mois.
    description: 'Veinte minutos, y un manojo que iba a ablandarse se convierte en un condimento rosa intenso para todo el mes.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      '2 manojos de rábanos (unos 500 g)', // FR: 2 bottes de radis (environ 500 g)
      '25 cl de vinagre de sidra al 6 %', // FR: 25 cl de vinaigre de cidre à 6 %
      '25 cl de agua', // FR: 25 cl d'eau
      '1 cucharada de azúcar', // FR: 1 cuillère à soupe de sucre
      '1 cucharadita de sal fina', // FR: 1 cuillère à café de sel fin
      '1 cucharadita de semillas de mostaza', // FR: 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Coupe les fanes (garde-les pour une soupe) et frotte les radis sous l'eau.
      'Corta las hojas (guárdalas para una sopa) y frota los rábanos bajo el agua.',
      // FR: Tranche-les en fines rondelles, ou en quatre s'ils sont petits.
      'Córtalos en rodajas finas, o en cuatro si son pequeños.',
      // FR: Tasse-les dans deux bocaux propres avec les graines de moutarde.
      'Apriétalos en dos tarros limpios con las semillas de mostaza.',
      // FR: Porte à ébullition vinaigre, eau, sucre et sel, juste le temps de tout dissoudre.
      'Lleva a ebullición el vinagre, el agua, el azúcar y la sal, solo el tiempo justo para disolverlo todo.',
      // FR: Verse bouillant sur les radis jusqu'à **les couvrir entièrement**, ferme et laisse refroidir.
      'Vierte el líquido hirviendo sobre los rábanos hasta **cubrirlos por completo**, cierra y deja enfriar.',
      // FR: Range au réfrigérateur. Ils sont bons dès le lendemain, et le rose passe dans le liquide : c'est normal.
      'Guárdalos en la nevera. Están buenos desde el día siguiente, y el rosa pasa al líquido: es normal.',
    ],
  ),
  'radis/Radis lacto-fermentés': RecipeText(
    // FR: Radis lacto-fermentés
    name: 'Rábanos lactofermentados',
    // FR: Dans une simple saumure, ils deviennent acidulés et piquants, et gardent leur croquant des semaines.
    description: 'En una simple salmuera se vuelven acidulados y picantes, y conservan su crujiente durante semanas.',
    // FR: 3 mois au réfrigérateur
    keeps: '3 meses en la nevera',
    ingredients: <String>[
      '600 g de rábanos', // FR: 600 g de radis
      '1 litro de agua sin cloro', // FR: 1 litre d'eau non chlorée
      '30 g de sal sin yodo', // FR: 30 g de sel non iodé
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '1 cucharadita de granos de pimienta', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Dissous **30 g de sel dans 1 litre d'eau** : c'est la saumure à 3 %, ni plus ni moins.
      'Disuelve **30 g de sal en 1 litro de agua**: es la salmuera al 3 %, ni más ni menos.',
      // FR: Frotte les radis, coupe la racine et la queue, laisse-les entiers ou coupe les gros en deux.
      'Frota los rábanos, corta la raíz y el rabito, déjalos enteros o parte los grandes por la mitad.',
      // FR: Tasse-les dans un bocal avec l'ail écrasé et le poivre, jusqu'à 3 cm du bord.
      'Apriétalos en un tarro con el ajo machacado y la pimienta, hasta 3 cm del borde.',
      // FR: Verse la saumure pour **couvrir entièrement** et pose un poids dessus (un petit pot rempli d'eau). Rien ne doit dépasser.
      'Vierte la salmuera para **cubrirlos por completo** y pon un peso encima (un tarrito lleno de agua). No debe asomar nada.',
      // FR: Ferme sans serrer et laisse une semaine à 18–22 °C, à l'abri du soleil. Des petites bulles, c'est bon signe.
      'Cierra sin apretar y deja una semana a 18–22 °C, al abrigo del sol. Unas burbujitas son buena señal.',
      // FR: Goûte : quand c'est assez acide, serre le couvercle et passe au réfrigérateur pour freiner la fermentation.
      'Prueba: cuando esté lo bastante ácido, aprieta la tapa y pásalo a la nevera para frenar la fermentación.',
    ],
  ),
  'radis/Soupe de fanes de radis à congeler': RecipeText(
    // FR: Soupe de fanes de radis à congeler
    name: 'Sopa de hojas de rábano para congelar',
    // FR: Les fanes partent souvent au compost : en soupe congelée, elles font un repas gratuit en hiver.
    description: 'Las hojas suelen acabar en el compost: en sopa congelada, son una comida gratis en invierno.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      'las hojas de 3 manojos de rábanos', // FR: les fanes de 3 bottes de radis
      '2 patatas', // FR: 2 pommes de terre
      '1 cebolla', // FR: 1 oignon
      '1 litro de caldo', // FR: 1 litre de bouillon
      '1 nuez de mantequilla, sal, pimienta', // FR: 1 noix de beurre, sel, poivre
    ],
    steps: <String>[
      // FR: Lave les fanes dans plusieurs eaux et jette les feuilles jaunies ou abîmées.
      'Lava las hojas con varias aguas y tira las hojas amarillentas o estropeadas.',
      // FR: Fais fondre l'oignon émincé au beurre, sans le colorer.
      'Rehoga la cebolla picada en la mantequilla, sin que se dore.',
      // FR: Ajoute les pommes de terre en dés et le bouillon, laisse cuire à couvert.
      'Añade las patatas en dados y el caldo, y deja cocer tapado.',
      // FR: Jette les fanes et compte **3 minutes**, pas plus, pour garder le vert.
      'Echa las hojas y cuenta **3 minutos**, no más, para conservar el verde.',
      // FR: Mixe hors du feu, sale et poivre. Pas de crème : tu l'ajouteras au réchauffage.
      'Tritura fuera del fuego, sala y pimienta. Nada de nata: la añadirás al recalentar.',
      // FR: Refroidis vite la casserole dans l'eau froide, puis répartis en boîtes en laissant 2 cm de vide et congèle.
      'Enfría rápido la cacerola en agua fría, luego reparte en recipientes dejando 2 cm de vacío y congela.',
    ],
  ),
  'radis/Radis beurre-sel': RecipeText(
    // FR: Radis beurre-sel
    name: 'Rábanos con mantequilla y sal',
    // FR: Cueillis le matin, croqués à midi : rien ne bat la simplicité.
    description: 'Cogidos por la mañana, a mordiscos al mediodía: nada supera esta sencillez.',
  ),
  'radis/Pesto de fanes de radis': RecipeText(
    // FR: Pesto de fanes de radis
    name: 'Pesto de hojas de rábano',
    // FR: Les fanes ne se jettent pas : mixées à l'huile et aux amandes, elles font un pesto piquant.
    description: 'Las hojas no se tiran: trituradas con aceite y almendras, dan un pesto picante.',
    ingredients: <String>[
      'Las hojas de un manojo de rábanos', // FR: Les fanes d'une botte de radis
      '50 g de almendras o nueces', // FR: 50 g d'amandes ou de noix
      '50 g de parmesano', // FR: 50 g de parmesan
      '10 cl de aceite de oliva', // FR: 10 cl d'huile d'olive
      '1 diente de ajo, sal', // FR: 1 gousse d'ail, sel
    ],
    steps: <String>[
      // FR: Trie les fanes : garde les feuilles tendres, jette les tiges dures et les feuilles jaunies.
      'Selecciona las hojas: quédate con las tiernas, tira los tallos duros y las hojas amarillas.',
      // FR: Lave-les à grande eau et essore-les bien — un pesto mouillé tourne vite.
      'Lávalas con abundante agua y escúrrelas muy bien: un pesto mojado se estropea pronto.',
      // FR: Mixe les fanes avec l'ail, les amandes et le parmesan, par à-coups.
      'Tritura las hojas con el ajo, las almendras y el parmesano, a golpes cortos.',
      // FR: Verse l'huile en filet, moteur tournant, jusqu'à la texture qui te plaît. Sale.
      'Añade el aceite en hilo, con la batidora en marcha, hasta la textura que te guste. Sala.',
      // FR: En bocal, couvert d'huile, il tient une semaine au frais.
      'En un tarro, cubierto de aceite, aguanta una semana en un lugar fresco.',
    ],
  ),
  'radis/Radis rôtis au four': RecipeText(
    // FR: Radis rôtis au four
    name: 'Rábanos asados al horno',
    // FR: La cuisson les adoucit : ils deviennent doux comme des navets.
    description: 'La cocción los suaviza: quedan dulces como los nabos.',
  ),

  // ─────────── radis_noir (6 recettes) ───────────
  'radis_noir/Radis noir râpé lacto-fermenté': RecipeText(
    // FR: Radis noir râpé lacto-fermenté
    name: 'Rábano negro rallado lactofermentado',
    // FR: Fermenté, il perd son piquant agressif et devient un condiment acidulé pour les salades et les tartines.
    description: 'Fermentado, pierde su picante agresivo y se convierte en un condimento acidulado para ensaladas y tostadas.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 meses en la nevera',
    ingredients: <String>[
      '1 kg de rábano negro', // FR: 1 kg de radis noir
      '20 g de sal fina sin yodo (20 g por kg)', // FR: 20 g de sel fin non iodé (20 g par kg)
      '1 zanahoria', // FR: 1 carotte
      '2 tarros de 50 cl', // FR: 2 bocaux de 50 cl
    ],
    steps: <String>[
      // FR: Brosse les radis sous l'eau. Tu peux garder la peau noire, ou l'enlever pour un goût plus doux.
      'Cepilla los rábanos bajo el agua. Puedes dejar la piel negra o quitarla para un sabor más suave.',
      // FR: Râpe le radis et la carotte gros, puis pèse le tout.
      'Ralla grueso el rábano y la zanahoria, y pesa todo.',
      // FR: Ajoute **20 g de sel par kilo** de légumes râpés et malaxe jusqu'à ce que le jus sorte.
      'Añade **20 g de sal por kilo** de verdura rallada y amasa hasta que suelte el jugo.',
      // FR: Tasse fort dans les bocaux pour faire remonter le jus au-dessus, en laissant 3 cm de vide.
      'Apriétalo con fuerza en los tarros para que el jugo suba por encima, dejando 3 cm de vacío.',
      // FR: Pose un poids pour que **tout reste sous le jus**, et ferme sans serrer.
      'Pon un peso para que **todo quede bajo el jugo**, y cierra sin apretar.',
      // FR: Laisse fermenter 1 à 2 semaines à 18–22 °C. Ça sent fort le soufre au début : c'est normal, ça s'adoucit.
      'Deja fermentar de 1 a 2 semanas a 18–22 °C. Al principio huele fuerte a azufre: es normal, se suaviza.',
      // FR: Quand c'est acidulé, serre les couvercles et range au réfrigérateur.
      'Cuando esté acidulado, aprieta las tapas y guárdalo en la nevera.',
    ],
  ),
  'radis_noir/Rondelles de radis noir au vinaigre': RecipeText(
    // FR: Rondelles de radis noir au vinaigre
    name: 'Rodajas de rábano negro en vinagre',
    // FR: Un quart d'heure, et ses rondelles marbrées de noir deviennent un pickle croquant qui se garde au frais.
    description: 'Un cuarto de hora, y sus rodajas jaspeadas de negro se convierten en un pickle crujiente que se conserva en la nevera.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '600 g de rábano negro', // FR: 600 g de radis noir
      '25 cl de vinagre blanco al 8 %', // FR: 25 cl de vinaigre blanc à 8 %
      '25 cl de agua', // FR: 25 cl d'eau
      '10 g de sal, 30 g de azúcar', // FR: 10 g de sel, 30 g de sucre
      '1 cucharadita de granos de pimienta', // FR: 1 cuillère à café de grains de poivre
    ],
    steps: <String>[
      // FR: Brosse bien les radis, garde la peau : c'est elle qui fait le joli liseré noir.
      'Cepilla bien los rábanos y deja la piel: ella hace el bonito ribete negro.',
      // FR: Coupe-les en rondelles fines de 3 mm.
      'Córtalos en rodajas finas de 3 mm.',
      // FR: Remplis deux bocaux ébouillantés avec les rondelles et le poivre.
      'Llena dos tarros escaldados con las rodajas y la pimienta.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre.
      'Hierve el vinagre, el agua, la sal y el azúcar.',
      // FR: Verse bouillant pour **couvrir entièrement**, ferme et laisse refroidir avant de ranger au réfrigérateur.
      'Vierte el líquido hirviendo para **cubrir por completo**, cierra y deja enfriar antes de guardar en la nevera.',
    ],
  ),
  'radis_noir/Radis noir séché en lanières': RecipeText(
    // FR: Radis noir séché en lanières
    name: 'Rábano negro seco en tiras',
    // FR: Comme au Japon avec le daïkon : séché en lanières, il se garde des mois et se réhydrate en dix minutes pour les soupes.
    description: 'Como en Japón con el daikon: seco en tiras, se conserva meses y se rehidrata en diez minutos para las sopas.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegido de la luz',
    ingredients: <String>[
      '1,5 kg de rábano negro', // FR: 1,5 kg de radis noir
      'rejillas o bandejas', // FR: des grilles ou plaques
      'tarros bien secos', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Épluche les radis et taille-les en fines lanières de 3 mm, comme des allumettes longues.
      'Pela los rábanos y córtalos en tiras finas de 3 mm, como cerillas largas.',
      // FR: Étale-les en couche fine sur des grilles et enfourne à 55 °C, porte entrouverte d'une cuillère en bois.
      'Extiéndelas en capa fina sobre rejillas y mételas al horno a 55 °C, con la puerta entreabierta con una cuchara de madera.',
      // FR: Remue-les toutes les heures. Elles sont prêtes quand elles sont sèches, souples comme du cuir et ne collent plus.
      'Remuévelas cada hora. Están listas cuando están secas, flexibles como el cuero y ya no se pegan.',
      // FR: Laisse-les refroidir et sécher encore une nuit à l'air libre sur un torchon.
      'Déjalas enfriar y secar una noche más al aire libre sobre un paño.',
      // FR: Mets en bocaux bien secs. Pour les utiliser, trempe-les 10 minutes dans l'eau tiède.
      'Guárdalas en tarros bien secos. Para usarlas, remójalas 10 minutos en agua tibia.',
    ],
  ),
  'radis_noir/Carpaccio de radis noir': RecipeText(
    // FR: Carpaccio de radis noir
    name: 'Carpaccio de rábano negro',
    // FR: Tranché à la mandoline, huile de noix, fleur de sel.
    description: 'Cortado con mandolina, aceite de nuez, flor de sal.',
  ),
  'radis_noir/Radis noir râpé à la pomme': RecipeText(
    // FR: Radis noir râpé à la pomme
    name: 'Rábano negro rallado con manzana',
    // FR: La pomme adoucit son piquant.
    description: 'La manzana suaviza su picante.',
  ),
  'radis_noir/Radis noir confit au four': RecipeText(
    // FR: Radis noir confit au four
    name: 'Rábano negro confitado al horno',
    // FR: Il perd son amertume et devient presque sucré.
    description: 'Pierde su amargor y queda casi dulce.',
  ),

  // ─────────── rhubarbe (6 recettes) ───────────
  'rhubarbe/Tronçons de rhubarbe congelés': RecipeText(
    // FR: Tronçons de rhubarbe congelés
    name: 'Trozos de ruibarbo congelados',
    // FR: Crue, coupée et congelée : la rhubarbe ne demande rien d'autre, et elle sera prête pour toutes tes tartes.
    description: 'Cruda, cortada y congelada: el ruibarbo no pide nada más, y estará lista para todas tus tartas.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      '2 kg de tallos de ruibarbo', // FR: 2 kg de tiges de rhubarbe
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe et jette **toutes les feuilles** : elles ne se mangent pas. Retire aussi le pied blanc.
      'Corta y tira **todas las hojas**: no se comen. Quita también la base blanca.',
      // FR: Rince les tiges et essuie-les bien.
      'Enjuaga los tallos y sécalos bien.',
      // FR: Retire les fils des grosses tiges en tirant avec un couteau, puis coupe en tronçons de 2 cm.
      'Quita las hebras de los tallos gruesos tirando con un cuchillo, y corta en trozos de 2 cm.',
      // FR: Étale sur une plaque et congèle 2 heures pour qu'ils ne se soudent pas.
      'Extiéndelos en una bandeja y congela 2 horas para que no se peguen entre sí.',
      // FR: Verse-les en sacs par 500 g, la dose d'une tarte ou d'un crumble. Ils s'utilisent sans décongeler.
      'Pásalos a bolsas de 500 g, la dosis de una tarta o de un crumble. Se usan sin descongelar.',
    ],
  ),
  'rhubarbe/Confiture de rhubarbe au gingembre': RecipeText(
    // FR: Confiture de rhubarbe au gingembre
    name: 'Mermelada de ruibarbo y jengibre',
    // FR: Une nuit de macération dans le sucre, une pointe de gingembre, et la rhubarbe devient une confiture vive et fondante.
    description: 'Una noche macerando en azúcar, una pizca de jengibre, y el ruibarbo se convierte en una mermelada viva y fundente.',
    // FR: 1 an au placard
    keeps: '1 año en la despensa',
    ingredients: <String>[
      '1,5 kg de ruibarbo pelado', // FR: 1,5 kg de rhubarbe épluchée
      '1 kg de azúcar', // FR: 1 kg de sucre
      'el zumo de un limón', // FR: le jus d'un citron
      '1 trozo de jengibre fresco de 4 cm', // FR: 1 morceau de gingembre frais de 4 cm
    ],
    steps: <String>[
      // FR: Jette les feuilles, retire les fils et coupe les tiges en tronçons de 1 cm.
      'Tira las hojas, quita las hebras y corta los tallos en trozos de 1 cm.',
      // FR: Mélange-les au sucre et au citron dans une bassine, couvre et laisse macérer une nuit : le jus sort tout seul.
      'Mézclalos con el azúcar y el limón en una olla ancha, tapa y deja macerar una noche: el jugo sale solo.',
      // FR: Épluche le gingembre et râpe-le finement dans la bassine.
      'Pela el jengibre y rállalo fino en la olla.',
      // FR: Porte à ébullition et cuis à feu vif en remuant et en écumant.
      'Lleva a ebullición y cuece a fuego fuerte, removiendo y espumando.',
      // FR: Teste une goutte sur une assiette froide : si elle se fige et se ride sous le doigt, c'est prêt.
      'Prueba una gota en un plato frío: si cuaja y se arruga al tocarla con el dedo, está lista.',
      // FR: Mets en pots ébouillantés remplis jusqu'à 1 cm du bord, ferme aussitôt et retourne jusqu'à refroidissement.
      'Pásala a tarros escaldados llenos hasta 1 cm del borde, cierra enseguida y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'rhubarbe/Rhubarbe au sirop en bocaux': RecipeText(
    // FR: Rhubarbe au sirop en bocaux
    name: 'Ruibarbo en almíbar en tarros',
    // FR: Acide comme un fruit, la rhubarbe supporte très bien le bocal : des tronçons entiers prêts à servir sur un yaourt.
    description: 'Ácido como una fruta, el ruibarbo aguanta muy bien el tarro: trozos enteros listos para servir sobre un yogur.',
    // FR: 1 an au placard
    keeps: '1 año en la despensa',
    ingredients: <String>[
      '1,5 kg de ruibarbo', // FR: 1,5 kg de rhubarbe
      '1 litro de agua', // FR: 1 litre d'eau
      '300 g de azúcar', // FR: 300 g de sucre
      'tarros con juntas o tapas nuevas', // FR: des bocaux à joints ou couvercles neufs
    ],
    steps: <String>[
      // FR: Jette les feuilles, retire les fils et coupe les tiges en tronçons de 3 cm.
      'Tira las hojas, quita las hebras y corta los tallos en trozos de 3 cm.',
      // FR: Fais bouillir l'eau et le sucre 2 minutes pour obtenir un sirop léger.
      'Hierve el agua y el azúcar 2 minutos para obtener un almíbar ligero.',
      // FR: Tasse la rhubarbe crue dans des bocaux propres, puis verse le sirop chaud jusqu'à **2 cm du bord**.
      'Aprieta el ruibarbo crudo en tarros limpios y vierte el almíbar caliente hasta **2 cm del borde**.',
      // FR: Tapote les bocaux pour chasser les bulles, essuie le bord et ferme avec des joints ou couvercles neufs.
      'Golpea suavemente los tarros para sacar las burbujas, limpia el borde y cierra con juntas o tapas nuevas.',
      // FR: Pose-les dans un grand faitout, couvre-les d'eau et stérilise **20 minutes à partir de l'ébullition**.
      'Colócalos en una olla grande, cúbrelos de agua y esteriliza **20 minutos desde que hierva**.',
      // FR: Laisse refroidir dans l'eau, puis vérifie le vide : couvercle creux, c'est bon. Sinon, au réfrigérateur et à manger vite.
      'Deja enfriar en el agua y comprueba el vacío: tapa hundida, todo bien. Si no, a la nevera y a comerlos pronto.',
    ],
  ),
  'rhubarbe/Tarte à la rhubarbe': RecipeText(
    // FR: Tarte à la rhubarbe
    name: 'Tarta de ruibarbo',
    // FR: Acide et sucrée, sur une pâte brisée avec un appareil à la crème.
    description: 'Ácida y dulce, sobre una masa quebrada con un relleno cremoso.',
    ingredients: <String>[
      '800 g de tallos de ruibarbo', // FR: 800 g de tiges de rhubarbe
      '1 masa quebrada', // FR: 1 pâte brisée
      '150 g de azúcar', // FR: 150 g de sucre
      '2 huevos, 20 cl de nata', // FR: 2 œufs, 20 cl de crème
      '1 cucharada de almendra molida', // FR: 1 c. à s. de poudre d'amandes
    ],
    steps: <String>[
      // FR: Coupe la rhubarbe en tronçons de 2 cm. Pas besoin de l'éplucher si les tiges sont jeunes.
      'Corta el ruibarbo en trozos de 2 cm. No hace falta pelarlo si los tallos son jóvenes.',
      // FR: Saupoudre-la de la moitié du sucre et laisse dégorger : tu jetteras l'eau rendue, sinon la tarte détrempe.
      'Espolvoréalo con la mitad del azúcar y déjalo soltar el agua: tirarás el líquido que suelte, si no la tarta se empapa.',
      // FR: Étale la pâte, pique-la, saupoudre le fond de poudre d'amandes — elle boira le jus restant.
      'Extiende la masa, pínchala y espolvorea el fondo con almendra molida: absorberá el jugo que quede.',
      // FR: Bats les œufs, la crème et le reste du sucre. Range la rhubarbe, verse l'appareil.
      'Bate los huevos, la nata y el resto del azúcar. Coloca el ruibarbo y vierte la mezcla.',
      // FR: Four à 180 °C jusqu'à ce que la crème soit prise et dorée.
      'Horno a 180 °C hasta que la nata cuaje y se dore.',
    ],
  ),
  'rhubarbe/Compote de rhubarbe': RecipeText(
    // FR: Compote de rhubarbe
    name: 'Compota de ruibarbo',
    // FR: À peine sucrée, sur un fromage blanc.
    description: 'Apenas azucarada, sobre queso fresco.',
  ),
  'rhubarbe/Crumble rhubarbe-fraise': RecipeText(
    // FR: Crumble rhubarbe-fraise
    name: 'Crumble de ruibarbo y fresa',
    // FR: L'acidité de l'une, le sucre de l'autre, du beurre dessus.
    description: 'La acidez de una, el azúcar de la otra, y mantequilla por encima.',
  ),

  // ─────────── romarin (6 recettes) ───────────
  'romarin/Romarin séché en bottes': RecipeText(
    // FR: Romarin séché en bottes
    name: 'Romero seco en manojos',
    // FR: Le romarin pousse toute l'année, mais une botte séchée sous la main évite d'aller au jardin sous la pluie.
    description: 'El romero crece todo el año, pero un manojo seco a mano evita salir al huerto bajo la lluvia.',
    // FR: 1 an en bocal, à l'abri de la lumière
    keeps: '1 año en tarro, protegido de la luz',
    ingredients: <String>[
      'un buen puñado de ramas de romero', // FR: une brassée de branches de romarin
      'cordel de cocina', // FR: de la ficelle de cuisine
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Coupe des branches de 15 cm sur les pousses de l'année, en fin de matinée par temps sec.
      'Corta ramas de 15 cm de los brotes del año, a media mañana y con tiempo seco.',
      // FR: Ne les lave que si elles sont sales, et sèche-les bien sur un torchon.
      'Solo las lavas si están sucias, y sécalas bien con un paño.',
      // FR: Lie-les en petites bottes d'une dizaine de branches, bien serrées.
      'Átalas en manojitos de una decena de ramas, bien apretados.',
      // FR: Suspends-les tête en bas dans un endroit sec, sombre et aéré, pendant 10 jours.
      'Cuélgalos boca abajo en un lugar seco, oscuro y ventilado durante 10 días.',
      // FR: Teste : les aiguilles se détachent en passant les doigts le long de la tige et se cassent net.
      'Compruébalo: las agujas se sueltan al pasar los dedos a lo largo del tallo y se rompen limpiamente.',
      // FR: Égrène les aiguilles en bocal fermé. **Garde-les entières** et écrase-les au moment de cuisiner : le parfum reste dedans.
      'Desgrana las agujas en un tarro cerrado. **Guárdalas enteras** y machácalas al cocinar: el aroma se queda dentro.',
    ],
  ),
  'romarin/Gelée pomme-romarin': RecipeText(
    // FR: Gelée pomme-romarin
    name: 'Gelatina de manzana y romero',
    // FR: La gelée des Anglais pour l'agneau : la pomme fait prendre, le romarin parfume.
    description: 'La gelatina de los ingleses para el cordero: la manzana hace cuajar, el romero perfuma.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierto en la nevera',
    ingredients: <String>[
      '1,5 kg de manzanas ácidas', // FR: 1,5 kg de pommes acidulées
      '1,5 litros de agua', // FR: 1,5 litre d'eau
      '800 g de azúcar por litro de zumo', // FR: 800 g de sucre par litre de jus
      'el zumo de un limón', // FR: le jus d'un citron
      '4 ramas de romero', // FR: 4 branches de romarin
      '6 tarritos de mermelada', // FR: 6 petits pots de confiture
    ],
    steps: <String>[
      // FR: Coupe les pommes en morceaux **avec peau et pépins** : c'est là qu'est la pectine.
      'Corta las manzanas en trozos **con piel y pepitas**: ahí está la pectina.',
      // FR: Cuis-les dans l'eau à couvert, jusqu'à ce qu'elles soient en bouillie.
      'Cuécelas en el agua, tapadas, hasta que se deshagan.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse égoutter **sans presser**, pour une gelée limpide.
      'Vierte en un paño limpio colocado sobre un colador y deja escurrir **sin apretar**, para una gelatina limpia.',
      // FR: Mesure le jus, ajoute 800 g de sucre par litre, le citron et les branches de romarin, puis porte à ébullition.
      'Mide el zumo, añade 800 g de azúcar por litro, el limón y las ramas de romero, y lleva a ebullición.',
      // FR: Cuis à gros bouillons en écumant, puis teste sur une assiette froide : une goutte qui se fige est prête.
      'Cuece a borbotones espumando, y prueba en un plato frío: una gota que cuaja indica que está lista.',
      // FR: Retire les branches, ajoute une pincée d'aiguilles hachées, mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Retira las ramas, añade una pizca de agujas picadas, pasa a tarros escaldados, cierra y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'romarin/Romarin haché en cubes': RecipeText(
    // FR: Romarin haché en cubes
    name: 'Cubitos de romero picado',
    // FR: Haché une fois, congelé à l'huile d'olive : un cube pour des pommes de terre sautées ou un rôti.
    description: 'Picado una vez y congelado en aceite de oliva: un cubito para unas patatas salteadas o un asado.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '6 ramas de romero', // FR: 6 branches de romarin
      '15 cl de aceite de oliva', // FR: 15 cl d'huile d'olive
      'una cubitera', // FR: un bac à glaçons
      'una bolsa de congelación', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Rince les branches et **sèche-les parfaitement** sur un torchon.
      'Enjuaga las ramas y **sécalas perfectamente** con un paño.',
      // FR: Égrène les aiguilles et hache-les finement : entières, elles restent dures sous la dent.
      'Desgrana las agujas y pícalas finas: enteras, se quedan duras al masticar.',
      // FR: Mets une cuillère à soupe d'aiguilles par case et couvre d'huile d'olive.
      'Pon una cucharada de agujas en cada hueco y cubre con aceite de oliva.',
      // FR: Congèle jusqu'à ce que ce soit bien dur.
      'Congela hasta que esté bien duro.',
      // FR: Démoule et garde en sac. Le cube va **directement dans la poêle ou le plat**, sans attendre à température ambiante.
      'Desmolda y guarda en una bolsa. El cubito va **directamente a la sartén o a la fuente**, sin esperar a temperatura ambiente.',
    ],
  ),
  'romarin/Pommes de terre au romarin': RecipeText(
    // FR: Pommes de terre au romarin
    name: 'Patatas al romero',
    // FR: En quartiers, gros sel, branches entières au four.
    description: 'En gajos, sal gorda, ramas enteras al horno.',
  ),
  'romarin/Sirop de romarin': RecipeText(
    // FR: Sirop de romarin
    name: 'Almíbar de romero',
    // FR: Pour un citron pressé ou un cocktail sans alcool.
    description: 'Para un limón exprimido o un cóctel sin alcohol.',
  ),
  'romarin/Focaccia au romarin': RecipeText(
    // FR: Focaccia au romarin
    name: 'Focaccia de romero',
    // FR: Les aiguilles enfoncées dans la pâte avant cuisson.
    description: 'Las agujas, hundidas en la masa antes de hornear.',
  ),

  // ─────────── roquette (6 recettes) ───────────
  'roquette/Cubes de roquette à l\'huile': RecipeText(
    // FR: Cubes de roquette à l'huile
    name: 'Cubitos de rúcula con aceite',
    // FR: Quand la roquette monte toute d'un coup, mixée et congelée elle relève une soupe ou une sauce en un cube.
    description: 'Cuando la rúcula se espiga de golpe, triturada y congelada realza una sopa o una salsa con un solo cubito.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '300 g de rúcula', // FR: 300 g de roquette
      '10 cl de aceite de oliva', // FR: 10 cl d'huile d'olive
      '1 pizca de sal', // FR: 1 pincée de sel
      'una cubitera', // FR: un bac à glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Lave la roquette et **sèche-la bien** à l'essoreuse : l'eau fait des cubes givrés et fades.
      'Lava la rúcula y **sécala bien** en la centrifugadora: el agua hace cubitos escarchados e insípidos.',
      // FR: Retire les tiges les plus dures et les feuilles jaunies.
      'Quita los tallos más duros y las hojas amarillentas.',
      // FR: Mixe par à-coups avec l'huile et le sel, jusqu'à une purée grossière.
      'Tritura a golpes cortos con el aceite y la sal, hasta obtener un puré grueso.',
      // FR: Remplis le bac à glaçons, tasse bien et congèle jusqu'à ce que ce soit dur.
      'Llena la cubitera, aprieta bien y congela hasta que esté duro.',
      // FR: Démoule les cubes et garde-les en sac. Utilise-les **directement gelés**, sans les laisser dégeler à l'air.
      'Desmolda los cubitos y guárdalos en una bolsa. Úsalos **directamente congelados**, sin dejar que se descongelen al aire.',
    ],
  ),
  'roquette/Roquette fondue à congeler': RecipeText(
    // FR: Roquette fondue à congeler
    name: 'Rúcula pochada para congelar',
    // FR: Juste tombée à la poêle et pressée, la roquette perd son volume mais garde son piquant pour l'hiver.
    description: 'Apenas ablandada en la sartén y escurrida, la rúcula pierde volumen pero conserva su picante para el invierno.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '800 g de rúcula', // FR: 800 g de roquette
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '2 cucharadas de aceite de oliva', // FR: 2 cuillères à soupe d'huile d'olive
      'sal', // FR: sel
    ],
    steps: <String>[
      // FR: Lave la roquette dans plusieurs eaux et égoutte-la grossièrement.
      'Lava la rúcula con varias aguas y escúrrela a grandes rasgos.',
      // FR: Fais chauffer l'huile avec l'ail écrasé une minute, sans le laisser brunir.
      'Calienta el aceite con el ajo machacado durante un minuto, sin dejar que se dore.',
      // FR: Jette la roquette par poignées et remue jusqu'à ce qu'elle tombe, **2 minutes** en tout.
      'Echa la rúcula a puñados y remueve hasta que se ablande, **2 minutos** en total.',
      // FR: Sale légèrement, retire l'ail et laisse refroidir dans une passoire.
      'Sala ligeramente, retira el ajo y deja enfriar en un colador.',
      // FR: Presse fort pour chasser le jus, puis forme des galets d'une portion.
      'Aprieta fuerte para sacar el jugo y forma bolitas de una ración.',
      // FR: Congèle-les sur une plaque, puis mets-les en sac. Parfaits dans des pâtes, une omelette ou une pizza.
      'Congélalas en una bandeja y luego pásalas a una bolsa. Perfectas en pasta, en una tortilla o en una pizza.',
    ],
  ),
  'roquette/Poudre de roquette séchée': RecipeText(
    // FR: Poudre de roquette séchée
    name: 'Rúcula seca en polvo',
    // FR: Séchée doucement et réduite en poudre, elle saupoudre les œufs, le fromage frais et les soupes d'un piquant poivré.
    description: 'Seca despacio y reducida a polvo, espolvorea huevos, queso fresco y sopas con un picante pimentado.',
    // FR: 6 mois au sec, à l'abri de la lumière
    keeps: '6 meses en seco, protegido de la luz',
    ingredients: <String>[
      '400 g de rúcula', // FR: 400 g de roquette
      'papel de horno', // FR: du papier cuisson
      'un tarro pequeño de cristal bien seco', // FR: un petit pot en verre bien sec
    ],
    steps: <String>[
      // FR: Lave la roquette et sèche-la parfaitement à l'essoreuse puis au torchon.
      'Lava la rúcula y sécala perfectamente con la centrifugadora y luego con un paño.',
      // FR: Retire les grosses tiges, elles sèchent bien plus lentement que les feuilles.
      'Quita los tallos gruesos: se secan mucho más despacio que las hojas.',
      // FR: Étale les feuilles en une seule couche et sèche au four à **50 °C**, porte entrouverte.
      'Extiende las hojas en una sola capa y sécalas en el horno a **50 °C**, con la puerta entreabierta.',
      // FR: Elles sont prêtes quand elles **crissent** et s'émiettent. Souples, laisse-les encore.
      'Están listas cuando **crujen** y se desmenuzan. Si están blandas, déjalas más tiempo.',
      // FR: Une fois froides, émiette-les ou mixe-les en poudre, puis mets en pot bien fermé.
      'Una vez frías, desmenúzalas o tritúralas hasta hacerlas polvo, y pásalo a un tarro bien cerrado.',
    ],
  ),
  'roquette/Pesto de roquette': RecipeText(
    // FR: Pesto de roquette
    name: 'Pesto de rúcula',
    // FR: Plus poivré que le basilic, parfait quand la roquette monte.
    description: 'Más picante que la albahaca, perfecto cuando la rúcula se espiga.',
    ingredients: <String>[
      '100 g de rúcula', // FR: 100 g de roquette
      '50 g de parmesano', // FR: 50 g de parmesan
      '40 g de piñones o almendras', // FR: 40 g de pignons ou d'amandes
      '10 cl de aceite de oliva', // FR: 10 cl d'huile d'olive
      '1 diente de ajo, sal', // FR: 1 gousse d'ail, sel
    ],
    steps: <String>[
      // FR: Fais torréfier les pignons à sec 2 minutes : ça change tout.
      'Tuesta los piñones en seco 2 minutos: lo cambia todo.',
      // FR: Mixe roquette, ail, pignons et parmesan par à-coups.
      'Tritura la rúcula, el ajo, los piñones y el parmesano a golpes cortos.',
      // FR: Verse l'huile en filet, mixeur en marche, jusqu'à une pâte souple.
      'Añade el aceite en hilo, con la batidora en marcha, hasta obtener una pasta suave.',
      // FR: Sale peu — le parmesan sale déjà. Un trait de citron si c'est trop amer.
      'Sala poco: el parmesano ya es salado. Un chorrito de limón si amarga demasiado.',
    ],
  ),
  'roquette/Roquette, parmesan, citron': RecipeText(
    // FR: Roquette, parmesan, citron
    name: 'Rúcula, parmesano y limón',
    // FR: Trois ingrédients, dix secondes : la salade des restaurants italiens.
    description: 'Tres ingredientes, diez segundos: la ensalada de los restaurantes italianos.',
    ingredients: <String>[
      '150 g de rúcula', // FR: 150 g de roquette
      '80 g de parmesano', // FR: 80 g de parmesan
      '1 limón', // FR: 1 citron
      '3 cucharadas de aceite de oliva', // FR: 3 cuillères à soupe d'huile d'olive
      'pimienta', // FR: poivre
    ],
    steps: <String>[
      // FR: Dispose la roquette, à peine lavée et bien séchée.
      'Coloca la rúcula, apenas lavada y bien seca.',
      // FR: Jus de citron, huile, poivre — pas de sel, le parmesan y pourvoit.
      'Zumo de limón, aceite, pimienta; nada de sal, el parmesano ya se encarga.',
      // FR: Copeaux de parmesan à l'économe, généreusement.
      'Lascas de parmesano con el pelador, generosamente.',
      // FR: Mélange dans l'assiette, sers tout de suite.
      'Mezcla en el plato y sirve enseguida.',
    ],
  ),
  'roquette/Velouté de roquette et pomme de terre': RecipeText(
    // FR: Velouté de roquette et pomme de terre
    name: 'Crema de rúcula y patata',
    // FR: La pomme de terre arrondit le poivré de la roquette.
    description: 'La patata redondea el picante de la rúcula.',
    ingredients: <String>[
      '200 g de rúcula', // FR: 200 g de roquette
      '3 patatas', // FR: 3 pommes de terre
      '1 cebolla', // FR: 1 oignon
      '80 cl de caldo', // FR: 80 cl de bouillon
      'nata, sal, pimienta', // FR: crème, sel, poivre
    ],
    steps: <String>[
      // FR: Fais fondre l'oignon, ajoute les pommes de terre.
      'Rehoga la cebolla, añade las patatas.',
      // FR: Bouillon, et cuis 20 minutes.
      'Caldo, y cuece 20 minutos.',
      // FR: Ajoute la roquette 2 minutes avant la fin.
      'Añade la rúcula 2 minutos antes del final.',
      // FR: Mixe. Goûte avant de saler : la roquette est déjà forte.
      'Tritura. Prueba antes de salar: la rúcula ya es fuerte.',
    ],
  ),

  // ─────────── rutabaga (6 recettes) ───────────
  'rutabaga/Dés de rutabaga blanchis': RecipeText(
    // FR: Dés de rutabaga blanchis
    name: 'Dados de nabo sueco escaldados',
    // FR: Coupé en dés et blanchi trois minutes, il est prêt pour les potées et les rôtis de tout l'hiver.
    description: 'Cortado en dados y escaldado tres minutos, está listo para los guisos y los asados de todo el invierno.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '2 kg de nabos suecos', // FR: 2 kg de rutabagas
      'sal gorda', // FR: gros sel
      '1 ensaladera grande con agua y cubitos de hielo', // FR: 1 grand saladier d'eau et de glaçons
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche généreusement : la peau est épaisse, surtout sur les gros. Coupe en dés de 2 cm.
      'Pela generosamente: la piel es gruesa, sobre todo en los grandes. Corta en dados de 2 cm.',
      // FR: Blanchis les dés **3 minutes** dans une grande eau bouillante salée.
      'Escalda los dados **3 minutos** en una olla grande de agua hirviendo con sal.',
      // FR: Plonge-les aussitôt dans l'eau glacée.
      'Pásalos enseguida al agua con hielo.',
      // FR: Égoutte et sèche sur un torchon.
      'Escurre y seca con un paño.',
      // FR: Congèle sur plaque 2 heures, puis mets en sacs datés.
      'Congela en bandeja 2 horas y luego pasa a bolsas con la fecha.',
    ],
  ),
  'rutabaga/Rutabaga râpé fermenté': RecipeText(
    // FR: Rutabaga râpé fermenté
    name: 'Nabo sueco rallado fermentado',
    // FR: Râpé et salé comme une choucroute, il devient une sorte de « choucroute de navet » douce et acidulée.
    description: 'Rallado y salado como un chucrut, se convierte en una especie de «chucrut de nabo» suave y acidulado.',
    // FR: 6 mois au réfrigérateur
    keeps: '6 meses en la nevera',
    ingredients: <String>[
      '2 kg de nabos suecos', // FR: 2 kg de rutabagas
      '40 g de sal fina sin yodo (20 g por kg)', // FR: 40 g de sel fin non iodé (20 g par kg)
      '1 cucharadita de bayas de enebro', // FR: 1 cuillère à café de baies de genièvre
      '3 tarros de 75 cl', // FR: 3 bocaux de 75 cl
    ],
    steps: <String>[
      // FR: Épluche les rutabagas et râpe-les gros.
      'Pela los nabos suecos y rállalos grueso.',
      // FR: Pèse la râpée et ajoute **20 g de sel par kilo**, avec le genièvre.
      'Pesa lo rallado y añade **20 g de sal por kilo**, con el enebro.',
      // FR: Malaxe à pleines mains jusqu'à ce que le jus perle, une dizaine de minutes.
      'Amasa a manos llenas hasta que perle el jugo, unos diez minutos.',
      // FR: Tasse très fort dans les bocaux pour que le jus remonte au-dessus, en laissant 3 cm de vide.
      'Aprieta con mucha fuerza en los tarros para que el jugo suba por encima, dejando 3 cm de vacío.',
      // FR: Pose un poids pour garder la râpée **sous son jus**. S'il en manque, complète avec de l'eau salée à 30 g par litre.
      'Pon un peso para mantener lo rallado **bajo su jugo**. Si falta, completa con agua salada a 30 g por litro.',
      // FR: Ferme sans serrer et laisse fermenter 3 semaines à 18–22 °C, sur une assiette.
      'Cierra sin apretar y deja fermentar 3 semanas a 18–22 °C, sobre un plato.',
      // FR: Quand c'est acidulé, serre les couvercles et passe au réfrigérateur.
      'Cuando esté acidulado, aprieta las tapas y pásalo a la nevera.',
    ],
  ),
  'rutabaga/Pickles de rutabaga au gingembre': RecipeText(
    // FR: Pickles de rutabaga au gingembre
    name: 'Pickles de nabo sueco con jengibre',
    // FR: En fins bâtonnets, son goût de chou sucré prend très bien le vinaigre et le gingembre.
    description: 'En bastoncitos finos, su sabor a col dulce admite muy bien el vinagre y el jengibre.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '700 g de nabo sueco', // FR: 700 g de rutabaga
      '30 cl de vinagre blanco al 8 %', // FR: 30 cl de vinaigre blanc à 8 %
      '30 cl de agua', // FR: 30 cl d'eau
      '12 g de sal, 40 g de azúcar', // FR: 12 g de sel, 40 g de sucre
      '1 trozo de jengibre de 3 cm', // FR: 1 morceau de gingembre de 3 cm
    ],
    steps: <String>[
      // FR: Épluche le rutabaga et taille-le en fins bâtonnets de 5 mm, le gingembre en lamelles.
      'Pela el nabo sueco y córtalo en bastoncitos finos de 5 mm, y el jengibre en láminas.',
      // FR: Serre-les dans deux bocaux ébouillantés.
      'Apriétalos en dos tarros escaldados.',
      // FR: Fais bouillir vinaigre, eau, sel et sucre.
      'Hierve el vinagre, el agua, la sal y el azúcar.',
      // FR: Verse bouillant pour **couvrir entièrement** et ferme aussitôt.
      'Vierte el líquido hirviendo para **cubrir por completo** y cierra enseguida.',
      // FR: Laisse refroidir puis range au réfrigérateur. Attends 3 jours avant d'ouvrir.
      'Deja enfriar y guarda en la nevera. Espera 3 días antes de abrir.',
    ],
  ),
  'rutabaga/Purée de rutabaga': RecipeText(
    // FR: Purée de rutabaga
    name: 'Puré de nabo sueco',
    // FR: Avec une pomme de terre et beaucoup de beurre.
    description: 'Con una patata y mucha mantequilla.',
  ),
  'rutabaga/Rutabaga rôti aux épices': RecipeText(
    // FR: Rutabaga rôti aux épices
    name: 'Nabo sueco asado con especias',
    // FR: En cubes, paprika fumé, four chaud.
    description: 'En cubos, pimentón ahumado, horno caliente.',
  ),
  'rutabaga/Potée au rutabaga': RecipeText(
    // FR: Potée au rutabaga
    name: 'Cocido de nabo sueco',
    // FR: Avec chou, carotte et lard, le plat des jours froids.
    description: 'Con col, zanahoria y tocino, el plato de los días fríos.',
  ),

  // ─────────── salsifis (6 recettes) ───────────
  'salsifis/Salsifis précuits au congélateur': RecipeText(
    // FR: Salsifis précuits au congélateur
    name: 'Salsifíes precocidos para congelar',
    // FR: Le salsifis se pèle une fois pour toutes : précuit et congelé, il est prêt pour la crème ou la poêle.
    description: 'El salsifí se pela una vez por todas: precocido y congelado, está listo para la nata o la sartén.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1 kg de salsifíes', // FR: 1 kg de salsifis
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      '1 cucharada de harina', // FR: 1 cuillère à soupe de farine
      'sal gorda', // FR: gros sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Brosse les racines sous l'eau, puis prépare un saladier d'eau froide additionnée du jus d'un citron.
      'Cepilla las raíces bajo el agua y prepara una ensaladera de agua fría con el zumo de un limón.',
      // FR: Épluche-les **avec des gants** à l'économe (le latex colle et tache les doigts), coupe en tronçons de 5 cm et jette-les aussitôt dans l'eau citronnée : ils noircissent à l'air.
      'Pélalas **con guantes**, con el pelador (el látex pega y mancha los dedos), corta en trozos de 5 cm y échalos enseguida al agua con limón: se ennegrecen con el aire.',
      // FR: Délaie la farine dans une grande eau bouillante salée avec le reste du citron, et cuis les tronçons **5 minutes** : ils restent blancs et fermes.
      'Diluye la harina en una olla grande de agua hirviendo con sal y el resto del limón, y cuece los trozos **5 minutos**: se quedan blancos y firmes.',
      // FR: Égoutte puis plonge-les dans l'eau glacée.
      'Escurre y sumérgelos enseguida en agua con hielo.',
      // FR: Sèche-les bien sur un torchon.
      'Sécalos bien con un paño.',
      // FR: Congèle sur plaque 2 heures, puis mets en sacs datés. À cuire ensuite 10 minutes, encore gelés.
      'Congela en bandeja 2 horas y pasa a bolsas con la fecha. Después, cuécelos 10 minutos, todavía congelados.',
    ],
  ),
  'salsifis/Salsifis au vinaigre et à l\'estragon': RecipeText(
    // FR: Salsifis au vinaigre et à l'estragon
    name: 'Salsifíes en vinagre y estragón',
    // FR: Leur goût d'huître et d'artichaut se marie très bien au vinaigre : un condiment rare et élégant.
    description: 'Su sabor a ostra y alcachofa combina muy bien con el vinagre: un condimento raro y elegante.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '800 g de salsifíes', // FR: 800 g de salsifis
      '30 cl de vinagre blanco al 8 %', // FR: 30 cl de vinaigre blanc à 8 %
      '30 cl de agua', // FR: 30 cl d'eau
      '12 g de sal, 20 g de azúcar', // FR: 12 g de sel, 20 g de sucre
      'unas ramitas de estragón', // FR: quelques brins d'estragon
      'el zumo de un limón', // FR: le jus d'un citron
    ],
    steps: <String>[
      // FR: Épluche les salsifis avec des gants, coupe-les en bâtonnets et plonge-les dans l'eau citronnée au fur et à mesure.
      'Pela los salsifíes con guantes, córtalos en bastoncitos y échalos en el agua con limón a medida que los vayas cortando.',
      // FR: Cuis-les **5 minutes** à l'eau bouillante salée : crus, ils restent trop fibreux.
      'Cuécelos **5 minutos** en agua hirviendo con sal: crudos, quedan demasiado fibrosos.',
      // FR: Égoutte et rafraîchis à l'eau froide.
      'Escurre y refresca con agua fría.',
      // FR: Range-les debout dans deux bocaux ébouillantés avec l'estragon.
      'Colócalos de pie en dos tarros escaldados con el estragón.',
      // FR: Fais bouillir le vinaigre, l'eau, le sel et le sucre.
      'Hierve el vinagre, el agua, la sal y el azúcar.',
      // FR: Verse bouillant pour **couvrir entièrement**, ferme, laisse refroidir et range au réfrigérateur. Attends 3 jours avant d'y goûter.
      'Vierte el líquido hirviendo para **cubrir por completo**, cierra, deja enfriar y guarda en la nevera. Espera 3 días antes de probarlos.',
    ],
  ),
  'salsifis/Poêlée de salsifis au beurre à congeler': RecipeText(
    // FR: Poêlée de salsifis au beurre à congeler
    name: 'Salsifíes salteados con mantequilla para congelar',
    // FR: Dorés au beurre et à l'échalote, puis congelés : ils n'ont plus qu'à réchauffer à la poêle.
    description: 'Dorados con mantequilla y chalota, y luego congelados: solo hay que recalentarlos en la sartén.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de salsifíes', // FR: 1,5 kg de salsifis
      '40 g de mantequilla', // FR: 40 g de beurre
      '2 chalotas', // FR: 2 échalotes
      '1 manojo de perejil', // FR: 1 bouquet de persil
      'el zumo de un limón, sal', // FR: le jus d'un citron, sel
    ],
    steps: <String>[
      // FR: Épluche les salsifis avec des gants, coupe-les en tronçons et garde-les dans l'eau citronnée.
      'Pela los salsifíes con guantes, córtalos en trozos y guárdalos en el agua con limón.',
      // FR: Cuis-les 10 minutes à l'eau bouillante salée, puis égoutte.
      'Cuécelos 10 minutos en agua hirviendo con sal y luego escúrrelos.',
      // FR: Fais fondre les échalotes émincées dans le beurre, ajoute les salsifis et fais-les dorer 10 minutes.
      'Rehoga las chalotas picadas en la mantequilla, añade los salsifíes y dóralos 10 minutos.',
      // FR: Hors du feu, ajoute le persil haché et sale.
      'Fuera del fuego, añade el perejil picado y sala.',
      // FR: Étale sur une plaque et laisse refroidir complètement.
      'Extiende en una bandeja y deja enfriar por completo.',
      // FR: Mets en sacs d'une portion, à plat, et date-les.
      'Pon en bolsas de una ración, planas, y anota la fecha.',
    ],
  ),
  'salsifis/Salsifis à la crème': RecipeText(
    // FR: Salsifis à la crème
    name: 'Salsifíes a la nata',
    // FR: Épluchés dans l'eau citronnée, sinon ils noircissent.
    description: 'Pelados en agua con limón, si no se ennegrecen.',
  ),
  'salsifis/Salsifis frits': RecipeText(
    // FR: Salsifis frits
    name: 'Salsifíes fritos',
    // FR: En beignets, croustillants dehors, fondants dedans.
    description: 'En buñuelos, crujientes por fuera, tiernos por dentro.',
  ),
  'salsifis/Gratin de salsifis au jambon': RecipeText(
    // FR: Gratin de salsifis au jambon
    name: 'Gratinado de salsifíes con jamón',
    // FR: Un plat d'hiver qu'on a tort d'avoir oublié.
    description: 'Un plato de invierno que hemos hecho mal en olvidar.',
  ),

  // ─────────── sarrasin (6 recettes) ───────────
  'sarrasin/Grains de sarrasin battus et séchés': RecipeText(
    // FR: Grains de sarrasin battus et séchés
    name: 'Granos de trigo sarraceno trillados y secos',
    // FR: Battu, vanné, bien sec : le grain se garde un an et tu le moudras au fur et à mesure.
    description: 'Trillado, aventado, bien seco: el grano se conserva un año y lo molerás sobre la marcha.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 año en seco, protegido de los insectos',
    ingredients: <String>[
      'los tallos de trigo sarraceno con tres cuartas partes marrones', // FR: les tiges de sarrasin aux trois quarts brunes
      'una lona o una sábana vieja', // FR: une bâche ou un vieux drap
      'un palo', // FR: un bâton
      'tarros o cubos bien cerrados', // FR: des bocaux ou seaux bien fermés
    ],
    steps: <String>[
      // FR: Fauche quand **les trois quarts** des grains sont bruns : si tu attends qu'ils le soient tous, les premiers tombent au sol.
      'Siega cuando **tres cuartas partes** de los granos son marrones: si esperas a que lo sean todos, los primeros caen al suelo.',
      // FR: Fais de petites bottes et laisse-les debout sous un abri aéré pendant 10 jours.
      'Haz manojitos y déjalos de pie bajo un cobertizo ventilado durante 10 días.',
      // FR: Bats les bottes sur une bâche avec un bâton, ou frotte les têtes entre tes mains gantées.
      'Golpea los manojos sobre una lona con un palo, o frota las cabezas entre las manos enguantadas.',
      // FR: Vanne devant un ventilateur ou par vent léger : les débris s'envolent, les grains triangulaires retombent.
      'Avienta delante de un ventilador o con viento suave: los restos vuelan, los granos triangulares vuelven a caer.',
      // FR: Étale les grains en couche fine 3 jours pour finir de sécher : ils doivent se casser net sous la dent.
      'Extiende los granos en capa fina 3 días para acabar de secarlos: deben romperse limpiamente entre los dientes.',
      // FR: Passe-les 48 heures au congélateur contre les mites, puis range-les en bocaux bien fermés, au frais et au sec.
      'Pásalos 48 horas por el congelador contra las polillas y luego guárdalos en tarros bien cerrados, en un lugar fresco y seco.',
    ],
  ),
  'sarrasin/Farine de blé noir maison': RecipeText(
    // FR: Farine de blé noir maison
    name: 'Harina de trigo sarraceno casera',
    // FR: Moulue au dernier moment, elle a un parfum que la farine du commerce a perdu depuis longtemps.
    description: 'Molida en el último momento, tiene un aroma que la harina del súper perdió hace mucho.',
    // FR: 3 mois au sec, en bocal fermé
    keeps: '3 meses en seco, en tarro cerrado',
    ingredients: <String>[
      '500 g de granos de trigo sarraceno bien secos', // FR: 500 g de grains de sarrasin bien secs
      'un molinillo de cereales o una batidora potente', // FR: un moulin à céréales ou un blender puissant
      'un tamiz fino', // FR: un tamis fin
      'un tarro de cristal', // FR: un bocal en verre
    ],
    steps: <String>[
      // FR: Passe les grains au moulin en réglage fin, **par petites quantités** pour que la farine ne chauffe pas.
      'Pasa los granos por el molinillo en ajuste fino, **en pequeñas cantidades** para que la harina no se caliente.',
      // FR: Tamise : la farine grise passe, les morceaux d'écorce noire restent dans le tamis.
      'Tamiza: la harina gris pasa, los trozos de cáscara negra se quedan en el tamiz.',
      // FR: Repasse au moulin ce qui reste, puis tamise encore. Les écorces vides partent au compost.
      'Vuelve a moler lo que queda y tamiza otra vez. Las cáscaras vacías van al compost.',
      // FR: Mets en bocal fermé et note la date. Une farine complète rancit vite : mouds-en peu à la fois.
      'Pon la harina en un tarro cerrado y anota la fecha. Una harina integral se enrancia pronto: muele poca cada vez.',
    ],
  ),
  'sarrasin/Pile de galettes de blé noir congelées': RecipeText(
    // FR: Pile de galettes de blé noir congelées
    name: 'Pila de galettes de trigo sarraceno congeladas',
    // FR: Une séance de crêpière pour douze dîners : elles passent du congélateur à la poêle sans se casser.
    description: 'Una sesión de crepera para doce cenas: pasan del congelador a la sartén sin romperse.',
    // FR: 3 mois au congélateur
    keeps: '3 meses en el congelador',
    ingredients: <String>[
      '500 g de harina de trigo sarraceno', // FR: 500 g de farine de sarrasin
      '1 litro de agua fría', // FR: 1 litre d'eau froide
      '1 huevo', // FR: 1 œuf
      '10 g de sal gorda', // FR: 10 g de gros sel
      'mantequilla para la sartén', // FR: du beurre pour la poêle
      'papel de horno', // FR: du papier cuisson
    ],
    steps: <String>[
      // FR: Mélange farine et sel, verse l'eau petit à petit en fouettant, puis l'œuf : une pâte lisse et assez fluide.
      'Mezcla la harina y la sal, vierte el agua poco a poco batiendo y luego el huevo: una masa lisa y bastante fluida.',
      // FR: Laisse reposer **2 heures** au frais : la pâte prend du corps et les galettes se tiennent mieux.
      'Deja reposar **2 horas** en frío: la masa gana cuerpo y las galettes se sostienen mejor.',
      // FR: Cuis les galettes dans une poêle bien chaude et beurrée, une minute de chaque côté, sans les garnir.
      'Cocina las galettes en una sartén bien caliente y untada con mantequilla, un minuto por cada lado, sin rellenarlas.',
      // FR: Laisse-les refroidir à plat sur une grille, **sans les empiler chaudes** : la vapeur les ramollit.
      'Déjalas enfriar planas sobre una rejilla, **sin apilarlas calientes**: el vapor las ablanda.',
      // FR: Empile-les avec une feuille de papier cuisson entre chaque, glisse la pile dans un grand sac à plat et congèle.
      'Apílalas con una hoja de papel de horno entre cada una, mete la pila en una bolsa grande plana y congela.',
      // FR: Le jour venu, pose une galette encore congelée dans la poêle chaude et garnis-la : deux minutes suffisent.
      'Cuando llegue el día, pon una galette todavía congelada en la sartén caliente y rellénala: bastan dos minutos.',
    ],
  ),
  'sarrasin/Galettes de sarrasin': RecipeText(
    // FR: Galettes de sarrasin
    name: 'Galettes de trigo sarraceno',
    // FR: Farine, eau, sel, et du repos. Rien d'autre.
    description: 'Harina, agua, sal y reposo. Nada más.',
  ),
  'sarrasin/Kacha': RecipeText(
    // FR: Kacha
    name: 'Kasha',
    // FR: Grains grillés puis gonflés au bouillon.
    description: 'Granos tostados y luego hinchados en caldo.',
  ),
  'sarrasin/Salade de sarrasin aux herbes': RecipeText(
    // FR: Salade de sarrasin aux herbes
    name: 'Ensalada de trigo sarraceno con hierbas',
    // FR: Froid, avec tout ce que le jardin donne ce jour-là.
    description: 'Fría, con todo lo que el huerto dé ese día.',
  ),

  // ─────────── sarriette (6 recettes) ───────────
  'sarriette/Bottes de sarriette séchées': RecipeText(
    // FR: Bottes de sarriette séchées
    name: 'Manojos de ajedrea secos',
    // FR: La sarriette garde presque tout son poivre au séchage : une botte suffit pour tous tes haricots de l'hiver.
    description: 'La ajedrea conserva casi todo su picante al secarse: un manojo basta para todas tus judías del invierno.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      'tallos de ajedrea al comienzo de la floración', // FR: des tiges de sarriette en début de floraison
      'cordel', // FR: de la ficelle
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges au début de la floraison, par une journée sèche, en laissant 10 cm à la plante.
      'Corta los tallos al comienzo de la floración, en un día seco, dejando 10 cm a la planta.',
      // FR: Lie-les en petites bottes et retire les feuilles du bas, qui toucheraient la ficelle.
      'Átalos en manojitos y quita las hojas de abajo, que tocarían el cordel.',
      // FR: Suspends-les tête en bas dans un endroit sombre, sec et aéré, une dizaine de jours.
      'Cuélgalos boca abajo en un lugar oscuro, seco y ventilado, unos diez días.',
      // FR: Elles sont prêtes quand les tiges cassent au lieu de plier.
      'Están listos cuando los tallos se rompen en lugar de doblarse.',
      // FR: Égrène feuilles et fleurs dans un bocal, ou garde quelques brins entiers à glisser dans la cocotte.
      'Desgrana hojas y flores en un tarro, o guarda unas ramitas enteras para echar a la cazuela.',
    ],
  ),
  'sarriette/Vinaigre de vin à la sarriette': RecipeText(
    // FR: Vinaigre de vin à la sarriette
    name: 'Vinagre de vino con ajedrea',
    // FR: Un vinaigre poivré qui réveille les salades de haricots, de lentilles ou de pois chiches.
    description: 'Un vinagre picante que despierta las ensaladas de judías, lentejas o garbanzos.',
    // FR: 1 an au placard, à l'abri de la lumière
    keeps: '1 año en la despensa, protegido de la luz',
    ingredients: <String>[
      '6 ramitas de ajedrea fresca', // FR: 6 brins de sarriette fraîche
      '75 cl de vinagre de vino tinto o blanco de 6 % como mínimo', // FR: 75 cl de vinaigre de vin rouge ou blanc à 6 % minimum
      'una botella limpia', // FR: une bouteille propre
    ],
    steps: <String>[
      // FR: Rince les brins et laisse-les sécher complètement sur un torchon, une goutte d'eau dilue le vinaigre.
      'Enjuaga las ramitas y déjalas secar por completo sobre un paño: una gota de agua diluye el vinagre.',
      // FR: Glisse-les dans la bouteille, tête en bas.
      'Introdúcelas en la botella, con la punta hacia abajo.',
      // FR: Verse le vinaigre pur jusqu'au goulot : la sarriette doit être **entièrement immergée**.
      'Vierte el vinagre puro hasta el cuello: la ajedrea debe quedar **totalmente sumergida**.',
      // FR: Ferme et laisse infuser deux semaines à l'ombre, en secouant de temps en temps.
      'Cierra y deja macerar dos semanas a la sombra, agitando de vez en cuando.',
      // FR: Filtre et remets un brin propre si tu veux. Une herbe qui dépasse du vinaigre finit par moisir.
      'Filtra y pon una ramita limpia si quieres. Una hierba que sobresale del vinagre acaba enmoheciéndose.',
    ],
  ),
  'sarriette/Brins de sarriette au congélateur': RecipeText(
    // FR: Brins de sarriette au congélateur
    name: 'Ramitas de ajedrea en el congelador',
    // FR: Dix minutes, et tu as le parfum de la sarriette fraîche pour les fèves de printemps.
    description: 'Diez minutos, y tienes el aroma de la ajedrea fresca para las habas de primavera.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      'un manojo de ajedrea', // FR: une botte de sarriette
      'una bolsa de congelación con cierre', // FR: un sac de congélation à zip
    ],
    steps: <String>[
      // FR: Rince les brins et sèche-les bien dans un torchon.
      'Enjuaga las ramitas y sécalas bien con un paño.',
      // FR: Coupe-les en tronçons de 5 cm, la longueur d'un brin pour une casserole.
      'Córtalas en trozos de 5 cm, la longitud de una ramita para una cazuela.',
      // FR: Mets-les dans le sac à plat, chasse l'air, ferme et congèle.
      'Ponlas en la bolsa planas, saca el aire, cierra y congela.',
      // FR: Jette un brin gelé dans l'eau de cuisson des haricots ou des fèves, et retire-le avant de servir.
      'Echa una ramita congelada al agua de cocción de las judías o de las habas, y retírala antes de servir.',
    ],
  ),
  'sarriette/Haricots à la sarriette': RecipeText(
    // FR: Haricots à la sarriette
    name: 'Judías con ajedrea',
    // FR: On la dit « herbe aux haricots » : elle les rend digestes.
    description: 'La llaman «hierba de las judías»: las hace digestivas.',
  ),
  'sarriette/Fromage de chèvre à la sarriette': RecipeText(
    // FR: Fromage de chèvre à la sarriette
    name: 'Queso de cabra con ajedrea',
    // FR: Le pèbre d'ail provençal, roulé dans l'herbe.
    description: 'El «pebre d\'ai» provenzal, rebozado en la hierba.',
  ),
  'sarriette/Marinade pour grillades': RecipeText(
    // FR: Marinade pour grillades
    name: 'Marinada para parrilladas',
    // FR: Huile, ail, sarriette, citron.
    description: 'Aceite, ajo, ajedrea, limón.',
  ),

  // ─────────── sauge (6 recettes) ───────────
  'sauge/Bouquets de sauge séchés': RecipeText(
    // FR: Bouquets de sauge séchés
    name: 'Ramilletes de salvia secos',
    // FR: La sauge est l'une des rares herbes qui gagnent au séchage : son goût devient plus rond.
    description: 'La salvia es una de las pocas hierbas que ganan al secarse: su sabor se vuelve más redondo.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      'tallos de salvia frondosos', // FR: des tiges de sauge feuillues
      'cordel o gomas elásticas', // FR: de la ficelle ou des élastiques
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe des tiges de 20 cm en fin de matinée, par temps sec, de préférence avant la floraison.
      'Corta tallos de 20 cm a media mañana, con tiempo seco, preferiblemente antes de la floración.',
      // FR: Retire les feuilles abîmées et lie les tiges en bouquets de cinq ou six, pas plus épais.
      'Quita las hojas estropeadas y ata los tallos en ramilletes de cinco o seis, no más gruesos.',
      // FR: Suspends-les tête en bas dans un endroit sec, aéré et **à l'ombre**, une dizaine de jours.
      'Cuélgalos boca abajo en un lugar seco, ventilado y **a la sombra**, unos diez días.',
      // FR: Elles sont sèches quand les feuilles craquent. Si elles plient encore, laisse-les quelques jours de plus.
      'Están secos cuando las hojas crujen. Si todavía se doblan, déjalos unos días más.',
      // FR: Effeuille dans un bocal en gardant les feuilles **entières** : elles gardent mieux leur parfum.
      'Deshoja en un tarro conservando las hojas **enteras**: guardan mejor su aroma.',
    ],
  ),
  'sauge/Sel de sauge et romarin': RecipeText(
    // FR: Sel de sauge et romarin
    name: 'Sal de salvia y romero',
    // FR: Le sel des rôtis et des pommes de terre sautées, prêt pour toute l'année en une après-midi.
    description: 'La sal de los asados y las patatas salteadas, lista para todo el año en una tarde.',
    // FR: 1 an au placard, en bocal fermé
    keeps: '1 año en la despensa, en tarro cerrado',
    ingredients: <String>[
      '40 g de hojas de salvia', // FR: 40 g de feuilles de sauge
      '2 ramas de romero', // FR: 2 branches de romarin
      '250 g de sal gorda gris', // FR: 250 g de gros sel gris
      'la ralladura de un limón sin tratar', // FR: le zeste d'un citron non traité
    ],
    steps: <String>[
      // FR: Lave et **sèche parfaitement** les feuilles de sauge et les aiguilles de romarin.
      'Lava y **seca perfectamente** las hojas de salvia y las agujas de romero.',
      // FR: Mixe-les par à-coups avec le gros sel et le zeste jusqu'à un sable vert grossier.
      'Tritúralas a golpes cortos con la sal gorda y la ralladura hasta obtener una arena verde gruesa.',
      // FR: Étale en couche fine sur une plaque garnie de papier et sèche au four à 50 °C, porte entrouverte.
      'Extiende en capa fina sobre una bandeja forrada con papel y seca en el horno a 50 °C, con la puerta entreabierta.',
      // FR: Émiette avec une fourchette toutes les demi-heures pour casser les grumeaux.
      'Desmenuza con un tenedor cada media hora para deshacer los grumos.',
      // FR: Laisse refroidir complètement à l'air avant de mettre en pot.
      'Deja enfriar por completo al aire antes de pasarla a un tarro.',
      // FR: Mets en bocal sec et bien fermé, loin de la vapeur de la cuisinière.
      'Ponla en un tarro seco y bien cerrado, lejos del vapor de los fogones.',
    ],
  ),
  'sauge/Feuilles de sauge congelées à plat': RecipeText(
    // FR: Feuilles de sauge congelées à plat
    name: 'Hojas de salvia congeladas planas',
    // FR: Un quart d'heure, et tu as des feuilles entières à faire crépiter dans le beurre en plein hiver.
    description: 'Un cuarto de hora, y tienes hojas enteras para freír en mantequilla en pleno invierno.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      'un centenar de hermosas hojas de salvia', // FR: une centaine de belles feuilles de sauge
      'papel de horno', // FR: du papier cuisson
      'una caja de congelación', // FR: une boîte de congélation
    ],
    steps: <String>[
      // FR: Rince les feuilles et sèche-les une par une dans un torchon.
      'Enjuaga las hojas y sécalas una a una con un paño.',
      // FR: Coupe le pétiole et écarte les feuilles tachées ou trouées.
      'Corta el pecíolo y aparta las hojas manchadas o agujereadas.',
      // FR: Étale-les sur une plaque garnie de papier, **sans qu'elles se chevauchent**, et congèle 1 heure.
      'Extiéndelas en una bandeja forrada con papel, **sin que se solapen**, y congela 1 hora.',
      // FR: Range-les dans la boîte en couches séparées par du papier cuisson.
      'Guárdalas en la caja en capas separadas por papel de horno.',
      // FR: Jette-les gelées dans le beurre chaud : elles foncent un peu, mais le goût est là.
      'Échalas congeladas en la mantequilla caliente: se oscurecen un poco, pero el sabor está ahí.',
    ],
  ),
  'sauge/Beurre de sauge': RecipeText(
    // FR: Beurre de sauge
    name: 'Mantequilla de salvia',
    // FR: Feuilles frites dans le beurre noisette, sur des gnocchis.
    description: 'Hojas fritas en mantequilla avellana, sobre ñoquis.',
  ),
  'sauge/Saltimbocca': RecipeText(
    // FR: Saltimbocca
    name: 'Saltimbocca',
    // FR: Veau, jambon cru et une feuille de sauge par escalope.
    description: 'Ternera, jamón curado y una hoja de salvia por escalope.',
  ),
  'sauge/Infusion de sauge': RecipeText(
    // FR: Infusion de sauge
    name: 'Infusión de salvia',
    // FR: Digestive, avec une rondelle de citron.
    description: 'Digestiva, con una rodaja de limón.',
  ),

  // ─────────── sesame (6 recettes) ───────────
  'sesame/Graines de sésame battues et séchées': RecipeText(
    // FR: Graines de sésame battues et séchées
    name: 'Semillas de sésamo trilladas y secas',
    // FR: Coupé au bon moment, séché tête en bas, battu : ton sésame se garde un an au sec.
    description: 'Cortado en el momento justo, seco boca abajo, trillado: tu sésamo se conserva un año en seco.',
    // FR: 1 an au sec, à l'abri de la lumière et des insectes
    keeps: '1 año en seco, protegido de la luz y de los insectos',
    ingredients: <String>[
      'los tallos de sésamo', // FR: les tiges de sésame
      'una sábana o grandes bolsas de papel', // FR: un drap ou de grands sacs en papier
      'un tamiz', // FR: un tamis
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Coupe les tiges quand les **capsules du bas jaunissent** et que les feuilles tombent, avant qu'elles ne s'ouvrent et sèment tout au sol.
      'Corta los tallos cuando **las cápsulas de abajo amarilleen** y caigan las hojas, antes de que se abran y lo siembren todo por el suelo.',
      // FR: Lie-les en bottes et suspends-les tête en bas au-dessus d'un drap, ou enferme les têtes dans des sacs en papier.
      'Átalos en manojos y cuélgalos boca abajo sobre una sábana, o mete las cabezas en bolsas de papel.',
      // FR: Laisse sécher deux à trois semaines dans un endroit sec et aéré : les capsules s'ouvrent d'elles-mêmes.
      'Deja secar de dos a tres semanas en un lugar seco y ventilado: las cápsulas se abren solas.',
      // FR: Secoue et tape les bottes sur le drap : les graines tombent toutes seules.
      'Sacude y golpea los manojos sobre la sábana: las semillas caen solas.',
      // FR: Passe-les au tamis, puis vanne-les en soufflant doucement pour chasser les débris.
      'Pásalas por el tamiz y luego avéntalas soplando suavemente para quitar los restos.',
      // FR: Étale les graines en couche fine sur un plateau trois jours de plus, à l'ombre, en remuant chaque jour.
      'Extiende las semillas en capa fina sobre una bandeja tres días más, a la sombra, removiendo cada día.',
      // FR: Mets-les 48 heures au congélateur pour tuer d'éventuels œufs d'insectes, puis en bocal bien fermé au placard.
      'Mételas 48 horas en el congelador para matar posibles huevos de insectos y luego pásalas a un tarro bien cerrado en la despensa.',
    ],
  ),
  'sesame/Réserve de sésame au congélateur': RecipeText(
    // FR: Réserve de sésame au congélateur
    name: 'Reserva de sésamo en el congelador',
    // FR: Riche en huile, le sésame rancit au placard en quelques mois ; au froid, il reste frais deux ans.
    description: 'Rico en aceite, el sésamo se enrancia en la despensa en pocos meses; en frío, se mantiene fresco dos años.',
    // FR: 2 ans au congélateur
    keeps: '2 años en el congelador',
    ingredients: <String>[
      'semillas de sésamo bien secas', // FR: des graines de sésame bien sèches
      'tarros o bolsitas de congelación', // FR: des bocaux ou sachets de congélation
    ],
    steps: <String>[
      // FR: Vérifie que les graines sont **parfaitement sèches** : elles doivent couler comme du sable, sans coller.
      'Comprueba que las semillas estén **perfectamente secas**: deben caer como arena, sin pegarse.',
      // FR: Répartis-les en petits bocaux ou sachets d'environ 200 g, la quantité d'un mois.
      'Repártelas en tarritos o bolsitas de unos 200 g, la cantidad de un mes.',
      // FR: Chasse l'air, ferme bien et congèle. Note la date sur chaque sachet.
      'Saca el aire, cierra bien y congela. Anota la fecha en cada bolsita.',
      // FR: Utilise-les directement gelées : elles ne collent pas et se torréfient très bien sans décongeler.
      'Úsalas directamente congeladas: no se pegan y se tuestan muy bien sin descongelar.',
    ],
  ),
  'sesame/Sésame torréfié en bocal': RecipeText(
    // FR: Sésame torréfié en bocal
    name: 'Sésamo tostado en tarro',
    // FR: Une poêlée d'avance, prête à saupoudrer sur les salades, les légumes et le riz.
    description: 'Una sartenada de antemano, lista para espolvorear sobre ensaladas, verduras y arroz.',
    // FR: 3 mois au sec, en bocal fermé
    keeps: '3 meses en seco, en tarro cerrado',
    ingredients: <String>[
      '300 g de semillas de sésamo bien secas', // FR: 300 g de graines de sésame bien sèches
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Si ton sésame vient du jardin, rince-le dans une passoire fine et égoutte-le bien pour enlever la poussière.
      'Si tu sésamo viene del huerto, enjuágalo en un colador fino y escúrrelo bien para quitar el polvo.',
      // FR: Fais-le dorer dans une grande poêle sèche, à feu moyen, en couche fine.
      'Dóralo en una sartén grande y seca, a fuego medio, en capa fina.',
      // FR: Remue **sans arrêt** : il passe du blond au brûlé en quelques secondes. Arrête dès qu'il sent la noisette et commence à sauter.
      'Remueve **sin parar**: pasa de rubio a quemado en unos segundos. Para en cuanto huela a avellana y empiece a saltar.',
      // FR: Verse-le aussitôt sur une assiette froide, sinon il continue à cuire dans la poêle, et laisse refroidir.
      'Vuélcalo enseguida en un plato frío, si no sigue cocinándose en la sartén, y deja enfriar.',
      // FR: Mets en bocal seulement quand il est **complètement froid**, et range-le à l'abri de la chaleur.
      'Pásalo al tarro solo cuando esté **completamente frío**, y guárdalo lejos del calor.',
    ],
  ),
  'sesame/Tahini maison': RecipeText(
    // FR: Tahini maison
    name: 'Tahini casero',
    // FR: Graines torréfiées, mixées longtemps avec un filet d'huile.
    description: 'Semillas tostadas, trituradas largo rato con un chorrito de aceite.',
  ),
  'sesame/Gomasio': RecipeText(
    // FR: Gomasio
    name: 'Gomasio',
    // FR: Sésame grillé et sel, écrasés au mortier. Sur tout.
    description: 'Sésamo tostado y sal, machacados en el mortero. Para todo.',
  ),
  'sesame/Croquants au sésame': RecipeText(
    // FR: Croquants au sésame
    name: 'Crujientes de sésamo',
    // FR: Caramel et graines, étalés fin, cassés en éclats.
    description: 'Caramelo y semillas, extendidos finos, rotos en esquirlas.',
  ),

  // ─────────── shiitake (6 recettes) ───────────
  'shiitake/Shiitakés séchés': RecipeText(
    // FR: Shiitakés séchés
    name: 'Shiitakes secos',
    // FR: C'est ainsi qu'on les garde en Asie : séchés, leur goût devient même plus profond qu'à l'état frais.
    description: 'Así se conservan en Asia: secos, su sabor se vuelve incluso más profundo que en fresco.',
    // FR: 1 an au sec, en bocal hermétique
    keeps: '1 año en seco, en tarro hermético',
    ingredients: <String>[
      '1 kg de shiitakes', // FR: 1 kg de shiitakés
      'rejillas o bandejas', // FR: des grilles ou plaques
      'tarros bien secos', // FR: des bocaux bien secs
    ],
    steps: <String>[
      // FR: Coupe les pieds, durs et fibreux : garde-les pour un bouillon. Essuie les chapeaux sans les mouiller.
      'Corta los pies, duros y fibrosos: guárdalos para un caldo. Limpia los sombreros sin mojarlos.',
      // FR: Laisse les petits entiers et coupe les gros en lamelles de 5 mm.
      'Deja los pequeños enteros y corta los grandes en láminas de 5 mm.',
      // FR: Pose-les lamelles vers le haut sur des grilles et sèche à 50 °C, porte entrouverte, ou au déshydrateur.
      'Colócalos con las láminas hacia arriba sobre rejillas y seca a 50 °C, con la puerta entreabierta, o en el deshidratador.',
      // FR: Ils sont prêts quand ils sont durs et légers, et cassants pour les lamelles.
      'Están listos cuando están duros y ligeros, y quebradizos en el caso de las láminas.',
      // FR: Laisse refroidir et mets en bocaux hermétiques. Réhydrate-les 30 minutes dans l'eau tiède : cette eau est un bouillon parfumé.
      'Deja enfriar y pásalos a tarros herméticos. Rehidrátalos 30 minutos en agua tibia: esa agua es un caldo aromático.',
    ],
  ),
  'shiitake/Shiitakés sautés à congeler': RecipeText(
    // FR: Shiitakés sautés à congeler
    name: 'Shiitakes salteados para congelar',
    // FR: Saisis rapidement et congelés en portions, ils sont prêts pour un wok ou un bouillon en deux minutes.
    description: 'Sellados rápido y congelados en raciones, están listos para un wok o un caldo en dos minutos.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 kg de shiitakes', // FR: 1 kg de shiitakés
      '2 cucharadas de aceite neutro', // FR: 2 cuillères à soupe d'huile neutre
      '1 cucharadita de sal', // FR: 1 cuillère à café de sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Coupe les pieds et essuie les chapeaux avec un linge humide, sans les tremper.
      'Corta los pies y limpia los sombreros con un paño húmedo, sin sumergirlos.',
      // FR: Émince les chapeaux en lamelles de 5 mm.
      'Corta los sombreros en láminas de 5 mm.',
      // FR: Fais-les sauter à feu vif dans l'huile, en deux fois, jusqu'à ce qu'ils soient dorés et que l'eau soit évaporée.
      'Saltéalos a fuego fuerte en el aceite, en dos tandas, hasta que estén dorados y el agua se haya evaporado.',
      // FR: Sale en fin de cuisson.
      'Sala al final de la cocción.',
      // FR: Étale-les sur une assiette pour qu'ils refroidissent vite.
      'Extiéndelos en un plato para que se enfríen rápido.',
      // FR: Mets en sacs d'une portion, à plat, et date.
      'Pon en bolsas de una ración, planas, y anota la fecha.',
    ],
  ),
  'shiitake/Shiitakés marinés au vinaigre et gingembre': RecipeText(
    // FR: Shiitakés marinés au vinaigre et gingembre
    name: 'Shiitakes marinados con vinagre y jengibre',
    // FR: Cuits dans un vinaigre aigre-doux au gingembre, ils accompagnent un bol de riz ou une salade froide.
    description: 'Cocidos en un vinagre agridulce con jengibre, acompañan un cuenco de arroz o una ensalada fría.',
    // FR: 1 mois au réfrigérateur
    keeps: '1 mes en la nevera',
    ingredients: <String>[
      '600 g de shiitakes', // FR: 600 g de shiitakés
      '30 cl de vinagre blanco al 8 %', // FR: 30 cl de vinaigre blanc à 8 %
      '30 cl de agua', // FR: 30 cl d'eau
      '10 g de sal, 40 g de azúcar', // FR: 10 g de sel, 40 g de sucre
      '1 trozo de jengibre de 4 cm', // FR: 1 morceau de gingembre de 4 cm
      '1 cucharada de salsa de soja', // FR: 1 cuillère à soupe de sauce soja
    ],
    steps: <String>[
      // FR: Retire les pieds, essuie les chapeaux et coupe les gros en deux. Taille le gingembre en fines lamelles.
      'Quita los pies, limpia los sombreros y corta los grandes por la mitad. Corta el jengibre en láminas finas.',
      // FR: Porte à ébullition le vinaigre, l'eau, le sel, le sucre, le soja et le gingembre.
      'Lleva a ebullición el vinagre, el agua, la sal, el azúcar, la soja y el jengibre.',
      // FR: Ajoute les shiitakés et laisse frémir **5 minutes**.
      'Añade los shiitakes y deja hervir a fuego lento **5 minutos**.',
      // FR: Répartis-les dans deux bocaux ébouillantés avec le gingembre.
      'Repártelos en dos tarros escaldados con el jengibre.',
      // FR: Verse le liquide bouillant pour **couvrir entièrement**, ferme et laisse refroidir.
      'Vierte el líquido hirviendo para **cubrir por completo**, cierra y deja enfriar.',
      // FR: Range au réfrigérateur et attends 2 jours avant d'y goûter.
      'Guárdalo en la nevera y espera 2 días antes de probarlos.',
    ],
  ),
  'shiitake/Shiitakés sautés au soja': RecipeText(
    // FR: Shiitakés sautés au soja
    name: 'Shiitakes salteados con soja',
    // FR: Sauce soja, mirin, un peu de sucre : le glaçage japonais.
    description: 'Salsa de soja, mirin, un poco de azúcar: el glaseado japonés.',
  ),
  'shiitake/Bouillon dashi aux shiitakés': RecipeText(
    // FR: Bouillon dashi aux shiitakés
    name: 'Caldo dashi con shiitakes',
    // FR: Même séchés, ils donnent une profondeur rare.
    description: 'Incluso secos, aportan una profundidad poco común.',
  ),
  'shiitake/Shiitakés grillés au sésame': RecipeText(
    // FR: Shiitakés grillés au sésame
    name: 'Shiitakes a la parrilla con sésamo',
    // FR: Entiers, sur le gril, sel et huile de sésame.
    description: 'Enteros, a la parrilla, con sal y aceite de sésamo.',
  ),

  // ─────────── sorgho (6 recettes) ───────────
  'sorgho/Panicules de sorgho séchées et battues': RecipeText(
    // FR: Panicules de sorgho séchées et battues
    name: 'Panículas de sorgo secas y trilladas',
    // FR: Le grain bien sec, vanné et protégé des insectes, c'est la réserve de toute l'année.
    description: 'El grano bien seco, aventado y protegido de los insectos es la reserva de todo el año.',
    // FR: 1 an au sec, à l'abri des insectes
    keeps: '1 año en seco, protegido de los insectos',
    ingredients: <String>[
      'las panículas de sorgo cortadas en sazón', // FR: les panicules de sorgho coupées à maturité
      'una lona limpia', // FR: une bâche propre
      'un palo', // FR: un bâton
      'sacos o bidones herméticos', // FR: des sacs ou fûts hermétiques
    ],
    steps: <String>[
      // FR: Coupe les panicules quand le grain ne se raye plus à l'ongle, avec 20 cm de tige pour les suspendre.
      'Corta las panículas cuando el grano ya no se raya con la uña, con 20 cm de tallo para colgarlas.',
      // FR: Suspends-les tête en bas sous un abri aéré, ou étale-les au soleil, une bonne semaine.
      'Cuélgalas boca abajo bajo un cobertizo ventilado, o extiéndelas al sol, una buena semana.',
      // FR: Teste : un grain croqué casse net et sonne sec. S'il est pâteux, attends encore.
      'Compruébalo: un grano mordido se parte limpiamente y suena seco. Si está pastoso, espera más.',
      // FR: Bats les panicules au bâton sur la bâche, puis frotte entre les mains ce qui résiste.
      'Golpea las panículas con el palo sobre la lona y luego frota entre las manos lo que se resista.',
      // FR: Vanne en versant le grain de haut par vent léger pour faire partir les balles.
      'Avienta vertiendo el grano desde arriba con viento suave para que se vayan las cascarillas.',
      // FR: Passe le grain 3 jours au congélateur pour tuer les œufs de charançon.
      'Pasa el grano 3 días por el congelador para matar los huevos de gorgojo.',
      // FR: Stocke en sacs ou fûts hermétiques pleins à ras, au frais, au sec et surélevés.
      'Almacena en sacos o bidones herméticos llenos hasta arriba, en un lugar fresco, seco y elevado del suelo.',
    ],
  ),
  'sorgho/Sorgho en grain au congélateur': RecipeText(
    // FR: Sorgho en grain au congélateur
    name: 'Sorgo en grano en el congelador',
    // FR: Au froid, plus de charançons ni de grain qui sent le vieux : un quart d'heure et c'est réglé.
    description: 'En frío, ni gorgojos ni grano con olor a rancio: un cuarto de hora y listo.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      'sorgo trillado y bien seco', // FR: du sorgho battu et bien sec
      'bolsas de congelación gruesas', // FR: des sacs de congélation épais
    ],
    steps: <String>[
      // FR: Trie le grain sur un plateau : enlève cailloux, balles et grains noirs ou moisis.
      'Selecciona el grano en una bandeja: quita piedras, cascarillas y granos negros o mohosos.',
      // FR: Remplis des sacs par portions, chasse l'air et ferme bien.
      'Llena bolsas por raciones, saca el aire y cierra bien.',
      // FR: Congèle à plat. En 3 jours, le froid tue aussi les œufs cachés dans le grain.
      'Congela planas. En 3 días, el frío mata también los huevos escondidos en el grano.',
      // FR: Avant usage, laisse le sac fermé revenir à température 2 heures, pour que le grain ne prenne pas l'humidité.
      'Antes de usarlo, deja que la bolsa cerrada vuelva a temperatura ambiente durante 2 horas, para que el grano no coja humedad.',
    ],
  ),
  'sorgho/Grains de sorgho cuits en portions': RecipeText(
    // FR: Grains de sorgho cuits en portions
    name: 'Granos de sorgo cocidos en raciones',
    // FR: Le sorgho entier demande une heure de cuisson : fais-en une grosse marmite, et tu as des portions prêtes comme du riz.
    description: 'El sorgo entero pide una hora de cocción: haz una olla grande y tendrás raciones listas como el arroz.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '500 g de sorgo en grano', // FR: 500 g de sorgho en grain
      '1,5 litros de agua', // FR: 1,5 litre d'eau
      '1 cucharadita de sal', // FR: 1 cuillère à café de sel
      'recipientes o bolsas de congelación', // FR: des boîtes ou sacs de congélation
    ],
    steps: <String>[
      // FR: Rince le sorgho dans plusieurs eaux jusqu'à ce qu'elle soit claire.
      'Enjuaga el sorgo con varias aguas hasta que salga clara.',
      // FR: Laisse-le tremper 2 heures si tu peux : il cuira plus vite et plus régulièrement.
      'Déjalo en remojo 2 horas si puedes: se cocerá más rápido y más uniformemente.',
      // FR: Mets-le dans l'eau salée froide, porte à ébullition et laisse frémir à couvert. Le grain doit être tendre mais encore un peu ferme.
      'Ponlo en el agua salada fría, lleva a ebullición y deja hervir a fuego lento tapado. El grano debe quedar tierno pero todavía un poco firme.',
      // FR: Égoutte s'il reste de l'eau et étale sur un plateau pour refroidir vite.
      'Escurre si queda agua y extiende en una bandeja para que se enfríe rápido.',
      // FR: Répartis en portions à plat dans des sacs, grains bien séparés, et congèle.
      'Reparte en raciones planas en bolsas, con los granos bien separados, y congela.',
      // FR: Réchauffe 5 minutes à la poêle avec un filet d'eau, ou jette directement dans une soupe.
      'Recalienta 5 minutos en la sartén con un chorrito de agua, o échalo directamente a una sopa.',
    ],
  ),
  'sorgho/Galettes de sorgho': RecipeText(
    // FR: Galettes de sorgho
    name: 'Tortas de sorgo',
    // FR: Farine de sorgho, eau, sel, cuites sur une plaque brûlante.
    description: 'Harina de sorgo, agua, sal, cocidas en una plancha ardiente.',
  ),
  'sorgho/Tô de sorgho': RecipeText(
    // FR: Tô de sorgho
    name: 'Tô de sorgo',
    // FR: La version sorgho du tô, un classique du Burkina et du Mali à la sauce feuilles.
    description: 'La versión de sorgo del tô, un clásico de Burkina y de Malí con salsa de hojas.',
  ),
  'sorgho/Bouillie de sorgho': RecipeText(
    // FR: Bouillie de sorgho
    name: 'Papilla de sorgo',
    // FR: Une bouillie douce et nourrissante, parfaite pour bien démarrer la journée.
    description: 'Una papilla suave y nutritiva, perfecta para empezar bien el día.',
  ),

  // ─────────── souci (6 recettes) ───────────
  'souci/Pétales de souci séchés': RecipeText(
    // FR: Pétales de souci séchés
    name: 'Pétalos de caléndula secos',
    // FR: Le « safran du pauvre » : des pétales orange qui colorent riz, soupes et pains toute l'année.
    description: 'El «azafrán de los pobres»: pétalos naranjas que dan color al arroz, las sopas y los panes todo el año.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en seco, protegido de la luz',
    ingredients: <String>[
      'unas treinta flores de caléndula bien abiertas', // FR: une trentaine de fleurs de souci bien ouvertes
      'papel de periódico o una rejilla de secado', // FR: du papier journal ou une claie
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Cueille des fleurs de **Calendula officinalis**, pas d'œillets d'Inde, en fin de matinée, sans traitement.
      'Coge flores de **Calendula officinalis**, no claveles de Indias (tagetes), a última hora de la mañana y sin tratamientos.',
      // FR: Arrache les pétales du cœur d'un geste : le cœur vert est amer et sèche mal.
      'Arranca los pétalos del centro de un tirón: el centro verde es amargo y se seca mal.',
      // FR: Étale-les en couche fine sur le papier, sans qu'ils se chevauchent.
      'Extiéndelos en capa fina sobre el papel, sin que se solapen.',
      // FR: Laisse-les quatre à cinq jours à l'ombre, dans un endroit sec, en remuant chaque jour. Au soleil, ils pâlissent.
      'Déjalos de cuatro a cinco días a la sombra, en un lugar seco, removiendo cada día. Al sol, se decoloran.',
      // FR: Ils sont prêts quand ils crissent sous les doigts. Mets-les en bocal, dans le noir.
      'Están listos cuando crujen entre los dedos. Ponlos en un tarro, en la oscuridad.',
    ],
  ),
  'souci/Sel doré au souci': RecipeText(
    // FR: Sel doré au souci
    name: 'Sal dorada de caléndula',
    // FR: Des pétales séchés mêlés au gros sel : une salière orange pour les œufs et les légumes rôtis.
    description: 'Pétalos secos mezclados con sal gorda: un salero naranja para huevos y verduras asadas.',
    // FR: 1 an au placard, en bocal fermé
    keeps: '1 año en la despensa, en tarro cerrado',
    ingredients: <String>[
      '4 cucharadas de pétalos de caléndula bien secos', // FR: 4 cuillères à soupe de pétales de souci bien secs
      '250 g de sal gorda o flor de sal', // FR: 250 g de gros sel ou de fleur de sel
      'la ralladura seca de un limón (opcional)', // FR: le zeste séché d'un citron (facultatif)
    ],
    steps: <String>[
      // FR: Utilise des pétales **parfaitement secs** : des pétales frais feraient fondre le sel en bloc.
      'Usa pétalos **perfectamente secos**: unos pétalos frescos harían que la sal se apelmazara en un bloque.',
      // FR: Écrase-les grossièrement au mortier ou entre tes paumes.
      'Machácalos groseramente en el mortero o entre las palmas.',
      // FR: Mélange-les au sel et au zeste dans un saladier.
      'Mézclalos con la sal y la ralladura en una ensaladera.',
      // FR: Mets en pot bien sec et ferme. Secoue-le une fois par semaine les premiers temps.
      'Pásala a un tarro bien seco y cierra. Agítalo una vez por semana al principio.',
      // FR: Saupoudre au dernier moment sur les œufs, le riz ou un poisson : la couleur reste vive hors cuisson.
      'Espolvorea en el último momento sobre huevos, arroz o pescado: el color se mantiene vivo fuera de la cocción.',
    ],
  ),
  'souci/Glaçons aux pétales de souci': RecipeText(
    // FR: Glaçons aux pétales de souci
    name: 'Cubitos de hielo con pétalos de caléndula',
    // FR: Des cubes éclaboussés d'orange pour les carafes d'eau et les apéritifs d'été.
    description: 'Cubos salpicados de naranja para las jarras de agua y los aperitivos de verano.',
    // FR: 4 mois au congélateur
    keeps: '4 meses en el congelador',
    ingredients: <String>[
      '10 flores de caléndula', // FR: 10 fleurs de souci
      'agua hervida y enfriada', // FR: de l'eau bouillie refroidie
      'dos cubiteras', // FR: deux bacs à glaçons
      'una bolsa de congelación', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Plonge les fleurs dans l'eau froide et secoue-les pour faire partir les petites bêtes.
      'Sumerge las flores en agua fría y sacúdelas para que se vayan los bichitos.',
      // FR: Détache les pétales et laisse le cœur de côté.
      'Separa los pétalos y deja el centro aparte.',
      // FR: Remplis les cases d'eau à moitié et répartis quelques pétales.
      'Llena los huecos de agua hasta la mitad y reparte unos pétalos.',
      // FR: Congèle 1 heure, puis complète d'eau et remets au congélateur : les pétales restent **au milieu** au lieu de flotter.
      'Congela 1 hora, luego completa con agua y vuelve a congelar: los pétalos se quedan **en el medio** en vez de flotar.',
      // FR: Une fois durs, démoule les glaçons dans un sac fermé.
      'Una vez duros, desmolda los cubitos en una bolsa cerrada.',
    ],
  ),
  'souci/Riz au souci': RecipeText(
    // FR: Riz au souci
    name: 'Arroz con caléndula',
    // FR: Les pétales colorent le riz en jaune — le « safran du pauvre ».
    description: 'Los pétalos tiñen el arroz de amarillo: el «azafrán de los pobres».',
  ),
  'souci/Salade aux pétales de souci': RecipeText(
    // FR: Salade aux pétales de souci
    name: 'Ensalada con pétalos de caléndula',
    // FR: Crus, légèrement amers, très décoratifs.
    description: 'Crudos, ligeramente amargos, muy decorativos.',
  ),
  'souci/Beurre fleuri': RecipeText(
    // FR: Beurre fleuri
    name: 'Mantequilla florida',
    // FR: Pétales hachés dans du beurre pommade.
    description: 'Pétalos picados en mantequilla en punto de pomada.',
  ),

  // ─────────── taro (6 recettes) ───────────
  'taro/Taro cuit en morceaux au congélateur': RecipeText(
    // FR: Taro cuit en morceaux au congélateur
    name: 'Taro cocido en trozos para congelar',
    // FR: Le taro se cuit toujours avant d'être mangé : autant le cuire d'un coup, et en avoir prêt pour les ragoûts.
    description: 'El taro siempre se cuece antes de comerlo: mejor cocerlo de una vez y tenerlo listo para los guisos.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 kg de taro', // FR: 2 kg de taro
      'guantes de cocina', // FR: des gants de cuisine
      'sal gorda', // FR: gros sel
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: **Enfile des gants** : la sève du taro cru irrite la peau. Épluche-le épais, jusqu'à la chair blanche ou mauve.
      '**Ponte guantes**: la savia del taro crudo irrita la piel. Pélalo grueso, hasta la carne blanca o morada.',
      // FR: Coupe-le en morceaux de 4 cm et rince-les à grande eau, jusqu'à ce qu'elle ne soit plus gluante.
      'Córtalo en trozos de 4 cm y enjuágalos con abundante agua, hasta que ya no esté viscosa.',
      // FR: Cuis à l'eau bouillante salée jusqu'à ce que la pointe du couteau entre **sans résistance** : cru, le taro est toxique.
      'Cuece en agua hirviendo con sal hasta que la punta del cuchillo entre **sin resistencia**: crudo, el taro es tóxico.',
      // FR: Égoutte et laisse refroidir complètement sur une grille.
      'Escurre y deja enfriar por completo sobre una rejilla.',
      // FR: Mets en sacs par portions, à plat, et congèle. Ajoute-les gelés en fin de cuisson d'un ragoût ou écrase-les chauds.
      'Pon en bolsas por raciones, planas, y congela. Añádelos congelados al final de la cocción de un guiso o aplástalos calientes.',
    ],
  ),
  'taro/Cubes de taro crus congelés': RecipeText(
    // FR: Cubes de taro crus congelés
    name: 'Cubos de taro crudos congelados',
    // FR: Épluché et coupé une fois pour toutes, le taro se congèle cru : il ne reste plus qu'à le cuire, sans gants.
    description: 'Pelado y cortado de una vez por todas, el taro se congela crudo: solo queda cocerlo, sin guantes.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1,5 kg de taro', // FR: 1,5 kg de taro
      'guantes de cocina', // FR: des gants de cuisine
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Avec des gants, épluche le taro épais et coupe-le en cubes de 3 cm.
      'Con guantes, pela el taro grueso y córtalo en cubos de 3 cm.',
      // FR: Rince bien les cubes pour enlever le mucilage, puis sèche-les dans un torchon.
      'Enjuaga bien los cubos para quitar el mucílago y sécalos con un paño.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent et congèle 2 heures.
      'Extiéndelos en una bandeja sin que se toquen y congela 2 horas.',
      // FR: Verse-les en sac et note bien sur l'étiquette « **cru, à cuire** ».
      'Pásalos a una bolsa y anota bien en la etiqueta «**crudo, para cocer**».',
      // FR: À l'usage, jette-les gelés dans l'eau bouillante ou la sauce et cuis au moins 25 minutes, jusqu'à ce qu'ils soient fondants. Jamais crus.
      'Al usarlos, échalos congelados al agua hirviendo o a la salsa y cuece al menos 25 minutos, hasta que estén fundentes. Nunca crudos.',
    ],
  ),
  'taro/Cossettes de taro séchées': RecipeText(
    // FR: Cossettes de taro séchées
    name: 'Rodajas de taro secas',
    // FR: Cuites puis séchées, les tranches de taro se gardent au sec et se moulent en farine pour les bouillies et les pâtes.
    description: 'Cocidas y luego secas, las rodajas de taro se conservan en seco y se muelen en harina para papillas y masas.',
    // FR: 6 mois au sec, à l'abri des insectes
    keeps: '6 meses en seco, protegido de los insectos',
    ingredients: <String>[
      '2 kg de taro', // FR: 2 kg de taro
      'guantes de cocina', // FR: des gants de cuisine
      'papel de horno', // FR: du papier cuisson
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Avec des gants, épluche le taro et coupe-le en tranches de 5 mm.
      'Con guantes, pela el taro y córtalo en rodajas de 5 mm.',
      // FR: Cuis les tranches à l'eau frémissante jusqu'à ce qu'elles soient tendres mais encore entières.
      'Cuece las rodajas en agua a fuego suave hasta que estén tiernas pero todavía enteras.',
      // FR: Égoutte-les délicatement et étale-les sur des plaques, une seule couche.
      'Escúrrelas con delicadeza y extiéndelas en bandejas, en una sola capa.',
      // FR: Sèche au four à **60 °C**, porte entrouverte, ou au soleil sous un voile, jusqu'à ce qu'elles cassent net.
      'Seca en el horno a **60 °C**, con la puerta entreabierta, o al sol bajo un velo, hasta que se rompan limpiamente.',
      // FR: Laisse refroidir et range en bocal hermétique, ou moud-les en farine au blender.
      'Deja enfriar y guarda en un tarro hermético, o muélelas hasta hacerlas harina con la batidora.',
      // FR: La farine se cuit encore à l'eau en remuant pour faire une pâte ou une bouillie, comme un foufou.
      'La harina todavía se cuece en agua removiendo para hacer una masa o una papilla, como un foufou.',
    ],
  ),
  'taro/Taro pilé': RecipeText(
    // FR: Taro pilé
    name: 'Taro machacado',
    // FR: Bouilli puis pilé au mortier jusqu'à devenir élastique.
    description: 'Hervido y luego machacado en el mortero hasta que se vuelve elástico.',
  ),
  'taro/Chips de taro': RecipeText(
    // FR: Chips de taro
    name: 'Chips de taro',
    // FR: En lamelles très fines, frites jusqu'à ce qu'elles dorent.
    description: 'En láminas muy finas, fritas hasta que se doran.',
  ),
  'taro/Ragoût de taro': RecipeText(
    // FR: Ragoût de taro
    name: 'Guiso de taro',
    // FR: Le taro mijoté en sauce tomate, fondant et généreux, à servir bien chaud.
    description: 'El taro cocido a fuego lento en salsa de tomate, fundente y generoso, para servir bien caliente.',
  ),

  // ─────────── thym (6 recettes) ───────────
  'thym/Bouquets de thym séchés': RecipeText(
    // FR: Bouquets de thym séchés
    name: 'Ramilletes de tomillo secos',
    // FR: Le thym sèche mieux que toutes les autres herbes : il garde presque tout son parfum pendant un an.
    description: 'El tomillo se seca mejor que todas las demás hierbas: conserva casi todo su aroma durante un año.',
    // FR: 1 an en bocal, à l'abri de la lumière
    keeps: '1 año en tarro, protegido de la luz',
    ingredients: <String>[
      'un buen puñado de tomillo', // FR: une grosse brassée de thym
      'cordel de cocina', // FR: de la ficelle de cuisine
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Coupe les tiges **juste avant la floraison**, en fin de matinée par temps sec : c'est là qu'elles sont les plus parfumées.
      'Corta los tallos **justo antes de la floración**, a media mañana con tiempo seco: es cuando son más aromáticos.',
      // FR: Ne lave le thym que s'il est terreux, et sèche-le bien sur un torchon.
      'Lava el tomillo solo si tiene tierra, y sécalo bien con un paño.',
      // FR: Fais de petits bouquets d'une dizaine de tiges, liés serré : les tiges rétrécissent en séchant.
      'Haz ramilletes pequeños de una decena de tallos, atados fuerte: los tallos encogen al secarse.',
      // FR: Suspends-les tête en bas dans un endroit sec, sombre et aéré pendant une semaine.
      'Cuélgalos boca abajo en un lugar seco, oscuro y ventilado durante una semana.',
      // FR: Teste : les feuilles se détachent en les frottant et craquent entre tes doigts.
      'Compruébalo: las hojas se sueltan al frotarlas y crujen entre los dedos.',
      // FR: Effeuille au-dessus d'un plat, et range les feuilles en bocal fermé. Les tiges sèches parfument un feu de barbecue.
      'Deshoja sobre un plato y guarda las hojas en un tarro cerrado. Los tallos secos perfuman el fuego de una barbacoa.',
    ],
  ),
  'thym/Glaçons de thym à l\'huile d\'olive': RecipeText(
    // FR: Glaçons de thym à l'huile d'olive
    name: 'Cubitos de tomillo con aceite de oliva',
    // FR: Un cube jeté dans la poêle, et le plat démarre avec le thym et l'huile déjà prêts.
    description: 'Un cubito echado a la sartén, y el plato arranca con el tomillo y el aceite ya listos.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '1 ramillete de tomillo fresco', // FR: 1 bouquet de thym frais
      '15 cl de aceite de oliva', // FR: 15 cl d'huile d'olive
      'una cubitera', // FR: un bac à glaçons
      'una bolsa de congelación', // FR: un sac de congélation
    ],
    steps: <String>[
      // FR: Rince le thym et **sèche-le parfaitement** : l'eau ferait des cristaux et éclabousserait dans la poêle.
      'Enjuaga el tomillo y **sécalo perfectamente**: el agua haría cristales y salpicaría en la sartén.',
      // FR: Effeuille les tiges et hache grossièrement les feuilles.
      'Deshoja los tallos y pica las hojas groseramente.',
      // FR: Remplis les cases du bac aux deux tiers de feuilles, puis couvre d'huile d'olive.
      'Llena los huecos de la cubitera hasta dos tercios de hojas y cubre con aceite de oliva.',
      // FR: Congèle jusqu'à ce que ce soit bien dur.
      'Congela hasta que esté bien duro.',
      // FR: Démoule et garde en sac. Un cube sorti va **directement dans la poêle**, jamais à traîner sur le plan de travail.
      'Desmolda y guarda en una bolsa. Un cubito sacado va **directamente a la sartén**, nunca a quedarse en la encimera.',
    ],
  ),
  'thym/Vinaigre au thym et laurier': RecipeText(
    // FR: Vinaigre au thym et laurier
    name: 'Vinagre de tomillo y laurel',
    // FR: Quelques brins dans une bouteille de vinaigre, et toutes tes vinaigrettes sentent la garrigue.
    description: 'Unas ramitas en una botella de vinagre, y todas tus vinagretas huelen a monte mediterráneo.',
    // FR: 1 an au placard
    keeps: '1 año en la despensa',
    ingredients: <String>[
      '6 ramitas bonitas de tomillo', // FR: 6 beaux brins de thym
      '2 hojas de laurel', // FR: 2 feuilles de laurier
      '50 cl de vinagre de vino de 6 % como mínimo', // FR: 50 cl de vinaigre de vin à 6 % minimum
      '1 botella limpia', // FR: 1 bouteille propre
    ],
    steps: <String>[
      // FR: Rince le thym et le laurier, puis **sèche-les parfaitement** sur un torchon pendant une heure.
      'Enjuaga el tomillo y el laurel y **sécalos perfectamente** sobre un paño durante una hora.',
      // FR: Glisse les brins et les feuilles dans la bouteille.
      'Introduce las ramitas y las hojas en la botella.',
      // FR: Verse le vinaigre jusqu'en haut : les herbes doivent être entièrement couvertes, sinon elles moisissent.
      'Vierte el vinagre hasta arriba: las hierbas deben quedar totalmente cubiertas, si no se enmohecen.',
      // FR: Bouche et laisse infuser 3 semaines à l'abri de la lumière.
      'Tapa y deja macerar 3 semanas al abrigo de la luz.',
      // FR: Filtre et remets en bouteille propre sans les herbes : elles ont tout donné et finiraient par ramollir.
      'Filtra y vuelve a embotellar sin las hierbas: lo han dado todo y acabarían ablandándose.',
    ],
  ),
  'thym/Huile au thym': RecipeText(
    // FR: Huile au thym
    name: 'Aceite de tomillo',
    // FR: Branches sèches dans l'huile tiède, deux semaines d'attente.
    description: 'Ramas secas en aceite tibio, dos semanas de espera.',
  ),
  'thym/Poulet au thym et citron': RecipeText(
    // FR: Poulet au thym et citron
    name: 'Pollo con tomillo y limón',
    // FR: Beaucoup de branches sous la peau, pas dessus.
    description: 'Muchas ramas bajo la piel, no encima.',
  ),
  'thym/Infusion de thym au miel': RecipeText(
    // FR: Infusion de thym au miel
    name: 'Infusión de tomillo con miel',
    // FR: Le remède de la maison quand la gorge gratte.
    description: 'El remedio de la casa cuando pica la garganta.',
  ),

  // ─────────── tomate (6 recettes) ───────────
  'tomate/Coulis de tomates en bocaux': RecipeText(
    // FR: Coulis de tomates en bocaux
    name: 'Salsa de tomate en tarros',
    // FR: Cinq kilos d'un coup : le coulis stérilisé est la seule réponse qui tient l'hiver sans congélateur.
    description: 'Cinco kilos de golpe: la salsa de tomate esterilizada es la única respuesta que aguanta el invierno sin congelador.',
    // FR: 1 an au placard
    keeps: '1 año en la despensa',
    ingredients: <String>[
      '5 kg de tomates bien maduros', // FR: 5 kg de tomates bien mûres
      '2 cebollas', // FR: 2 oignons
      '4 dientes de ajo', // FR: 4 gousses d'ail
      '1 manojo de albahaca', // FR: 1 bouquet de basilic
      '4 cucharadas de aceite de oliva', // FR: 4 cuillères à soupe d'huile d'olive
      '2 cucharaditas de sal, 1 de azúcar', // FR: 2 cuillères à café de sel, 1 de sucre
    ],
    steps: <String>[
      // FR: Lave les tomates, retire le pédoncule et les parties abîmées. Inutile de les peler : la passoire le fera.
      'Lava los tomates, quita el pedúnculo y las partes estropeadas. No hace falta pelarlos: el pasapurés se encargará.',
      // FR: Coupe-les en quartiers et jette-les dans la grande marmite, sans eau — elles en rendront assez.
      'Córtalos en cuartos y échalos a la olla grande, sin agua: soltarán bastante.',
      // FR: Fais fondre oignons et ail à l'huile, puis ajoute les tomates et le sel.
      'Rehoga las cebollas y el ajo en el aceite, y luego añade los tomates y la sal.',
      // FR: Laisse cuire 45 minutes à découvert, en remuant de temps en temps. Le jus doit baisser de moitié.
      'Deja cocer 45 minutos sin tapar, removiendo de vez en cuando. El jugo debe bajar a la mitad.',
      // FR: Passe au moulin à légumes : peaux et graines restent dedans. Un mixeur ferait un coulis rose et mousseux.
      'Pasa por el pasapurés: pieles y semillas se quedan dentro. Una batidora haría una salsa rosada y espumosa.',
      // FR: Remets sur le feu avec le sucre et le basilic, et fais réduire encore 20 minutes. Il doit napper la cuillère.
      'Vuelve a poner al fuego con el azúcar y la albahaca, y reduce otros 20 minutos. Debe napar la cuchara.',
      // FR: Remplis des bocaux propres à 2 cm du bord, ferme-les.
      'Llena tarros limpios hasta 2 cm del borde y ciérralos.',
      // FR: Stérilise 30 minutes dans l'eau bouillante, bocaux entièrement couverts d'eau. C'est cette étape qui fait tenir un an.
      'Esteriliza 30 minutos en agua hirviendo, con los tarros completamente cubiertos de agua. Este paso es el que hace que dure un año.',
      // FR: Laisse refroidir dans l'eau, puis vérifie que chaque couvercle est creux. Un couvercle bombé : au réfrigérateur, et mange-le dans la semaine.
      'Deja enfriar en el agua y comprueba que cada tapa esté hundida. Una tapa abombada: a la nevera, y cómelo en la semana.',
    ],
  ),
  'tomate/Tomates séchées à l\'huile': RecipeText(
    // FR: Tomates séchées à l'huile
    name: 'Tomates secos en aceite',
    // FR: Le four à basse température concentre tout le sucre. Ensuite l'huile les garde.
    description: 'El horno a baja temperatura concentra todo el azúcar. Después el aceite los conserva.',
    // FR: 6 mois au frais, dans l'huile
    keeps: '6 meses en un lugar fresco, en aceite',
    ingredients: <String>[
      '2 kg de tomates alargados (tipo pera)', // FR: 2 kg de tomates allongées (olivettes)
      'sal gorda', // FR: gros sel
      '3 dientes de ajo', // FR: 3 gousses d'ail
      'tomillo, orégano, albahaca', // FR: thym, origan, basilic
      '30 cl de aceite de oliva', // FR: 30 cl d'huile d'olive
    ],
    steps: <String>[
      // FR: Coupe les tomates en deux dans la longueur. Les allongées sèchent mieux : moins d'eau, plus de chair.
      'Corta los tomates por la mitad a lo largo. Los alargados se secan mejor: menos agua, más pulpa.',
      // FR: Pose-les face coupée vers le haut sur une grille, sale légèrement : le sel tire l'eau.
      'Colócalos con el corte hacia arriba sobre una rejilla y sala ligeramente: la sal saca el agua.',
      // FR: Four à 90 °C, chaleur tournante, **porte entrechoquée** par une cuillère en bois pour laisser filer la vapeur.
      'Horno a 90 °C, con aire, **con la puerta entreabierta calzada con una cuchara de madera** para dejar escapar el vapor.',
      // FR: Compte 6 à 7 heures. Elles doivent être souples, pas cassantes : trop sèches, elles ne se réhydratent plus.
      'Calcula de 6 a 7 horas. Deben quedar blandos, no quebradizos: demasiado secos, ya no se rehidratan.',
      // FR: Range-les en bocal avec l'ail en lamelles et les herbes, en tassant par couches.
      'Colócalos en un tarro con el ajo en láminas y las hierbas, apretando por capas.',
      // FR: Couvre entièrement d'huile — une tomate qui dépasse moisit. Attends 48 h avant d'y toucher.
      'Cubre completamente de aceite: un tomate que asome se enmohece. Espera 48 h antes de tocarlos.',
    ],
  ),
  'tomate/Tomates congelées entières': RecipeText(
    // FR: Tomates congelées entières
    name: 'Tomates enteros congelados',
    // FR: Dix minutes de travail. La tomate est le seul légume qu'on congèle cru sans rien faire.
    description: 'Diez minutos de trabajo. El tomate es la única hortaliza que se congela cruda sin hacer nada.',
    // FR: 8 mois au congélateur
    keeps: '8 meses en el congelador',
    ingredients: <String>[
      'tomates maduros, tantos como quieras', // FR: des tomates mûres, autant que tu veux
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Choisis des tomates saines. Une tomate fendue ou tachée ne se garde pas mieux au froid.
      'Elige tomates sanos. Un tomate agrietado o manchado no se conserva mejor en frío.',
      // FR: Lave-les et **sèche-les bien** : l'eau qui reste fait du givre et les colle entre elles.
      'Lávalos y **sécalos bien**: el agua que queda hace escarcha y los pega entre sí.',
      // FR: Retire le pédoncule, laisse-les entières. Pas besoin de peler ni de blanchir.
      'Quita el pedúnculo y déjalos enteros. No hace falta pelarlos ni escaldarlos.',
      // FR: Étale-les sur une plaque et mets-les 2 heures au congélateur, séparées.
      'Extiéndelos en una bandeja y mételos 2 horas en el congelador, separados.',
      // FR: Une fois dures, verse-les en sac. Elles ne feront pas un bloc, et tu en prendras trois à la fois.
      'Una vez duros, pásalos a una bolsa. No harán un bloque, y cogerás tres a la vez.',
      // FR: À l'usage : passe-les sous l'eau tiède, la peau glisse toute seule. Pour les sauces et les soupes, pas pour une salade.
      'Al usarlos, pásalos bajo agua tibia: la piel se desliza sola. Para salsas y sopas, no para una ensalada.',
    ],
  ),
  'tomate/Tarte à la tomate et moutarde': RecipeText(
    // FR: Tarte à la tomate et moutarde
    name: 'Tarta de tomate y mostaza',
    // FR: Une couche de moutarde sous les tomates, du thym dessus.
    description: 'Una capa de mostaza bajo los tomates, tomillo por encima.',
    ingredients: <String>[
      '1 masa quebrada', // FR: 1 pâte brisée
      '6 tomates maduros', // FR: 6 tomates mûres
      '2 cucharadas de mostaza', // FR: 2 cuillères à soupe de moutarde
      '150 g de gruyer rallado', // FR: 150 g de gruyère râpé
      'tomillo, sal, pimienta, aceite de oliva', // FR: thym, sel, poivre, huile d'olive
    ],
    steps: <String>[
      // FR: Préchauffe le four à 200 °C.
      'Precalienta el horno a 200 °C.',
      // FR: Étale la pâte dans le moule et pique-la à la fourchette.
      'Extiende la masa en el molde y pínchala con un tenedor.',
      // FR: Tartine le fond de moutarde, puis saupoudre le gruyère : il empêchera la pâte de détremper.
      'Unta el fondo con mostaza y espolvorea el gruyer: evitará que la masa se empape.',
      // FR: Coupe les tomates en rondelles, dispose-les en rosace, serrées.
      'Corta los tomates en rodajas y colócalos en roseta, apretados.',
      // FR: Sel, poivre, thym, un filet d'huile d'olive.
      'Sal, pimienta, tomillo, un chorrito de aceite de oliva.',
      // FR: Au four 35 minutes : les bords doivent dorer.
      'Al horno 35 minutos: los bordes deben dorarse.',
      // FR: Laisse tiédir 10 minutes avant de couper, sinon elle s'écroule.
      'Deja templar 10 minutos antes de cortar, si no se desmorona.',
    ],
  ),
  'tomate/Salade tomate-oignon': RecipeText(
    // FR: Salade tomate-oignon
    name: 'Ensalada de tomate y cebolla',
    // FR: Des tomates fraîches du jardin, un filet de citron, et le tour est joué.
    description: 'Tomates frescos del huerto, un chorrito de limón, y listo.',
    ingredients: <String>[
      '4 tomates bien maduros', // FR: 4 tomates bien mûres
      '1 cebolla roja', // FR: 1 oignon rouge
      '1 limón', // FR: 1 citron
      '3 cucharadas de aceite de oliva', // FR: 3 cuillères à soupe d'huile d'olive
      'sal, pimienta, albahaca', // FR: sel, poivre, basilic
    ],
    steps: <String>[
      // FR: Coupe les tomates en quartiers, pas en dés : elles rendent moins d'eau.
      'Corta los tomates en cuartos, no en dados: sueltan menos agua.',
      // FR: Émince l'oignon très fin. Si tu le trouves fort, rince-le à l'eau froide.
      'Corta la cebolla muy fina. Si te parece fuerte, enjuágala con agua fría.',
      // FR: Presse le citron, mélange-le à l'huile, sel, poivre.
      'Exprime el limón, mézclalo con el aceite, sal y pimienta.',
      // FR: Verse sur les tomates, mélange délicatement.
      'Vierte sobre los tomates y mezcla con delicadeza.',
      // FR: Déchire le basilic à la main par-dessus — au couteau il noircit.
      'Rasga la albahaca a mano por encima: con cuchillo se ennegrece.',
    ],
  ),
  'tomate/Thiéboudienne': RecipeText(
    // FR: Thiéboudienne
    name: 'Thiéboudienne',
    // FR: Le riz au poisson sénégalais, roi des plats, avec sa sauce tomate bien réduite.
    description: 'El arroz con pescado senegalés, rey de los platos, con su salsa de tomate bien reducida.',
    ingredients: <String>[
      '1 kg de pescado (thiof, mero o bacalao)', // FR: 1 kg de poisson (thiof, mérou ou cabillaud)
      '500 g de arroz partido', // FR: 500 g de riz brisé
      '6 tomates maduros + 2 cucharadas de concentrado', // FR: 6 tomates mûres + 2 cuillères de concentré
      '1 col, 2 zanahorias, 1 berenjena, 1 yuca', // FR: 1 chou, 2 carottes, 1 aubergine, 1 manioc
      '2 cebollas, 1 guindilla, perejil, ajo', // FR: 2 oignons, 1 piment, persil, ail
      'aceite, sal, pimienta', // FR: huile, sel, poivre
    ],
    steps: <String>[
      // FR: Pile ail, persil, piment et sel : c'est le nokoss. Farcis-en les poissons par une entaille.
      'Machaca ajo, perejil, guindilla y sal: es el nokoss. Rellena con él los pescados por un corte.',
      // FR: Fais revenir les poissons dans l'huile chaude, puis réserve-les.
      'Sofríe los pescados en aceite caliente y resérvalos.',
      // FR: Dans la même huile, fais fondre les oignons, ajoute tomates et concentré. Laisse réduire 15 minutes à feu doux.
      'En el mismo aceite, rehoga las cebollas, añade los tomates y el concentrado. Deja reducir 15 minutos a fuego suave.',
      // FR: Couvre d'eau, ajoute les légumes du plus dur au plus tendre. Cuis 25 minutes.
      'Cubre de agua y añade las verduras de la más dura a la más tierna. Cuece 25 minutos.',
      // FR: Remets le poisson 10 minutes, puis sors poisson et légumes et garde-les au chaud.
      'Vuelve a poner el pescado 10 minutos y luego saca pescado y verduras y mantenlos calientes.',
      // FR: Verse le riz dans la sauce restante — elle doit le couvrir d'un doigt. Couvre et cuis 20 minutes sans remuer.
      'Vierte el arroz en la salsa que queda: debe cubrirlo un dedo. Tapa y cuece 20 minutos sin remover.',
      // FR: Dresse le riz, le poisson au centre, les légumes autour.
      'Emplata el arroz, el pescado en el centro, las verduras alrededor.',
    ],
  ),

  // ─────────── topinambour (6 recettes) ───────────
  'topinambour/Topinambours lacto-fermentés': RecipeText(
    // FR: Topinambours lacto-fermentés
    name: 'Tupinambos lactofermentados',
    // FR: En saumure, ils gardent leur croquant de châtaigne et deviennent bien plus faciles à digérer.
    description: 'En salmuera, conservan su crujiente de castaña y se vuelven mucho más fáciles de digerir.',
    // FR: 4 mois au réfrigérateur
    keeps: '4 meses en la nevera',
    ingredients: <String>[
      '1,5 kg de tupinambos', // FR: 1,5 kg de topinambours
      '1,5 litros de agua sin cloro', // FR: 1,5 litre d'eau non chlorée
      '45 g de sal sin yodo', // FR: 45 g de sel non iodé
      '2 dientes de ajo', // FR: 2 gousses d'ail
      '1 cucharadita de semillas de hinojo', // FR: 1 cuillère à café de graines de fenouil
    ],
    steps: <String>[
      // FR: Fais dissoudre **45 g de sel dans 1,5 litre d'eau** : saumure à 3 %.
      'Disuelve **45 g de sal en 1,5 litros de agua**: salmuera al 3 %.',
      // FR: Brosse les topinambours sous l'eau en insistant dans les creux, où la terre reste.
      'Cepilla los tupinambos bajo el agua insistiendo en los huecos, donde se queda la tierra.',
      // FR: Inutile de les éplucher : coupe-les en rondelles de 5 mm.
      'No hace falta pelarlos: córtalos en rodajas de 5 mm.',
      // FR: Tasse les rondelles dans trois bocaux avec l'ail écrasé et le fenouil, jusqu'à 3 cm du bord.
      'Aprieta las rodajas en tres tarros con el ajo machacado y el hinojo, hasta 3 cm del borde.',
      // FR: Couvre de saumure et pose un poids pour que **tout reste dessous**.
      'Cubre con la salmuera y pon un peso para que **todo quede por debajo**.',
      // FR: Ferme sans serrer et laisse fermenter 2 semaines à 18–22 °C, sur une assiette.
      'Cierra sin apretar y deja fermentar 2 semanas a 18–22 °C, sobre un plato.',
      // FR: Quand ils sont acidulés, serre les couvercles et range au réfrigérateur.
      'Cuando estén acidulados, aprieta las tapas y guárdalos en la nevera.',
    ],
  ),
  'topinambour/Pickles de topinambour au curcuma': RecipeText(
    // FR: Pickles de topinambour au curcuma
    name: 'Pickles de tupinambo con cúrcuma',
    // FR: Vingt minutes, et un bocal doré et croquant qui réveille les salades d'hiver.
    description: 'Veinte minutos, y un tarro dorado y crujiente que despierta las ensaladas de invierno.',
    // FR: 2 mois au réfrigérateur
    keeps: '2 meses en la nevera',
    ingredients: <String>[
      '700 g de tupinambos', // FR: 700 g de topinambours
      '30 cl de vinagre blanco al 8 %', // FR: 30 cl de vinaigre blanc à 8 %
      '30 cl de agua', // FR: 30 cl d'eau
      '12 g de sal, 30 g de azúcar', // FR: 12 g de sel, 30 g de sucre
      '1 cucharadita de cúrcuma, 1 cucharadita de semillas de mostaza', // FR: 1 cuillère à café de curcuma, 1 cuillère à café de graines de moutarde
    ],
    steps: <String>[
      // FR: Brosse soigneusement les topinambours sous l'eau.
      'Cepilla con cuidado los tupinambos bajo el agua.',
      // FR: Coupe-les en fines rondelles de 3 mm, à la mandoline si tu en as une.
      'Córtalos en rodajas finas de 3 mm, con mandolina si tienes una.',
      // FR: Remplis deux bocaux ébouillantés avec les rondelles et la moutarde.
      'Llena dos tarros escaldados con las rodajas y la mostaza.',
      // FR: Fais bouillir le vinaigre, l'eau, le sel, le sucre et le curcuma.
      'Hierve el vinagre, el agua, la sal, el azúcar y la cúrcuma.',
      // FR: Verse bouillant pour **couvrir entièrement**, ferme et laisse refroidir.
      'Vierte el líquido hirviendo para **cubrir por completo**, cierra y deja enfriar.',
      // FR: Range au réfrigérateur et attends 2 jours avant d'ouvrir.
      'Guarda en la nevera y espera 2 días antes de abrir.',
    ],
  ),
  'topinambour/Purée de topinambour en portions': RecipeText(
    // FR: Purée de topinambour en portions
    name: 'Puré de tupinambo en raciones',
    // FR: Cuite et mixée, elle se congèle en briques prêtes pour une purée ou la base d'un velouté.
    description: 'Cocido y triturado, se congela en bloques listos para un puré o la base de una crema.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '2 kg de tupinambos', // FR: 2 kg de topinambours
      'el zumo de un limón', // FR: le jus d'un citron
      '50 g de mantequilla', // FR: 50 g de beurre
      'sal', // FR: sel
      'recipientes o bolsas de congelación', // FR: des boîtes ou sacs de congélation
    ],
    steps: <String>[
      // FR: Épluche les topinambours à l'économe et plonge-les au fur et à mesure dans de l'eau citronnée : ils noircissent vite.
      'Pela los tupinambos con el pelador y sumérgelos a medida que los pelas en agua con limón: se ennegrecen rápido.',
      // FR: Cuis-les à l'eau salée jusqu'à ce qu'ils soient tendres sous la lame.
      'Cuécelos en agua con sal hasta que estén tiernos al pincharlos con la hoja del cuchillo.',
      // FR: Égoutte bien et mixe avec le beurre. **Sans crème ni lait** : ils tranchent à la décongélation.
      'Escurre bien y tritura con la mantequilla. **Sin nata ni leche**: se cortan al descongelar.',
      // FR: Refroidis vite : plat posé dans l'eau froide, en remuant de temps en temps.
      'Enfría rápido: el recipiente puesto en agua fría, removiendo de vez en cuando.',
      // FR: Répartis en portions, en laissant 2 cm de vide, ferme et date.
      'Reparte en raciones, dejando 2 cm de vacío, cierra y anota la fecha.',
    ],
  ),
  'topinambour/Velouté de topinambour': RecipeText(
    // FR: Velouté de topinambour
    name: 'Crema de tupinambo',
    // FR: Goût d'artichaut, texture de velours.
    description: 'Sabor a alcachofa, textura de terciopelo.',
  ),
  'topinambour/Topinambours rôtis au thym': RecipeText(
    // FR: Topinambours rôtis au thym
    name: 'Tupinambos asados con tomillo',
    // FR: Brossés sans éplucher, coupés en deux, au four.
    description: 'Cepillados sin pelar, partidos por la mitad, al horno.',
  ),
  'topinambour/Salade de topinambours crus': RecipeText(
    // FR: Salade de topinambours crus
    name: 'Ensalada de tupinambos crudos',
    // FR: Râpés fin, citron, noisettes. Surprenant et bon.
    description: 'Rallados finos, limón, avellanas. Sorprendente y buena.',
  ),


  // ─────────── tournesol (6 recettes) ───────────
  'tournesol/Têtes de tournesol séchées et égrenées': RecipeText(
    // FR: Têtes de tournesol séchées et égrenées
    name: 'Cabezas de girasol secas y desgranadas',
    // FR: Protégées des oiseaux puis séchées tête en bas, elles te donnent des graines pour toute l'année.
    description: 'Protegidas de los pájaros y secadas boca abajo, te dan pipas para todo el año.',
    // FR: 1 an au sec, à l'abri de la lumière et des insectes
    keeps: '1 año en lugar seco, protegidas de la luz y de los insectos',
    ingredients: <String>[
      'cabezas de girasol maduras', // FR: des têtes de tournesol mûres
      'bolsas de papel o gasa', // FR: des sacs en papier ou du voile
      'cordel', // FR: de la ficelle
      'tarros herméticos', // FR: des bocaux hermétiques
    ],
    steps: <String>[
      // FR: Quand les pétales tombent et que le **dos de la tête jaunit**, enferme-la dans un sac en papier ou un voile contre les oiseaux.
      'Cuando se caigan los pétalos y el **dorso de la cabeza amarillee**, enciérrala en una bolsa de papel o en una gasa para protegerla de los pájaros.',
      // FR: Coupe la tête avec 30 cm de tige quand le dos vire au brun et que les graines sont bien pleines.
      'Corta la cabeza con 30 cm de tallo cuando el dorso se ponga marrón y las pipas estén bien llenas.',
      // FR: Suspends-la tête en bas dans un endroit sec et aéré, deux à trois semaines, toujours dans son sac.
      'Cuélgala boca abajo en un lugar seco y ventilado, de dos a tres semanas, siempre dentro de su bolsa.',
      // FR: Frotte la tête avec la paume ou une brosse dure : les graines se détachent d'elles-mêmes.
      'Frota la cabeza con la palma de la mano o con un cepillo duro: las pipas se sueltan solas.',
      // FR: Étale-les sur un plateau trois jours de plus, à l'ombre. Une graine bien sèche craque sous la dent.
      'Extiéndelas en una bandeja tres días más, a la sombra. Una pipa bien seca cruje entre los dientes.',
      // FR: Passe-les 48 heures au congélateur contre les mites, puis range-les en bocal bien fermé, dans leur coque.
      'Pásalas 48 horas por el congelador contra las polillas y guárdalas en un tarro bien cerrado, con su cáscara.',
    ],
  ),
  'tournesol/Graines décortiquées au congélateur': RecipeText(
    // FR: Graines décortiquées au congélateur
    name: 'Pipas peladas en el congelador',
    // FR: Sans leur coque, les graines rancissent vite au placard ; au froid, elles restent fraîches un an.
    description: 'Sin su cáscara, las pipas se enrancian enseguida en la despensa; en frío, se mantienen frescas un año.',
    // FR: 1 an au congélateur
    keeps: '1 año en el congelador',
    ingredients: <String>[
      'pipas de girasol peladas y bien secas', // FR: des graines de tournesol décortiquées et bien sèches
      'tarros o bolsitas de congelación', // FR: des bocaux ou sachets de congélation
    ],
    steps: <String>[
      // FR: Écarte les graines tachées, moisies ou vides avant de stocker.
      'Aparta las pipas manchadas, mohosas o vacías antes de guardarlas.',
      // FR: Vérifie qu'elles sont **parfaitement sèches** : elles doivent rouler sans coller.
      'Comprueba que estén **perfectamente secas**: tienen que rodar sin pegarse.',
      // FR: Répartis-les en sachets de 200 g, une quantité facile à finir.
      'Repártelas en bolsitas de 200 g, una cantidad fácil de terminar.',
      // FR: Chasse l'air, ferme bien, note la date et congèle.
      'Saca el aire, cierra bien, anota la fecha y congela.',
      // FR: Utilise-les directement sans décongeler, dans le pain, les salades ou une poêle sèche.
      'Úsalas directamente sin descongelar, en el pan, en las ensaladas o en una sartén seca.',
    ],
  ),
  'tournesol/Graines en coque salées à l\'apéro': RecipeText(
    // FR: Graines en coque salées à l'apéro
    name: 'Pipas con cáscara saladas para el aperitivo',
    // FR: Trempées dans l'eau salée puis séchées au four, comme celles qu'on grignote dans le Sud.
    description: 'Remojadas en agua salada y secadas al horno, como las que se picotean en el Sur.',
    // FR: 2 mois au sec, en bocal fermé
    keeps: '2 meses en lugar seco, en un tarro cerrado',
    ingredients: <String>[
      '500 g de pipas de girasol con cáscara, bien secas', // FR: 500 g de graines de tournesol en coque, bien sèches
      '2 litros de agua', // FR: 2 litres d'eau
      '70 g de sal', // FR: 70 g de sel
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Dissous le sel dans l'eau froide.
      'Disuelve la sal en el agua fría.',
      // FR: Plonges-y les graines et laisse tremper toute une nuit, environ 8 heures. Une assiette dessus les garde sous l'eau.
      'Sumerge las pipas y déjalas en remojo toda la noche, unas 8 horas. Un plato encima las mantiene bajo el agua.',
      // FR: Égoutte-les et étale-les sur un torchon pour enlever l'eau de surface.
      'Escúrrelas y extiéndelas sobre un paño para quitar el agua de la superficie.',
      // FR: Étale-les en une couche sur une plaque et sèche-les au four à 130 °C, en remuant tous les quarts d'heure.
      'Extiéndelas en una sola capa sobre una bandeja y sécalas en el horno a 130 °C, removiéndolas cada cuarto de hora.',
      // FR: Elles sont prêtes quand la coque est sèche et l'amande blonde et croquante. Goûte-en une, refroidie.
      'Están listas cuando la cáscara está seca y la pipa dorada y crujiente. Prueba una, ya fría.',
      // FR: Laisse-les refroidir complètement sur la plaque avant de les mettre en bocal.
      'Déjalas enfriar por completo en la bandeja antes de pasarlas al tarro.',
    ],
  ),
  'tournesol/Graines de tournesol grillées': RecipeText(
    // FR: Graines de tournesol grillées
    name: 'Pipas de girasol tostadas',
    // FR: À la poêle à sec, salées à la sortie.
    description: 'En sartén seca, saladas al sacarlas.',
  ),
  'tournesol/Pain aux graines de tournesol': RecipeText(
    // FR: Pain aux graines de tournesol
    name: 'Pan con pipas de girasol',
    // FR: Dans la pâte et sur la croûte.
    description: 'En la masa y sobre la corteza.',
  ),
  'tournesol/Pousses de tournesol en salade': RecipeText(
    // FR: Pousses de tournesol en salade
    name: 'Brotes de girasol en ensalada',
    // FR: Germées une semaine, croquantes et douces.
    description: 'Germinados durante una semana, crujientes y suaves.',
  ),

  // ─────────── verveine (6 recettes) ───────────
  'verveine/Bouquets de verveine séchés': RecipeText(
    // FR: Bouquets de verveine séchés
    name: 'Ramilletes de hierba luisa secos',
    // FR: La verveine garde son parfum de citron mieux que toute autre herbe au séchage : fais-en des réserves.
    description: 'La hierba luisa conserva su aroma a limón mejor que cualquier otra hierba al secarse: haz provisión.',
    // FR: 1 an au sec, à l'abri de la lumière
    keeps: '1 año en lugar seco, protegida de la luz',
    ingredients: <String>[
      'tallos de hierba luisa', // FR: des tiges de verveine citronnée
      'cordel', // FR: de la ficelle
      'un tarro hermético', // FR: un bocal hermétique
    ],
    steps: <String>[
      // FR: Coupe les tiges de 20 à 30 cm par temps sec, de préférence juste avant la floraison. La plante repousse aussitôt.
      'Corta los tallos de 20 a 30 cm en tiempo seco, preferiblemente justo antes de la floración. La planta vuelve a brotar enseguida.',
      // FR: Lie-les en petits bouquets lâches, sans les laver si elles sont propres.
      'Átalos en ramilletes pequeños y sueltos, sin lavarlos si están limpios.',
      // FR: Suspends-les tête en bas dans un endroit **sombre et aéré**, une dizaine de jours.
      'Cuélgalos boca abajo en un lugar **oscuro y ventilado**, unos diez días.',
      // FR: Les feuilles sont prêtes quand elles se détachent en craquant.
      'Las hojas están listas cuando se sueltan crujiendo.',
      // FR: Effeuille-les entières dans un bocal : cinq ou six feuilles suffisent pour une théière.
      'Deshójalas enteras en un tarro: cinco o seis hojas bastan para una tetera.',
    ],
  ),
  'verveine/Gelée de verveine citronnée': RecipeText(
    // FR: Gelée de verveine citronnée
    name: 'Gelatina de hierba luisa',
    // FR: Une gelée blonde au parfum de citron, divine sur une tartine ou avec un yaourt.
    description: 'Una gelatina dorada con aroma a limón, divina sobre una tostada o con un yogur.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierta en la nevera',
    ingredients: <String>[
      '2 buenos puñados de hojas de hierba luisa (unos 40 g)', // FR: 2 belles poignées de feuilles de verveine (environ 40 g)
      '1 litro de agua', // FR: 1 litre d'eau
      'el zumo de 2 limones', // FR: le jus de 2 citrons
      '800 g de azúcar', // FR: 800 g de sucre
      '1 sobre de pectina para 1 kg de fruta', // FR: 1 sachet de pectine pour 1 kg de fruits
    ],
    steps: <String>[
      // FR: Rince les feuilles et froisse-les entre tes mains pour libérer leurs huiles.
      'Enjuaga las hojas y estrújalas entre las manos para liberar sus aceites.',
      // FR: Porte l'eau à ébullition, verse-la sur les feuilles et couvre.
      'Lleva el agua a ebullición, viértela sobre las hojas y tapa.',
      // FR: Laisse infuser hors du feu, puis filtre en pressant les feuilles.
      'Deja reposar la infusión fuera del fuego y luego fíltrala presionando las hojas.',
      // FR: Ajoute le jus de citron, qui aide la gelée à prendre.
      'Añade el zumo de limón, que ayuda a que la gelatina cuaje.',
      // FR: Incorpore la pectine mélangée à un peu de sucre, porte à ébullition, puis verse le reste du sucre.
      'Incorpora la pectina mezclada con un poco de azúcar, lleva a ebullición y echa después el resto del azúcar.',
      // FR: Fais bouillir à gros bouillons en remuant, selon le paquet de pectine.
      'Hierve a fuego fuerte sin dejar de remover, según indique el paquete de pectina.',
      // FR: Mets en pots chauds ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pásala a tarros calientes escaldados, cierra y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'verveine/Feuilles de verveine congelées': RecipeText(
    // FR: Feuilles de verveine congelées
    name: 'Hojas de hierba luisa congeladas',
    // FR: Dix minutes, et le parfum de la verveine fraîche pour tes crèmes et tes desserts d'hiver.
    description: 'Diez minutos, y el aroma de la hierba luisa fresca para tus cremas y tus postres de invierno.',
    // FR: 6 mois au congélateur
    keeps: '6 meses en el congelador',
    ingredients: <String>[
      '3 puñados de hojas de hierba luisa', // FR: 3 poignées de feuilles de verveine
      'una bolsa de congelación con cierre zip', // FR: un sac de congélation à zip
    ],
    steps: <String>[
      // FR: Rince les feuilles et sèche-les bien dans un torchon.
      'Enjuaga las hojas y sécalas bien con un paño.',
      // FR: Détache-les des tiges, en les gardant entières.
      'Sepáralas de los tallos, manteniéndolas enteras.',
      // FR: Mets-les à plat dans le sac, chasse l'air, ferme et congèle à plat.
      'Colócalas planas en la bolsa, saca el aire, cierra y congela en plano.',
      // FR: Infuse-les **encore gelées** dans le lait chaud d'une crème ou dans l'eau d'une tisane. Elles noircissent, pas leur goût.
      'Infúndelas **aún congeladas** en la leche caliente de una crema o en el agua de una infusión. Se ennegrecen, pero su sabor no.',
    ],
  ),
  'verveine/Infusion de verveine': RecipeText(
    // FR: Infusion de verveine
    name: 'Infusión de hierba luisa',
    // FR: La tisane du soir, séchée en bouquets la tête en bas.
    description: 'La infusión de la noche, secada en ramilletes boca abajo.',
  ),
  'verveine/Crème à la verveine': RecipeText(
    // FR: Crème à la verveine
    name: 'Crema de hierba luisa',
    // FR: Infusée dans le lait chaud vingt minutes.
    description: 'Infusionada en la leche caliente durante veinte minutos.',
  ),
  'verveine/Sorbet à la verveine': RecipeText(
    // FR: Sorbet à la verveine
    name: 'Sorbete de hierba luisa',
    // FR: Vert pâle, très parfumé, servi avec des pêches.
    description: 'Verde pálido, muy aromático, servido con melocotones.',
  ),

  // ─────────── vigne (6 recettes) ───────────
  'vigne/Raisins secs maison': RecipeText(
    // FR: Raisins secs maison
    name: 'Pasas caseras',
    // FR: Une treille entière ne se mange pas en dix jours : séché, le raisin se garde toute l'année.
    description: 'Una parra entera no se come en diez días: seca, la uva se conserva todo el año.',
    // FR: 1 an en bocal, au sec
    keeps: '1 año en tarro, en lugar seco',
    ingredients: <String>[
      '2 kg de uva de mesa sin pepitas, bien madura', // FR: 2 kg de raisin de table sans pépins, bien mûr
      'un bol grande de agua helada', // FR: un saladier d'eau glacée
      'tarros de cristal', // FR: des bocaux en verre
    ],
    steps: <String>[
      // FR: Égrappe le raisin, lave les grains et écarte ceux qui sont fendus ou moisis.
      'Desgrana el racimo, lava las uvas y aparta las que estén abiertas o mohosas.',
      // FR: Plonge-les **30 secondes** dans l'eau bouillante : la peau se fendille et le grain sèche deux fois plus vite.
      'Sumérgelas **30 segundos** en agua hirviendo: la piel se agrieta y la uva se seca el doble de rápido.',
      // FR: Passe-les aussitôt dans l'eau glacée, puis égoutte et sèche-les sur un torchon.
      'Pásalas enseguida por el agua helada, escúrrelas y sécalas con un paño.',
      // FR: Étale-les en une couche sur des grilles et sèche au four à **60 °C**, porte entrouverte. Remue-les de temps en temps.
      'Extiéndelas en una sola capa sobre rejillas y sécalas en el horno a **60 °C**, con la puerta entreabierta. Remuévelas de vez en cuando.',
      // FR: Teste : le grain est fripé et souple, sans jus quand tu l'écrases entre deux doigts.
      'Compruébalo: la uva está arrugada y blanda, y no suelta jugo cuando la aplastas entre dos dedos.',
      // FR: Laisse refroidir et mets en bocal. Secoue-le chaque jour une semaine : s'il y a de la buée, remets au four.
      'Deja enfriar y pásalas a un tarro. Agítalo cada día durante una semana: si ves vaho, vuelven al horno.',
    ],
  ),
  'vigne/Grains de raisin congelés': RecipeText(
    // FR: Grains de raisin congelés
    name: 'Uvas congeladas',
    // FR: Croqués directement sortis du congélateur, ils ont la texture d'un sorbet. Les enfants adorent.
    description: 'Mordidas directamente al sacarlas del congelador, tienen la textura de un sorbete. A los niños les encantan.',
    // FR: 10 mois au congélateur
    keeps: '10 meses en el congelador',
    ingredients: <String>[
      '1 kg de uva de mesa', // FR: 1 kg de raisin de table
      'bolsas de congelación', // FR: des sacs de congélation
    ],
    steps: <String>[
      // FR: Égrappe le raisin et lave les grains dans une passoire.
      'Desgrana el racimo y lava las uvas en un colador.',
      // FR: Sèche-les bien sur un torchon, en les roulant doucement : l'eau restée colle les grains entre eux.
      'Sécalas bien con un paño, rodándolas con suavidad: el agua que queda pega las uvas entre sí.',
      // FR: Étale-les sur une plaque sans qu'ils se touchent et congèle 3 heures.
      'Extiéndelas sobre una bandeja sin que se toquen y congela 3 horas.',
      // FR: Verse-les en sac une fois durs. Ils se mangent **encore congelés**, ou remplacent des glaçons dans un verre.
      'Pásalas a una bolsa cuando estén duras. Se comen **aún congeladas**, o sustituyen a los cubitos de hielo en un vaso.',
    ],
  ),
  'vigne/Gelée de raisin à la pomme': RecipeText(
    // FR: Gelée de raisin à la pomme
    name: 'Gelatina de uva con manzana',
    // FR: Le raisin manque de pectine, la pomme en a pour deux : ensemble, ils font une gelée qui prend toute seule.
    description: 'A la uva le falta pectina, la manzana tiene para dos: juntas hacen una gelatina que cuaja sola.',
    // FR: 1 an au placard, 1 mois ouvert au réfrigérateur
    keeps: '1 año en la despensa, 1 mes abierta en la nevera',
    ingredients: <String>[
      '2 kg de uva', // FR: 2 kg de raisin
      '2 manzanas ácidas', // FR: 2 pommes acidulées
      '750 g de azúcar por litro de zumo', // FR: 750 g de sucre par litre de jus
      'el zumo de un limón', // FR: le jus d'un citron
      '6 tarros de mermelada', // FR: 6 pots de confiture
    ],
    steps: <String>[
      // FR: Égrappe et lave le raisin. Coupe les pommes en morceaux **avec peau et pépins** : c'est là qu'est la pectine.
      'Desgrana y lava la uva. Corta las manzanas en trozos **con piel y pepitas**: ahí está la pectina.',
      // FR: Cuis raisin et pommes avec un verre d'eau, à couvert, en écrasant de temps en temps.
      'Cuece la uva y las manzanas con un vaso de agua, tapadas, aplastándolas de vez en cuando.',
      // FR: Verse dans un torchon propre posé sur une passoire et laisse égoutter sans presser, pour une gelée limpide.
      'Vierte en un paño limpio colocado sobre un colador y deja escurrir sin presionar, para obtener una gelatina limpia y transparente.',
      // FR: Mesure le jus, ajoute 750 g de sucre par litre et le jus de citron, puis porte à ébullition en écumant.
      'Mide el zumo, añade 750 g de azúcar por litro y el zumo de limón, y lleva a ebullición retirando la espuma.',
      // FR: Cuis à gros bouillons, puis teste sur une assiette froide : une goutte qui se fige est prête.
      'Cuece a fuego fuerte y prueba después en un plato frío: si una gota se cuaja, está lista.',
      // FR: Mets en pots ébouillantés, ferme et retourne jusqu'à refroidissement.
      'Pásala a tarros escaldados, cierra y dales la vuelta hasta que se enfríen.',
    ],
  ),
  'vigne/Feuilles de vigne farcies': RecipeText(
    // FR: Feuilles de vigne farcies
    name: 'Hojas de parra rellenas',
    // FR: Riz, herbes, citron — les jeunes feuilles du printemps.
    description: 'Arroz, hierbas, limón: las hojas tiernas de la primavera.',
  ),
  'vigne/Raisiné': RecipeText(
    // FR: Raisiné
    name: 'Mosto cocido de uva',
    // FR: Du jus de raisin réduit des heures, sans une once de sucre.
    description: 'Zumo de uva reducido durante horas, sin una pizca de azúcar.',
  ),
  'vigne/Verjus': RecipeText(
    // FR: Verjus
    name: 'Agraz',
    // FR: Le jus des raisins verts, acide, qui remplace le vinaigre.
    description: 'El zumo ácido de las uvas verdes, que sustituye al vinagre.',
  ),
};
