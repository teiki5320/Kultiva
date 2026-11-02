/// Le contenu de Kultiva, en anglais.
///
/// Clé = la phrase française exacte. Voir `content_i18n.dart` pour le
/// mécanisme, et `docs/traduction-recettes.md` pour la marche à suivre.
///
/// Rempli lot par lot :
/// ```bash
/// dart run tool/exporter_contenu.dart --compte
/// dart run tool/exporter_contenu.dart --squelette --langue=en --bloc=badges
/// ```
const Map<String, String> contentTextsEn = <String, String>{
  // ─── maladies (323 phrases, 2079 mots) ───
  'Mildiou':
      'Late blight / downy mildew',
  'Bouillie bordelaise préventive, éviter de mouiller le feuillage, tailler les gourmands':
      'Preventive Bordeaux mixture, avoid wetting the foliage, remove side shoots',
  'Pucerons':
      'Aphids',
  'Pulvériser du savon noir dilué, favoriser les coccinelles':
      'Spray diluted insecticidal soap and encourage ladybirds',
  'Cul noir (nécrose apicale)':
      'Blossom end rot',
  'Pas une maladie — manque de calcium lié à l\'arrosage irrégulier. Pailler et arroser régulièrement':
      'Not a disease — a calcium shortage caused by irregular watering. Mulch and water regularly',
  'Virose TYLCV (feuilles jaunes enroulées)':
      'Tomato yellow leaf curl virus (TYLCV) — curled, yellowing leaves',
  'Transmise par les aleurodes (mouches blanches) — arracher et détruire les plants atteints, filet anti-insectes dès la pépinière, plants sains':
      'Spread by whiteflies — pull up and destroy affected plants, use insect-proof netting from the nursery stage, start with healthy plants',
  'Aleurode (mouche blanche)':
      'Whitefly',
  'Plaquettes jaunes engluées, savon noir sous les feuilles, filet anti-insectes en pépinière':
      'Sticky yellow traps, insecticidal soap under the leaves, insect-proof netting in the nursery',
  'Mouche de la carotte':
      'Carrot fly',
  'Filet anti-insectes, associer avec oignon/poireau, semer après mi-juin':
      'Insect-proof netting, plant alongside onion/leek, sow after mid-June',
  'Alternariose':
      'Early blight',
  'Rotation des cultures (3 ans), détruire les feuilles atteintes':
      'Crop rotation (3 years), destroy affected leaves',
  'Oïdium':
      'Powdery mildew',
  'Pulvériser du lait dilué (10%), couper les feuilles atteintes':
      'Spray diluted milk (10%), cut off affected leaves',
  'Savon noir, coccinelles':
      'Insecticidal soap, ladybirds',
  'Limaces':
      'Slugs',
  'Pièges à bière, cendres, coquilles d\'œufs broyées':
      'Beer traps, wood ash, crushed eggshells',
  'Pourriture grise (Botrytis)':
      'Grey mould (Botrytis)',
  'Aérer, espacement suffisant, ne pas arroser le feuillage':
      'Ventilate, give plants enough space, do not water the foliage',
  'Anthracnose':
      'Anthracnose',
  'Ne pas toucher les plants mouillés, rotation des cultures':
      'Do not touch wet plants, crop rotation',
  'Pucerons noirs':
      'Black aphids (blackfly)',
  'Pincer les extrémités, savon noir':
      'Pinch out the tips, insecticidal soap',
  'Doryphore':
      'Colorado beetle',
  'Ramassage manuel, purin de tanaisie':
      'Hand-picking, tansy brew',
  'Bouillie bordelaise, aérer entre les plants':
      'Bordeaux mixture, leave room for air between plants',
  'Pourriture apicale':
      'Blossom end rot',
  'Arrosage régulier, paillage':
      'Regular watering, mulching',
  'Aérer, ne pas arroser le feuillage, rotation':
      'Ventilate, do not water the foliage, crop rotation',
  'Mineuse':
      'Leaf miner',
  'Filet anti-insectes, supprimer les feuilles atteintes':
      'Insect-proof netting, remove affected leaves',
  'Bouillie bordelaise, rotation (4 ans minimum)':
      'Bordeaux mixture, crop rotation (4 years minimum)',
  'Mouche de l\'oignon':
      'Onion fly',
  'Filet anti-insectes, associer avec la carotte':
      'Insect-proof netting, plant alongside carrot',
  'Bouillie bordelaise préventive, butter les plants, variétés résistantes':
      'Preventive Bordeaux mixture, earth up the plants, resistant varieties',
  'Ramassage manuel des larves et adultes, Bacillus thuringiensis':
      'Hand-pick larvae and adults, Bacillus thuringiensis',
  'Piéride du chou':
      'Cabbage white butterfly',
  'Filet anti-insectes, Bacillus thuringiensis, ramasser les chenilles':
      'Insect-proof netting, Bacillus thuringiensis, pick off the caterpillars',
  'Hernie du chou':
      'Clubroot',
  'Rotation longue (7 ans), chauler le sol si trop acide':
      'Long rotation (7 years), lime the soil if too acidic',
  'Lait dilué, bicarbonate de soude, variétés résistantes':
      'Diluted milk, bicarbonate of soda, resistant varieties',
  'Savon noir, pyrèthre naturel':
      'Insecticidal soap, natural pyrethrum',
  'Altise':
      'Flea beetle',
  'Filet anti-insectes, arrosage fréquent (les altises détestent l\'humidité)':
      'Insect-proof netting, frequent watering (flea beetles hate damp)',
  'Savon noir, jet d\'eau puissant':
      'Insecticidal soap, strong jet of water',
  'Mouche blanche':
      'Whitefly',
  'Plaquettes jaunes engluées, savon noir':
      'Sticky yellow traps, insecticidal soap',
  'Botrytis (pourriture grise)':
      'Botrytis (grey mould)',
  'Pailler, aérer, ne pas mouiller les fruits':
      'Mulch, ventilate, do not wet the fruit',
  'Soufre, lait dilué':
      'Sulphur, diluted milk',
  'Savon noir':
      'Insecticidal soap',
  'Jassides (cicadelles)':
      'Leafhoppers',
  'Neem (huile ou purin), savon noir':
      'Neem (oil or brew), insecticidal soap',
  'Fusariose':
      'Fusarium wilt',
  'Rotation des cultures, variétés résistantes':
      'Crop rotation, resistant varieties',
  'Plaquettes jaunes engluées, savon noir sous les feuilles, huile de neem':
      'Sticky yellow traps, insecticidal soap under the leaves, neem oil',
  'Charançon de la patate douce':
      'Sweet potato weevil',
  'Rotation, boutures saines, récolte rapide':
      'Crop rotation, healthy cuttings, quick harvest',
  'Mosaïque du manioc':
      'Cassava mosaic disease',
  'Boutures certifiées saines, arracher les plants infectés':
      'Certified disease-free cuttings, pull up infected plants',
  'Cochenilles':
      'Scale insects',
  'Insectes auxiliaires, huile de neem':
      'Beneficial insects, neem oil',
  'Rotation, semenceaux sains, bouillie bordelaise':
      'Crop rotation, healthy seed tubers, Bordeaux mixture',
  'Bruche du niébé':
      'Cowpea weevil (bruchid beetle)',
  'Séchage rapide des graines, stockage hermétique, cendres':
      'Dry the seeds quickly, airtight storage, wood ash',
  'Thrips':
      'Thrips',
  'Huile de neem, plaquettes bleues collantes':
      'Neem oil, sticky blue traps',
  'Maruca (foreuse des gousses)':
      'Maruca (pod borer)',
  'Huile de neem dès la floraison, semis précoce, ramasser et détruire les gousses percées':
      'Neem oil from flowering onwards, early sowing, pick and destroy pierced pods',
  'Pyrale du maïs':
      'Corn borer',
  'Trichogrammes (guêpes parasitoïdes), Bacillus thuringiensis':
      'Trichogramma (parasitoid wasps), Bacillus thuringiensis',
  'Charbon du maïs':
      'Corn smut',
  'Rotation, détruire les galles avant éclatement':
      'Crop rotation, destroy the galls before they burst',
  'Chenille légionnaire d\'automne (Spodoptera frugiperda)':
      'Fall armyworm (Spodoptera frugiperda)',
  'Semis précoce dès les premières pluies, ramasser les chenilles dans le cornet, cendres ou sable dans le cornet, Bacillus thuringiensis':
      'Sow early with the first rains, hand-pick caterpillars from the whorl, put wood ash or sand in the whorl, Bacillus thuringiensis',
  'Striga (plante parasite)':
      'Striga (witchweed, a parasitic plant)',
  'Rotation avec des légumineuses (niébé, arachide), fumure organique généreuse, arracher avant floraison':
      'Rotate with legumes (cowpea, groundnut), plenty of organic manure, pull up before flowering',
  'Lait dilué, bicarbonate de soude':
      'Diluted milk, bicarbonate of soda',
  'Lait dilué, soufre':
      'Diluted milk, sulphur',
  'Rouille':
      'Rust',
  'Décoction de prêle préventive, supprimer et brûler les feuilles atteintes':
      'Preventive horsetail decoction, remove and burn affected leaves',
  'Pourriture blanche (sclérotinia)':
      'White rot (sclerotinia)',
  'Rotation longue (5 ans), éviter sols trop humides, paillage léger':
      'Long rotation (5 years), avoid waterlogged soil, light mulching',
  'Mouche de l\'ail':
      'Garlic fly',
  'Filet anti-insectes au printemps, biner souvent autour des plants':
      'Insect-proof netting in spring, hoe often around the plants',
  'Savon noir dilué, jet d\'eau, favoriser les coccinelles':
      'Diluted insecticidal soap, jet of water, encourage ladybirds',
  'Chenilles défoliatrices':
      'Leaf-eating caterpillars',
  'Bacillus thuringiensis, ramassage manuel le soir':
      'Bacillus thuringiensis, hand-picking in the evening',
  'Cercosporiose (taches foliaires)':
      'Cercospora (leaf spot)',
  'Rotation, supprimer les feuilles atteintes, éviter l\'arrosage du feuillage':
      'Crop rotation, remove affected leaves, avoid watering the foliage',
  'Cercosporiose':
      'Cercospora leaf spot',
  'Rotation 3-4 ans, variétés résistantes, éviter excès d\'humidité':
      'Crop rotation 3-4 years, resistant varieties, avoid excess moisture',
  'Rosette de l\'arachide':
      'Groundnut rosette',
  'Lutter contre les pucerons vecteurs au savon noir, semis précoce':
      'Control the aphids that spread it with insecticidal soap, sow early',
  'Iules et termites':
      'Millipedes and termites',
  'Cendres au sol, paillage léger, ne pas planter sur sols infestés':
      'Wood ash on the soil, light mulching, do not plant in infested soil',
  'Pulvériser du savon noir, attirer les coccinelles':
      'Spray insecticidal soap, attract ladybirds',
  'Décoction de prêle, lait dilué (10%), espacement suffisant':
      'Horsetail decoction, diluted milk (10%), enough spacing',
  'Vers blancs (hannetons)':
      'Chafer grubs (cockchafers)',
  'Travail du sol au printemps, ramassage des larves':
      'Dig the soil in spring, pick out the grubs',
  'Criocère de l\'asperge':
      'Asparagus beetle',
  'Ramassage manuel des adultes et larves, pyrèthre naturel en dernier recours':
      'Hand-pick adults and larvae, natural pyrethrum as a last resort',
  'Rouille de l\'asperge':
      'Asparagus rust',
  'Couper et brûler les tiges en automne, éviter excès d\'azote':
      'Cut and burn the stems in autumn, avoid too much nitrogen',
  'Mouche de l\'asperge':
      'Asparagus fly',
  'Filet anti-insectes au moment de la pousse, rotation des planches':
      'Insect-proof netting while the spears are growing, rotate the beds',
  'Rotation, ne pas replanter sur même emplacement, semis sain':
      'Crop rotation, do not replant in the same spot, sow healthy seed',
  'Savon noir dilué, jet d\'eau':
      'Diluted insecticidal soap, jet of water',
  'Pièges à bière, cendres autour des plants':
      'Beer traps, wood ash around the plants',
  'Rotation 3-4 ans, supprimer les feuilles atteintes, décoction de prêle':
      'Crop rotation 3-4 years, remove affected leaves, horsetail decoction',
  'Savon noir, favoriser les coccinelles':
      'Insecticidal soap, encourage ladybirds',
  'Mouche de la betterave':
      'Beet fly (mangold fly)',
  'Filet anti-insectes, supprimer les feuilles minées':
      'Insect-proof netting, remove mined leaves',
  'Savon noir, purin d\'ortie en pulvérisation':
      'Insecticidal soap, nettle brew as a spray',
  'Huile de neem, alcool à brûler dilué sur tige':
      'Neem oil, diluted methylated spirits on the stem',
  'Nématodes à galles':
      'Root-knot nematodes',
  'Rotation avec œillets d\'Inde (Tagetes), apports de compost mûr':
      'Rotate with French marigolds (Tagetes), add ripe compost',
  'Rotation, ne pas mouiller le feuillage, supprimer les feuilles atteintes':
      'Crop rotation, do not wet the foliage, remove affected leaves',
  'Mineuse de la betterave/blette':
      'Beet and chard leaf miner',
  'Filet anti-insectes, retirer les feuilles minées':
      'Insect-proof netting, remove mined leaves',
  'Filet anti-insectes, Bacillus thuringiensis, ramassage des chenilles':
      'Insect-proof netting, Bacillus thuringiensis, pick off the caterpillars',
  'Filet anti-insectes, arrosage fréquent, paillage':
      'Insect-proof netting, frequent watering, mulching',
  'Septoriose':
      'Septoria leaf spot',
  'Rotation 3 ans, éviter d\'arroser le feuillage, bouillie bordelaise préventive':
      'Crop rotation 3 years, avoid watering the foliage, preventive Bordeaux mixture',
  'Mouche du céleri':
      'Celery fly',
  'Pucerons cendrés':
      'Mealy (grey) aphids',
  'Savon noir, jet d\'eau, attirer les coccinelles':
      'Insecticidal soap, jet of water, attract ladybirds',
  'Rotation longue (7 ans), chaulage si sol acide':
      'Long rotation (7 years), liming if the soil is acidic',
  'Filet anti-insectes, Bacillus thuringiensis':
      'Insect-proof netting, Bacillus thuringiensis',
  'Filet, arrosage fréquent, paillage':
      'Netting, frequent watering, mulching',
  'Filet anti-insectes, Bacillus thuringiensis, ramassage manuel':
      'Insect-proof netting, Bacillus thuringiensis, hand-picking',
  'Filet anti-insectes, paillage et arrosage fréquent':
      'Insect-proof netting, mulching and frequent watering',
  'Couper les feuilles atteintes, décoction de prêle, éviter excès d\'azote':
      'Cut off affected leaves, horsetail decoction, avoid too much nitrogen',
  'Rotation, espacement suffisant, ne pas mouiller le feuillage':
      'Crop rotation, enough spacing, do not wet the foliage',
  'Plaquettes bleues collantes, jet d\'eau régulier':
      'Sticky blue traps, regular jet of water',
  'Lait dilué, espacement entre plants, aération':
      'Diluted milk, space plants out, good ventilation',
  'Fonte des semis':
      'Damping off',
  'Semis clair, terre saine, éviter excès d\'humidité':
      'Sow thinly, healthy soil, avoid excess moisture',
  'Bouillie bordelaise préventive, rotation 4 ans minimum':
      'Preventive Bordeaux mixture, crop rotation 4 years minimum',
  'Filet anti-insectes, association avec carotte':
      'Insect-proof netting, plant alongside carrot',
  'Pourriture blanche':
      'White rot',
  'Rotation longue, éviter sols trop humides':
      'Long rotation, avoid waterlogged soil',
  'Savon noir, jet d\'eau':
      'Insecticidal soap, jet of water',
  'Aérer, éviter humidité stagnante au forçage, retirer feuilles atteintes':
      'Ventilate, avoid stagnant damp during forcing, remove affected leaves',
  'Pièges à bière, cendres':
      'Beer traps, wood ash',
  'Filet anti-insectes (même famille Apiacées)':
      'Insect-proof netting (same family, Apiaceae)',
  'Sclérotinia':
      'Sclerotinia',
  'Rotation, espacement, éviter excès d\'arrosage':
      'Crop rotation, spacing, avoid overwatering',
  'Pincer les extrémités fleuries, savon noir, attirer coccinelles':
      'Pinch out the flowering tips, insecticidal soap, attract ladybirds',
  'Rouille de la fève':
      'Broad bean rust',
  'Décoction de prêle, supprimer les feuilles atteintes, rotation':
      'Horsetail decoction, remove affected leaves, crop rotation',
  'Bruche de la fève':
      'Broad bean weevil',
  'Récolte rapide, séchage et stockage hermétique au congélateur 48h':
      'Harvest promptly, dry, then store airtight in the freezer for 48 hours',
  'Pourriture du rhizome (Pythium)':
      'Rhizome rot (Pythium)',
  'Drainage soigné, rhizomes sains, éviter excès d\'eau':
      'Careful drainage, healthy rhizomes, avoid excess water',
  'Huile de neem, savon noir':
      'Neem oil, insecticidal soap',
  'Nématodes':
      'Nematodes',
  'Rotation, apports de matière organique, plantation d\'œillets d\'Inde':
      'Crop rotation, add organic matter, plant French marigolds',
  'Aérer, semis clair, éviter d\'arroser le feuillage':
      'Ventilate, sow thinly, avoid watering the foliage',
  'Espacement, ne pas pailler trop près du collet':
      'Space plants out, do not mulch too close to the crown',
  'Pièges à bière, cendres autour des planches':
      'Beer traps, wood ash around the beds',
  'Rouille de la menthe':
      'Mint rust',
  'Couper et brûler les tiges atteintes, décoction de prêle, diviser les touffes':
      'Cut and burn affected stems, horsetail decoction, divide the clumps',
  'Aérer, lait dilué, éviter excès d\'azote':
      'Ventilate, diluted milk, avoid too much nitrogen',
  'Mouche du navet/chou':
      'Cabbage root fly (turnip root fly)',
  'Filet anti-insectes, collerette en carton autour du collet':
      'Insect-proof netting, cardboard collar around the base',
  'Rotation longue (5-7 ans), chaulage si sol acide':
      'Long rotation (5-7 years), liming if the soil is acidic',
  'Couper et brûler les feuilles atteintes, décoction de prêle':
      'Cut and burn affected leaves, horsetail decoction',
  'Limaces et escargots':
      'Slugs and snails',
  'Pièges à bière, cendres autour des touffes':
      'Beer traps, wood ash around the clumps',
  'Savon noir dilué':
      'Diluted insecticidal soap',
  'Lait dilué (10%), soufre, bicarbonate de soude en pulvérisation':
      'Diluted milk (10%), sulphur, bicarbonate of soda spray',
  'Rotation 4 ans minimum, variétés résistantes, greffage':
      'Crop rotation 4 years minimum, resistant varieties, grafting',
  'Savon noir, attirer les coccinelles':
      'Insecticidal soap, attract ladybirds',
  'Filet anti-insectes, association avec poireau/oignon':
      'Insect-proof netting, plant alongside leek/onion',
  'Rotation, espacement suffisant, éviter d\'arroser le feuillage':
      'Crop rotation, enough spacing, avoid watering the foliage',
  'Lait dilué, semer tôt, variétés résistantes':
      'Diluted milk, sow early, resistant varieties',
  'Tordeuse du pois':
      'Pea moth',
  'Filet anti-insectes à la floraison, rotation':
      'Insect-proof netting at flowering, crop rotation',
  'Pucerons verts':
      'Green aphids (greenfly)',
  'Teigne du poireau':
      'Leek moth',
  'Filet anti-insectes (mailles fines), couper les feuilles atteintes':
      'Insect-proof netting (fine mesh), cut off affected leaves',
  'Mouche mineuse du poireau':
      'Leek leaf miner',
  'Filet anti-insectes en avril-mai et septembre-octobre':
      'Insect-proof netting in April-May and September-October',
  'Rouille du poireau':
      'Leek rust',
  'Lait dilué (10%), bicarbonate de soude, soufre':
      'Diluted milk (10%), bicarbonate of soda, sulphur',
  'Bouillie bordelaise préventive, ne pas mouiller le feuillage':
      'Preventive Bordeaux mixture, do not wet the foliage',
  'Filet anti-insectes, arrosage régulier, paillage':
      'Insect-proof netting, regular watering, mulching',
  'Aérer, ne pas arroser le feuillage':
      'Ventilate, do not water the foliage',
  'Flétrissement bactérien':
      'Bacterial wilt',
  'Rotation 3 ans, semences saines, drainage du sol':
      'Crop rotation 3 years, healthy seed, soil drainage',
  'Espacement, supprimer les feuilles atteintes, éviter excès d\'humidité':
      'Spacing, remove affected leaves, avoid excess moisture',
  'Charbon couvert du sorgho':
      'Covered smut of sorghum',
  'Semences traitées à l\'eau chaude, rotation 3 ans':
      'Hot-water-treated seed, crop rotation 3 years',
  'Pucerons des panicules':
      'Panicle aphids',
  'Savon noir au stade épiaison, attirer les auxiliaires':
      'Insecticidal soap at the heading stage, attract beneficial insects',
  'Foreuse des tiges':
      'Stem borer',
  'Détruire les chaumes après récolte, Bacillus thuringiensis':
      'Destroy the stubble after harvest, Bacillus thuringiensis',
  'Mildiou du taro (Phytophthora)':
      'Taro leaf blight (Phytophthora)',
  'Drainage du sol, rotation 3 ans, plants sains':
      'Soil drainage, crop rotation 3 years, healthy plants',
  'Pourriture du corme':
      'Corm rot',
  'Éviter blessures à la plantation, sol bien drainé':
      'Avoid wounding at planting, well-drained soil',
  'Pourriture racinaire':
      'Root rot',
  'Sol très drainant, éviter arrosage excessif, butter légèrement':
      'Very free-draining soil, avoid overwatering, earth up lightly',
  'Huile de neem, alcool à brûler dilué au coton-tige':
      'Neem oil, diluted methylated spirits on a cotton bud',
  'Araignées rouges':
      'Red spider mites',
  'Brumisations régulières (préfèrent l\'air sec)':
      'Regular misting (they prefer dry air)',
  'Mineuse de l\'épi du mil':
      'Millet head miner',
  'Semis précoce et groupé au village, détruire les chaumes après récolte':
      'Early, synchronised sowing across the village, destroy the stubble after harvest',
  'Rotation avec des légumineuses (niébé, arachide), fumure organique, arracher avant floraison':
      'Rotate with legumes (cowpea, groundnut), organic manure, pull up before flowering',
  'Oiseaux granivores (mange-mil)':
      'Grain-eating birds (weaver birds)',
  'Filets ou épouvantails à maturité, récolter dès que les grains durcissent':
      'Nets or scarecrows as the crop ripens, harvest as soon as the grains harden',
  'Semis clair sur sol drainé, éviter les excès d\'eau à la levée':
      'Sow thinly in well-drained soil, avoid too much water at emergence',
  'Ramassage manuel le soir, Bacillus thuringiensis, tailler pour faire repartir le feuillage':
      'Hand-pick in the evening, Bacillus thuringiensis, prune to encourage fresh foliage',
  'Termites (jeunes plants)':
      'Termites (young plants)',
  'Cendres au pied, arrosages réguliers la première année, éviter le bois mort au sol':
      'Wood ash at the base, regular watering in the first year, avoid dead wood on the ground',
  'Rotation longue, plants sains, arracher et détruire les pieds flétris':
      'Long rotation, healthy plants, pull up and destroy wilted plants',
  'Foreuse des fruits et des tiges':
      'Fruit and shoot borer',
  'Ramasser les fruits percés, huile de neem, filet anti-insectes en pépinière':
      'Pick up bored fruit, neem oil, insect-proof netting in the nursery',
  'Altises':
      'Flea beetles',
  'Garder le sol humide, filet anti-insectes, semis dense':
      'Keep the soil moist, insect-proof netting, sow densely',
  'Rotation, apports de compost mûr, planter des œillets d\'Inde (Tagetes)':
      'Crop rotation, add ripe compost, plant French marigolds (Tagetes)',
  'Espacement suffisant, supprimer les feuilles atteintes, éviter d\'arroser le feuillage':
      'Enough spacing, remove affected leaves, avoid watering the foliage',
  'Ramassage manuel le soir, Bacillus thuringiensis':
      'Hand-pick in the evening, Bacillus thuringiensis',
  'Taches foliaires (Cercospora)':
      'Leaf spot (Cercospora)',
  'Aérer, récolter souvent, supprimer les feuilles atteintes':
      'Ventilate, harvest often, remove affected leaves',
  'Pièges à bière, cendres au pied, ramassage le soir':
      'Beer traps, wood ash at the base, hand-pick in the evening',
  'Rouille de la citronnelle':
      'Lemongrass rust',
  'Couper et brûler les feuilles atteintes, diviser les touffes trop denses':
      'Cut and burn affected leaves, divide clumps that are too dense',
  'Savon noir, huile de neem à la base des tiges':
      'Insecticidal soap, neem oil at the base of the stems',
  'Cochenilles farineuses':
      'Mealybugs',
  'Savon noir, huile de neem, favoriser les coccinelles':
      'Insecticidal soap, neem oil, encourage ladybirds',
  'Virose ringspot (PRSV)':
      'Papaya ringspot virus (PRSV)',
  'Maladie virale incurable — arracher les plants atteints, lutter contre les pucerons vecteurs, replanter ailleurs':
      'Incurable viral disease — pull up affected plants, control the aphids that spread it, replant elsewhere',
  'Charançon du bananier':
      'Banana weevil',
  'Rejets sains (parés et trempés), pièges à disques de pseudo-tronc, détruire les souches après récolte':
      'Healthy suckers (pared and dipped), pseudostem disc traps, destroy the stumps after harvest',
  'Cercosporiose noire':
      'Black Sigatoka',
  'Supprimer et brûler les feuilles striées, aérer la parcelle, éviter l\'eau stagnante':
      'Remove and burn the streaked leaves, ventilate the plot, avoid standing water',
  'Tavelure du pommier':
      'Apple scab',
  'Bouillie bordelaise dès le débourrement, ramasser les feuilles tombées en automne, variétés résistantes (Reine des Reinettes, Belle de Boskoop)':
      'Bordeaux mixture from bud burst, collect fallen leaves in autumn, resistant varieties (Reine des Reinettes, Belle de Boskoop)',
  'Carpocapse (ver de la pomme)':
      'Codling moth (apple worm)',
  'Pièges à phéromones en mai-juin, glu sur le tronc, bandes-pièges en carton ondulé':
      'Pheromone traps in May-June, sticky glue band on the trunk, corrugated cardboard trap bands',
  'Savon noir, traiter au stade rosé, favoriser coccinelles et syrphes':
      'Insecticidal soap, spray at the pink bud stage, encourage ladybirds and hoverflies',
  'Soufre micronisé au débourrement, supprimer les pousses atteintes':
      'Micronised sulphur at bud burst, remove affected shoots',
  'Tavelure du poirier':
      'Pear scab',
  'Bouillie bordelaise au débourrement, ramasser les feuilles, traiter à la chute des pétales':
      'Bordeaux mixture at bud burst, collect the leaves, spray at petal fall',
  'Feu bactérien':
      'Fire blight',
  'Maladie à déclaration obligatoire — couper et brûler les rameaux atteints 30 cm en dessous, désinfecter les outils':
      'Notifiable disease — cut and burn affected shoots 30 cm below the damage, disinfect tools',
  'Psylle du poirier':
      'Pear sucker (pear psylla)',
  'Argile blanche au débourrement, favoriser les forficules (perce-oreilles)':
      'White clay (kaolin) at bud burst, encourage earwigs',
  'Rouille grillagée':
      'Pear rust (trellis rust)',
  'Éloigner les genévriers (hôtes alternants), supprimer les feuilles atteintes':
      'Keep junipers (alternate hosts) away, remove affected leaves',
  'Moniliose':
      'Brown rot (Monilinia)',
  'Supprimer les fruits momifiés sur l\'arbre, bouillie bordelaise à la chute des feuilles et au débourrement':
      'Remove mummified fruit from the tree, Bordeaux mixture at leaf fall and at bud burst',
  'Puceron noir du prunier':
      'Black plum aphid',
  'Savon noir au stade rosé, couper les pousses atteintes et brûler':
      'Insecticidal soap at the pink bud stage, cut off affected shoots and burn them',
  'Carpocapse des prunes':
      'Plum fruit moth',
  'Pièges à phéromones, ramasser les fruits tombés, glu sur le tronc':
      'Pheromone traps, collect fallen fruit, sticky glue band on the trunk',
  'Huile blanche en hiver, brossage des troncs':
      'White oil in winter, brushing the trunks',
  'Mouche de la cerise':
      'Cherry fruit fly',
  'Pièges chromatiques jaunes englués dès mi-mai, variétés précoces (Burlat) qui échappent au pic':
      'Sticky yellow colour traps from mid-May, early varieties (Burlat) that miss the peak',
  'Supprimer les fruits momifiés, traiter à la chute des fleurs avec bouillie bordelaise':
      'Remove mummified fruit, spray with Bordeaux mixture at petal fall',
  'Puceron noir du cerisier':
      'Cherry blackfly',
  'Savon noir, jet d\'eau puissant, supprimer les pousses très atteintes':
      'Insecticidal soap, strong jet of water, remove heavily infested shoots',
  'Drosophile suzukii':
      'Spotted wing drosophila (Drosophila suzukii)',
  'Filets anti-insectes mailles 0,8 mm, pièges à vinaigre, récolter rapidement':
      'Insect-proof netting with 0.8 mm mesh, vinegar traps, harvest quickly',
  'Bouillie bordelaise à la chute des feuilles et au débourrement, supprimer les fruits atteints':
      'Bordeaux mixture at leaf fall and at bud burst, remove affected fruit',
  'Soufre dès l\'apparition, aérer la couronne par taille':
      'Sulphur as soon as it appears, open up the crown by pruning',
  'Bactériose':
      'Bacterial canker',
  'Tailler en été (sec) pour éviter les chancres, désinfecter les outils, badigeon de chaux sur le tronc':
      'Prune in summer (in dry weather) to avoid cankers, disinfect tools, whitewash the trunk with lime',
  'Savon noir au printemps, favoriser coccinelles':
      'Insecticidal soap in spring, encourage ladybirds',
  'Cloque du pêcher':
      'Peach leaf curl',
  'Bouillie bordelaise à la chute des feuilles, puis 2 traitements au débourrement avant que les bourgeons ne s\'ouvrent. Décoction de prêle préventive':
      'Bordeaux mixture at leaf fall, then 2 sprays at bud burst before the buds open. Preventive horsetail decoction',
  'Soufre dès apparition, supprimer les rameaux atteints':
      'Sulphur as soon as it appears, remove affected shoots',
  'Tordeuse orientale':
      'Oriental fruit moth',
  'Pièges à phéromones, supprimer les rameaux flétris':
      'Pheromone traps, remove wilted shoots',
  'Savon noir, plantation d\'ail au pied (effet répulsif)':
      'Insecticidal soap, plant garlic at the base (repellent effect)',
  'Mosaïque du figuier':
      'Fig mosaic',
  'Maladie virale incurable — supprimer les rameaux les plus atteints, fertiliser pour soutenir l\'arbre':
      'Incurable viral disease — remove the most affected shoots, feed to support the tree',
  'Brossage des branches, huile blanche en hiver':
      'Brushing the branches, white oil in winter',
  'Mouche de la figue':
      'Fig fly',
  'Pièges chromatiques, récolter rapidement à maturité':
      'Colour traps, harvest promptly when ripe',
  'Balanin du noisetier':
      'Hazelnut weevil',
  'Bâcher au sol en juin pour récupérer les larves tombantes, ramasser les noisettes véreuses':
      'Lay a tarpaulin on the ground in June to catch the falling larvae, pick up wormy nuts',
  'Phytopte du noisetier':
      'Hazel big bud mite',
  'Soufre au débourrement, supprimer les bourgeons hypertrophiés en hiver':
      'Sulphur at bud burst, remove swollen buds in winter',
  'Bactériose (Xanthomonas)':
      'Bacterial blight (Xanthomonas)',
  'Tailler en été, désinfecter les outils, supprimer les rameaux atteints':
      'Prune in summer, disinfect tools, remove affected shoots',
  'Mildiou de la vigne':
      'Downy mildew of the grapevine',
  'Bouillie bordelaise dès stade 5-6 feuilles, renouveler après pluies importantes, palissage pour aérer':
      'Bordeaux mixture from the 5-6 leaf stage, repeat after heavy rain, train the vines on wires to let air through',
  'Soufre poudre ou mouillable dès la 3e feuille, traitements préventifs réguliers':
      'Dusting or wettable sulphur from the 3rd leaf, regular preventive sprays',
  'Eudémis (vers de la grappe)':
      'European grapevine moth (grape berry moth)',
  'Pièges à phéromones, confusion sexuelle, Bacillus thuringiensis sur les jeunes chenilles':
      'Pheromone traps, mating disruption, Bacillus thuringiensis on young caterpillars',
  'Black-rot':
      'Black rot',
  'Bouillie bordelaise, supprimer les feuilles et grappes atteintes, ramasser les momies':
      'Bordeaux mixture, remove affected leaves and bunches, collect the mummified berries',
  'PSA (chancre bactérien)':
      'Psa (bacterial canker)',
  'Maladie à déclaration — éviter blessures de taille, désinfecter outils, supprimer rameaux atteints jusqu\'au bois sain':
      'Notifiable disease — avoid pruning wounds, disinfect tools, cut affected shoots back to healthy wood',
  'Aérer la palissade, ne pas blesser les fruits, récolte au sec':
      'Ventilate the trellis, do not injure the fruit, harvest in dry weather',
  'Rouille du framboisier':
      'Raspberry rust',
  'Supprimer les feuilles atteintes, bouillie bordelaise à la chute des feuilles':
      'Remove affected leaves, Bordeaux mixture at leaf fall',
  'Filets anti-insectes mailles 0,8 mm, pièges à vinaigre, récolter tôt le matin':
      'Insect-proof netting with 0.8 mm mesh, vinegar traps, harvest early in the morning',
  'Aérer les rameaux, pailler, ne pas mouiller les fruits':
      'Ventilate the canes, mulch, do not wet the fruit',
  'Rouille du cassis':
      'Blackcurrant rust',
  'Supprimer les feuilles atteintes, bouillie bordelaise au débourrement':
      'Remove affected leaves, Bordeaux mixture at bud burst',
  'Phytopte du cassis (gros bourgeon)':
      'Blackcurrant gall mite (big bud)',
  'Couper et brûler les bourgeons gonflés en hiver, soufre au débourrement':
      'Cut and burn swollen buds in winter, sulphur at bud burst',
  'Savon noir au stade rosé':
      'Insecticidal soap at the pink bud stage',
  'Tenthrède du groseillier':
      'Gooseberry sawfly',
  'Ramassage manuel des chenilles, Bacillus thuringiensis':
      'Hand-pick the caterpillars, Bacillus thuringiensis',
  'Oïdium américain':
      'American gooseberry mildew',
  'Soufre, aérer par la taille':
      'Sulphur, open up the bush by pruning',
  'Supprimer les rameaux atteints, bouillie bordelaise à la chute des feuilles':
      'Remove affected shoots, Bordeaux mixture at leaf fall',
  'Filets anti-insectes, récolter rapidement':
      'Insect-proof netting, harvest promptly',
  'Pourriture des fruits (Botrytis)':
      'Fruit rot (Botrytis)',
  'Aérer, pailler, ne pas mouiller les fruits':
      'Ventilate, mulch, do not wet the fruit',
  'Chlorose ferrique':
      'Iron chlorosis',
  'Sol trop calcaire — apporter de la terre de bruyère, arroser à l\'eau de pluie, chélate de fer en pulvérisation':
      'Soil too chalky — add ericaceous compost, water with rainwater, iron chelate spray',
  'Pourriture du collet':
      'Crown rot',
  'Sol bien drainé, ne pas planter en zone humide, supprimer la zone atteinte':
      'Well-drained soil, do not plant in a damp spot, cut out the affected area',
  'Charançon de la rhubarbe':
      'Rhubarb weevil',
  'Ramassage manuel le soir, paillage de fougères':
      'Hand-pick in the evening, bracken mulch',

  // ─── badges (100 phrases, 312 mots) ───
  'Premier pas':
      'First steps',
  'Planter ton premier légume.':
      'Plant your first vegetable.',
  'Carnet ouvert':
      'Open journal',
  'Écrire une note sur un de tes plants.':
      'Write a note about one of your plants.',
  'Baptême d\'eau':
      'First splash',
  'Arroser un plant pour la première fois.':
      'Water a plant for the first time.',
  'Première case':
      'First square',
  'Placer un légume dans un potager carré.':
      'Place a vegetable in a square-foot garden.',
  'Coup de cœur':
      'Favourite',
  'Mettre un légume en favori.':
      'Mark a vegetable as a favourite.',
  '1er cliché':
      '1st snap',
  'Compléter ton tout premier défi photo.':
      'Complete your very first photo challenge.',
  'Régulier':
      'Regular',
  'Arroser 3 jours d\'affilée.':
      'Water 3 days in a row.',
  'Matinal':
      'Morning glory',
  'Arroser avant 9 h du matin.':
      'Water before 9h.',
  'Nocturne':
      'After dark',
  'Arroser après 21 h.':
      'Water after 21h.',
  'Panier varié':
      'Mixed basket',
  'Planter dans 3 familles différentes.':
      'Plant from 3 different families.',
  'Germe':
      'Sprout',
  '5 plants à ton actif.':
      '5 plants to your name.',
  'Butineur':
      'Busy bee',
  'Planter une fleur.':
      'Plant a flower.',
  'Parfumé':
      'Fragrant',
  'Planter un aromate.':
      'Plant a herb.',
  'Premier jardin':
      'First garden',
  'Créer ton premier jardin.':
      'Create your first garden.',
  'Arroseur':
      'Sprinkler',
  '5 arrosages au total.':
      '5 waterings in total.',
  'Pousse':
      'Shoot',
  '10 plants à ton actif.':
      '10 plants to your name.',
  'Bourgeon':
      'Bud',
  '20 plants à ton actif.':
      '20 plants to your name.',
  'Arrosoir d\'argent':
      'Silver watering can',
  '20 arrosages au total.':
      '20 waterings in total.',
  'Dix cases':
      'Ten squares',
  'Remplir 10 cases de potager carré.':
      'Fill 10 squares of a square-foot garden.',
  'Album':
      'Album',
  '10 photos de plants.':
      '10 plant photos.',
  'Photographe':
      'Photographer',
  'Compléter 5 défis photo.':
      'Complete 5 photo challenges.',
  'Semaine entière':
      'Full week',
  'Arroser 7 jours d\'affilée.':
      'Water 7 days in a row.',
  'Polyvalent':
      'All-rounder',
  'Des défis de 3 paliers différents.':
      'Challenges from 3 different tiers.',
  'Noctambule':
      'Night owl',
  '5 arrosages après 21 h.':
      '5 waterings after 21h.',
  'Lève-tôt':
      'Early bird',
  '5 arrosages avant 9 h.':
      '5 waterings before 9h.',
  'Patience':
      'Patience',
  'Suivre un même plant pendant 30 jours.':
      'Follow the same plant for 30 days.',
  'Jardinier d\'hiver':
      'Winter gardener',
  'Planter en hiver.':
      'Plant in winter.',
  'Plein été':
      'Midsummer',
  'Planter en été.':
      'Plant in summer.',
  'Cinq espèces':
      'Five species',
  'Planter 5 espèces différentes.':
      'Plant 5 different species.',
  'Trio':
      'Trio',
  '15 arrosages, 5 récoltes et 5 photos.':
      '15 waterings, 5 harvests and 5 photos.',
  'Fleur':
      'Flower',
  '30 plants à ton actif.':
      '30 plants to your name.',
  'Plante':
      'Plant',
  '50 plants à ton actif.':
      '50 plants to your name.',
  'Quinze espèces':
      'Fifteen species',
  'Planter 15 espèces différentes.':
      'Plant 15 different species.',
  'Vingt-cinq espèces':
      'Twenty-five species',
  'Planter 25 espèces différentes.':
      'Plant 25 different species.',
  'Océan':
      'Ocean',
  '100 arrosages au total.':
      '100 waterings in total.',
  'Carré complet':
      'Full square',
  'Remplir toutes les cases d\'un jardin.':
      'Fill every square of a garden.',
  'Artiste':
      'Artist',
  'Compléter 15 défis photo.':
      'Complete 15 photo challenges.',
  'Trente jours':
      'Thirty days',
  'Arroser 30 jours d\'affilée.':
      'Water 30 days in a row.',
  'Trois jardins':
      'Three gardens',
  'Créer 3 jardins.':
      'Create 3 gardens.',
  'Bronze complet':
      'Full bronze',
  'Compléter tous les défis bronze.':
      'Complete all the bronze challenges.',
  'Argent complet':
      'Full silver',
  'Compléter tous les défis argent.':
      'Complete all the silver challenges.',
  'Quatre saisons':
      'Four seasons',
  'Planter aux quatre saisons.':
      'Plant in all four seasons.',
  'Centenaire':
      'Centenarian',
  '100 plants à ton actif.':
      '100 plants to your name.',
  'Complétionniste':
      'Completionist',
  'Compléter les 50 défis photo.':
      'Complete all 50 photo challenges.',
  'Cent jours':
      'Hundred days',
  'Arroser 100 jours d\'affilée.':
      'Water 100 days in a row.',
  'Or complet':
      'Full gold',
  'Compléter tous les défis or.':
      'Complete all the gold challenges.',
  'Shiny complet':
      'Full shiny',
  'Compléter tous les défis shiny.':
      'Complete all the shiny challenges.',
  'Vétéran':
      'Veteran',
  '50 récoltes au total.':
      '50 harvests in total.',
  'Rare':
      'Rare',
  'Débloquer 40 badges.':
      'Unlock 40 badges.',
  'Ultime':
      'Ultimate',
  'Débloquer les 49 autres badges.':
      'Unlock the other 49 badges.',

  // ─── defis (110 phrases, 553 mots) ───
  'Germination':
      'Germination',
  'Photographie les premiers jours d\'un semis.':
      'Photograph the first days of a seedling.',
  'Premier bourgeon':
      'First bud',
  'Capture la première fleur qui apparaît sur un plant.':
      'Capture the first flower to appear on a plant.',
  'Selfie du jardinier':
      'Gardener selfie',
  'Prends-toi en photo en train de jardiner.':
      'Take a photo of yourself gardening.',
  'Outil préféré':
      'Favourite tool',
  'Montre ton outil de jardinage favori en action.':
      'Show your favourite gardening tool in action.',
  'Mon coin secret':
      'My secret corner',
  'Vue d\'ensemble de ton potager — montre ton royaume.':
      'An overview of your veg patch — show off your kingdom.',
  'Terre à terre':
      'Down to earth',
  'Macro de la terre, des vers ou de la vie du sol.':
      'A close-up of the soil, the worms or the life beneath your feet.',
  'Récolte du dimanche':
      'Sunday harvest',
  'Ton panier de récolte de la semaine.':
      'Your harvest basket for the week.',
  'Jungle urbaine':
      'Urban jungle',
  'Ton potager en ville : balcon, toit ou rebord de fenêtre.':
      'Your veg patch in the city: balcony, roof or windowsill.',
  'Fleur surprise':
      'Surprise flower',
  'Une fleur inattendue qui a poussé dans ton potager.':
      'An unexpected flower that has grown in your veg patch.',
  'Comparaison':
      'Comparison',
  'Ton légume à côté d\'un objet du quotidien pour montrer sa taille.':
      'Your vegetable next to an everyday object to show its size.',
  'Soleil':
      'Sunshine',
  'Un tournesol en fleur dans ton potager.':
      'A sunflower in bloom in your veg patch.',
  'Récolte racine':
      'Root harvest',
  'Une carotte, radis ou betterave fraîchement extraite.':
      'A carrot, radish or beetroot freshly pulled up.',
  'Pot mignon':
      'Cute pot',
  'Ton pot le plus décoré ou original.':
      'Your most decorated or original pot.',
  'Tisane maison':
      'Homemade herbal tea',
  'Tes aromatiques prêtes à infuser.':
      'Your herbs, ready to infuse.',
  'Oiseau jardinier':
      'Garden bird',
  'Un oiseau qui visite ton jardin.':
      'A bird visiting your garden.',
  'Le plus moche':
      'The ugliest',
  'Ton légume le plus raté, bizarre ou moche. Assume !':
      'Your most failed, weird or ugly vegetable. Own it!',
  'Mini récolte':
      'Mini harvest',
  'Le plus petit truc que tu aies jamais récolté.':
      'The tiniest thing you have ever harvested.',
  'Forme bizarre':
      'Odd shape',
  'Un légume à la forme complètement WTF.':
      'A vegetable with a completely bonkers shape.',
  'Colocataire':
      'Lodger',
  'Un insecte ou animal surprise sur tes plants.':
      'A surprise insect or animal on your plants.',
  'Invasion':
      'Invasion',
  'Limaces, pucerons, chenilles — les visiteurs pas invités.':
      'Slugs, aphids, caterpillars — the uninvited guests.',
  'Du jardin à l\'assiette':
      'Garden to plate',
  'Un plat cuisiné avec TES légumes du jardin.':
      'A dish cooked with YOUR garden vegetables.',
  'Main verte':
      'Green fingers',
  'Ta main à côté de ta plus belle récolte.':
      'Your hand next to your finest harvest.',
  'Oups':
      'Oops',
  'Un plant qui n\'a pas survécu. RIP.':
      'A plant that did not make it. RIP.',
  'Le goûteur':
      'The taster',
  'Croque dans un légume directement au jardin.':
      'Bite into a vegetable right there in the garden.',
  'Jardin en famille':
      'Family garden',
  'Jardiner avec quelqu\'un — famille, amis, voisins.':
      'Gardening with someone — family, friends, neighbours.',
  'Volontaire':
      'Volunteer',
  'Un légume qui a poussé tout seul, sans être planté.':
      'A vegetable that grew all by itself, without being planted.',
  'Légume-visage':
      'Veggie face',
  'Un légume qui ressemble à un visage.':
      'A vegetable that looks like a face.',
  'Monochrome':
      'Monochrome',
  'Une récolte d\'une seule couleur dominante.':
      'A harvest of one dominant colour.',
  'Composition':
      'Composition',
  'Un arrangement artistique de tes légumes.':
      'An artistic arrangement of your vegetables.',
  'Compost':
      'Compost',
  'Ton bac à compost en action.':
      'Your compost bin in action.',
  'Poids lourd':
      'Heavyweight',
  'Ton plus gros légume — avec un objet pour l\'échelle.':
      'Your biggest vegetable — with an object for scale.',
  'Plus grand que moi':
      'Taller than me',
  'Un plant ou légume qui te dépasse en taille.':
      'A plant or vegetable that is taller than you.',
  'Avant / Après':
      'Before / After',
  'Même angle, 2 mois d\'écart. La magie de la croissance.':
      'Same angle, 2 months apart. The magic of growth.',
  'Golden hour':
      'Golden hour',
  'Ton potager baigné dans la lumière du coucher de soleil.':
      'Your veg patch bathed in sunset light.',
  'Récolte arc-en-ciel':
      'Rainbow harvest',
  'Des légumes de 5 couleurs différentes ensemble.':
      'Vegetables of 5 different colours together.',
  'Sous la pluie':
      'In the rain',
  'Jardiner malgré le mauvais temps. Le vrai dévouement.':
      'Gardening despite the bad weather. True dedication.',
  'Le partage':
      'Sharing is caring',
  'Donner des légumes à un voisin, un ami, un inconnu.':
      'Give vegetables to a neighbour, a friend, a stranger.',
  'Photo-safari':
      'Photo safari',
  '3 insectes différents capturés en photo au jardin.':
      '3 different insects captured on camera in the garden.',
  'Givre':
      'Frost',
  'Ton jardin couvert de givre au petit matin.':
      'Your garden covered in frost in the early morning.',
  'Harmattan':
      'Harmattan',
  'Ton jardin dans la brume sèche de l\'harmattan.':
      'Your garden in the dry haze of the harmattan.',
  'Halloween':
      'Halloween',
  'Une courge ou citrouille sculptée.':
      'A carved squash or pumpkin.',
  'Panier de gombo':
      'Okra basket',
  'Ta plus belle récolte de gombo dans un panier.':
      'Your finest okra harvest in a basket.',
  'Barbecue':
      'Barbecue',
  'Tes légumes sur le grill.':
      'Your vegetables on the grill.',
  'Offert':
      'A gift',
  'Une fleur ou un légume offert en cadeau.':
      'A flower or vegetable given as a present.',
  'Bouquet':
      'Bouquet',
  'Un bouquet entièrement composé de ton jardin.':
      'A bouquet made entirely from your garden.',
  'Night garden':
      'Night garden',
  'Ton potager de nuit — lampe, flash, ambiance mystère.':
      'Your veg patch at night — lamp, flash, mystery mood.',
  'Saison morte':
      'Off season',
  'Ton jardin en plein hiver. La beauté dans le repos.':
      'Your garden in the depths of winter. Beauty in rest.',
  'Cœur de saison sèche':
      'Heart of the dry season',
  'Ton jardin en pleine saison sèche. La vie malgré la soif.':
      'Your garden in the middle of the dry season. Life despite the thirst.',
  'Ciel étoilé':
      'Starry sky',
  'Ton jardin sous un ciel étoilé visible.':
      'Your garden under a clear starry sky.',
  '14 juillet':
      '14 July',
  'Ton jardin pendant les feux d\'artifice.':
      'Your garden during the fireworks.',
  'Premières pluies':
      'First rains',
  'Ton jardin sous la première grande pluie de l\'hivernage.':
      'Your garden under the first big rain of the rainy season.',
  'Trèfle 4 feuilles':
      '4-leaf clover',
  'Un vrai trèfle à 4 feuilles trouvé au jardin.':
      'A real 4-leaf clover found in the garden.',
  'Pousse surprise':
      'Surprise sprout',
  'Une plante spontanée inattendue découverte dans ton jardin.':
      'An unexpected wild plant discovered in your garden.',
  'Rareté':
      'Rarity',
  'Une espèce rare ou inhabituelle dans ton jardin.':
      'A rare or unusual species in your garden.',
  'Menu 100% jardin':
      '100% garden menu',
  'Un repas complet où tout vient de ton jardin.':
      'A whole meal where everything comes from your garden.',

  // ─── lexique (162 phrases, 2469 mots) ───
  'solanacées':
      'nightshades (Solanaceae)',
  'Famille botanique qui regroupe tomate, aubergine, poivron, piment, pomme de terre. Tous ces légumes sont sensibles au mildiou et partagent souvent les mêmes maladies — d\'où la règle de rotation qui déconseille de les replanter au même endroit avant 3-4 ans.':
      'A botanical family that includes tomato, aubergine, pepper, chilli and potato. All of them are prone to late blight and often share the same diseases — hence the rotation rule that says not to replant them in the same spot for 3-4 years.',
  'rotation':
      'crop rotation',
  'Changer chaque année l\'emplacement des familles de légumes pour éviter que le sol ne s\'épuise et que les maladies ne s\'installent. Règle générale : attendre 3 à 4 ans avant de replanter la même famille au même endroit.':
      'Change the position of each vegetable family every year so the soil does not wear out and diseases do not settle in. General rule: wait 3 to 4 years before planting the same family in the same place.',
  'compagnonnage':
      'companion planting',
  'Associer des plantes qui s\'entraident : certaines repoussent les parasites de leurs voisines, d\'autres enrichissent le sol ou attirent les pollinisateurs. Exemple classique : carotte + poireau.':
      'Pairing plants that help each other: some repel their neighbours\' pests, others enrich the soil or attract pollinators. Classic example: carrot + leek.',
  'mildiou':
      'late blight / downy mildew',
  'Maladie fongique qui apparaît par temps humide et tiède. Provoque des taches brunes sur les feuilles et pourrit les fruits. Touche surtout tomates, pommes de terre, vignes. Traitement bio : bouillie bordelaise, aération des plants et arrosage au pied.':
      'A fungal disease that appears in damp, mild weather. It causes brown patches on the leaves and rots the fruit. It mostly hits tomatoes, potatoes and vines. Organic treatment: Bordeaux mixture, good airflow between plants and watering at the base.',
  'bouillie bordelaise':
      'Bordeaux mixture',
  'Fongicide à base de sulfate de cuivre et de chaux, autorisé en agriculture biologique. Utilisée contre le mildiou et d\'autres maladies cryptogamiques. À doser avec modération — le cuivre s\'accumule dans le sol.':
      'A fungicide made from copper sulphate and lime, permitted in organic growing. Used against blight and other fungal diseases. Use it sparingly — copper builds up in the soil.',
  'paillage':
      'mulching',
  'Couvrir le sol au pied des plants avec de la matière organique (paille, feuilles mortes, tontes séchées). Garde l\'humidité, limite les mauvaises herbes et nourrit le sol en se décomposant.':
      'Covering the soil around your plants with organic matter (straw, dead leaves, dried grass clippings). It holds in moisture, keeps weeds down and feeds the soil as it breaks down.',
  'compost':
      'compost',
  'Terreau obtenu par décomposition naturelle des déchets de cuisine et du jardin. Améliore la structure du sol, nourrit les plantes, et se produit en 6 à 12 mois.':
      'Rich, crumbly soil improver made by the natural breakdown of kitchen and garden waste. It improves soil structure, feeds your plants, and takes 6 to 12 months to make.',
  'repiquage':
      'transplanting',
  'Transplanter un jeune plant de l\'endroit où il a germé vers sa place définitive au potager. À faire quand le plant a 4-6 vraies feuilles, de préférence en soirée pour limiter le stress hydrique.':
      'Moving a young plant from where it germinated to its final spot in the veg patch. Do it when the plant has 4-6 true leaves, preferably in the evening to limit water stress.',
  'levée':
      'emergence',
  'Moment où la graine sort de terre et développe ses premières feuilles (cotylédons). Durée variable selon l\'espèce (radis : 3-5 jours, carotte : 15-20 jours).':
      'The moment the seed pushes up out of the soil and grows its first leaves (seed leaves). The time varies by species (radish: 3-5 days, carrot: 15-20 days).',
  'éclaircissage':
      'thinning out',
  'Supprimer les jeunes plants en surnombre pour laisser aux restants l\'espace, la lumière et les nutriments nécessaires. À faire dès que les plants ont 2-3 vraies feuilles.':
      'Removing the surplus seedlings to give the rest the space, light and nutrients they need. Do it as soon as the plants have 2-3 true leaves.',
  'buttage':
      'earthing up',
  'Ramener de la terre au pied des plants pour former une petite butte. Favorise l\'enracinement (tomates), protège les tubercules de la lumière (pommes de terre) ou améliore le drainage.':
      'Drawing soil up around the base of your plants to form a little mound. It encourages rooting (tomatoes), protects tubers from the light (potatoes) or improves drainage.',
  'vivace':
      'perennial',
  'Plante qui vit plusieurs années, au contraire d\'une annuelle (cycle complet en une saison). Exemples au potager : rhubarbe, artichaut, asperge, ciboulette.':
      'A plant that lives for several years, as opposed to an annual (a full cycle in one season). Examples in the veg patch: rhubarb, artichoke, asparagus, chives.',
  'annuelle':
      'annual',
  'Plante qui accomplit tout son cycle (germination, floraison, production de graines, mort) en une seule année. La plupart des légumes sont annuels : tomate, courgette, laitue.':
      'A plant that completes its whole cycle (germination, flowering, seed production, death) in a single year. Most vegetables are annuals: tomato, courgette, lettuce.',
  'bisannuelle':
      'biennial',
  'Plante dont le cycle s\'étale sur deux ans : la première année, elle développe ses feuilles et racines, la seconde elle fleurit et produit des graines. Exemples : carotte, betterave, oignon porte-graine.':
      'A plant whose cycle stretches over two years: in the first it grows leaves and roots, in the second it flowers and sets seed. Examples: carrot, beetroot, onion left to go to seed.',
  'godet':
      'plant pot',
  'Petit pot individuel (souvent en plastique ou tourbe) pour faire germer et élever un jeune plant avant de le repiquer en pleine terre. Taille typique : 7 à 10 cm.':
      'A small individual pot (often plastic or peat) for sprouting and raising a young plant before it goes out into the ground. Typical size: 7 to 10 cm.',
  'terreau':
      'potting compost',
  'Substrat cultivé prêt à l\'emploi, mélange de matière organique décomposée, de fibres et parfois de minéraux. À distinguer de la terre du jardin : il est plus léger, plus riche et plus stérile.':
      'Ready-to-use growing medium, a mix of decomposed organic matter, fibres and sometimes minerals. Not the same as garden soil: it is lighter, richer and more sterile.',
  'hors-gel':
      'frost-free',
  'Période sans risque de gelée nocturne. En France, on parle souvent de "saints de glace" (mi-mai) comme repère pour planter les légumes fragiles (tomate, courgette) dehors.':
      'A period with no risk of overnight frost. In France, people often talk about the "Ice Saints" (mid-May) as the marker for planting tender vegetables (tomato, courgette) outdoors.',
  'semis direct':
      'direct sowing',
  'Semer directement les graines en pleine terre, sans passer par un semis en godet. Idéal pour radis, carottes, haricots et toutes les plantes qui n\'aiment pas être repiquées.':
      'Sowing seeds straight into the ground, without starting them in pots first. Ideal for radishes, carrots, beans and all the plants that dislike being transplanted.',
  'drainage':
      'drainage',
  'Capacité du sol à évacuer l\'excès d\'eau. Un bon drainage évite que les racines pourrissent. On l\'améliore avec du sable grossier, des billes d\'argile ou en travaillant la terre en profondeur.':
      'The soil\'s ability to carry off excess water. Good drainage stops roots from rotting. Improve it with coarse sand, clay pebbles or by digging the soil deeply.',
  'pollinisateurs':
      'pollinators',
  'Insectes (abeilles, bourdons, papillons, syrphes) qui transportent le pollen d\'une fleur à l\'autre et permettent aux plantes de produire des fruits et graines. Essentiels au potager — à protéger absolument.':
      'Insects (bees, bumblebees, butterflies, hoverflies) that carry pollen from one flower to another and let plants produce fruit and seed. Essential in the veg patch — protect them at all costs.',
  'cucurbitacées':
      'cucurbits (Cucurbitaceae)',
  'Famille des courges, courgettes, potirons, concombres, melons et pastèques. Elles adorent la chaleur, le soleil et un sol riche en compost. Attention à l\'oïdium en fin d\'été.':
      'The family of squashes, courgettes, pumpkins, cucumbers, melons and watermelons. They love heat, sun and soil rich in compost. Watch out for powdery mildew in late summer.',
  'brassicacées':
      'brassicas (Brassicaceae)',
  'Famille des choux : chou-fleur, brocoli, chou pommé, kale, mais aussi radis, navet, roquette. Gros appétit en azote et sensibles à la hernie du chou — rotation longue conseillée (5-7 ans).':
      'The cabbage family: cauliflower, broccoli, white cabbage, kale, but also radish, turnip and rocket. Hungry for nitrogen and prone to clubroot — a long rotation is advised (5-7 years).',
  'fabacées':
      'legume family (Fabaceae)',
  'Famille des haricots, pois, fèves, lentilles. Leur super-pouvoir : elles fixent l\'azote de l\'air dans le sol grâce à leurs racines, et enrichissent donc naturellement la terre pour la culture suivante.':
      'The family of beans, peas, broad beans and lentils. Their superpower: through their roots they fix nitrogen from the air into the soil, so they naturally enrich the ground for the next crop.',
  'légumineuses':
      'legumes',
  'Autre nom des fabacées : haricots, pois, fèves, lentilles. Elles enrichissent le sol en azote et sont indispensables dans la rotation des cultures.':
      'Another name for the Fabaceae: beans, peas, broad beans, lentils. They enrich the soil with nitrogen and are essential in crop rotation.',
  'apiacées':
      'carrot family (Apiaceae)',
  'Famille des carottes, persil, céleri, fenouil, aneth, cerfeuil. Partagent les mêmes ravageurs (mouche de la carotte) — associées à l\'oignon ou au poireau qui les repoussent.':
      'The family of carrot, parsley, celery, fennel, dill and chervil. They share the same pests (carrot fly) — plant them with onion or leek, which repel it.',
  'liliacées':
      'onion family (Liliaceae)',
  'Famille des oignons, ail, échalotes, poireaux, ciboulette. Bons compagnons pour beaucoup de légumes grâce à leur odeur répulsive contre certains insectes.':
      'The family of onions, garlic, shallots, leeks and chives. Good companions for many vegetables thanks to their smell, which repels certain insects.',
  'astéracées':
      'daisy family (Asteraceae)',
  'Famille des salades (laitue, scarole, chicorée), de l\'artichaut et du pissenlit. Se reconnaissent à leurs fleurs en capitule (comme les marguerites).':
      'The family of salad leaves (lettuce, escarole, chicory), artichoke and dandelion. You can spot them by their composite flower heads (like daisies).',
  'pincement':
      'pinching out',
  'Couper avec les ongles l\'extrémité d\'une tige pour stopper sa croissance en hauteur et forcer la plante à se ramifier. Très utilisé sur le basilic et pour retirer les gourmands des tomates.':
      'Nipping off the tip of a stem with your fingernails to stop it growing taller and make the plant branch out. Used a lot on basil and to remove side shoots from tomatoes.',
  'tuteurage':
      'staking',
  'Soutenir une plante à l\'aide d\'un bambou, d\'un tuteur ou d\'un treillis. Indispensable pour les tomates, concombres, haricots à rames : la plante reste droite, bien aérée et les fruits restent propres.':
      'Supporting a plant with a bamboo cane, a stake or a trellis. Essential for tomatoes, cucumbers and climbing beans: the plant stays upright and airy, and the fruit stays clean.',
  'palissage':
      'training',
  'Guider et attacher une plante grimpante ou une branche le long d\'un support (fil, treillis, mur). Économise la place et expose mieux les feuilles au soleil.':
      'Guiding and tying a climbing plant or a branch along a support (wire, trellis, wall). It saves space and gets the leaves more sun.',
  'stratification':
      'stratification',
  'Exposer des graines au froid (congélateur ou hiver) pendant quelques semaines pour lever leur dormance et déclencher la germination. Imite le cycle naturel des saisons — utile pour les arbres fruitiers et certaines fleurs.':
      'Exposing seeds to cold (freezer or winter) for a few weeks to break their dormancy and trigger germination. It mimics the natural cycle of the seasons — useful for fruit trees and some flowers.',
  'engrais vert':
      'green manure',
  'Plantes semées pour enrichir et protéger le sol entre deux cultures (moutarde, phacélie, trèfle). On les fauche et enfouit avant qu\'elles montent en graine : elles libèrent azote et matière organique.':
      'Plants sown to enrich and protect the soil between two crops (mustard, phacelia, clover). They are cut down and dug in before they go to seed: they release nitrogen and organic matter.',
  'purin d\'ortie':
      'nettle brew',
  'Macération d\'orties dans de l\'eau pendant 1 à 2 semaines. Dilué à 10 %, c\'est un excellent engrais liquide riche en azote. Odeur forte mais très efficace !':
      'Nettles steeped in water for 1 to 2 weeks. Diluted to 10%, it makes an excellent liquid feed rich in nitrogen. Strong smell, but very effective!',
  'binage':
      'hoeing',
  'Gratter la surface du sol avec une binette pour casser la croûte, aérer la terre et arracher les mauvaises herbes naissantes. Dicton : "un binage vaut deux arrosages".':
      'Scratching the soil surface with a hoe to break the crust, aerate the earth and pull out weeds just emerging. As the saying goes: "one good hoeing is worth two waterings".',
  'sarclage':
      'weeding',
  'Arracher ou couper les mauvaises herbes à la main ou au sarcloir, pour qu\'elles n\'étouffent pas les cultures et ne prennent pas l\'eau.':
      'Pulling up or cutting weeds by hand or with a weeding hoe, so they do not smother your crops or steal their water.',
  'gourmand':
      'side shoot',
  'Petite pousse qui apparaît à l\'aisselle d\'une feuille, surtout sur les tomates. On les pince pour que la plante concentre son énergie sur les fruits plutôt que sur la végétation.':
      'A little shoot that appears in the angle between a leaf and the stem, especially on tomatoes. Pinch them out so the plant puts its energy into fruit rather than foliage.',
  'bouturage':
      'taking cuttings',
  'Multiplier une plante en coupant un fragment de tige qu\'on fait ensuite raciner dans l\'eau ou dans du terreau. Très facile avec la menthe, le basilic, le géranium.':
      'Multiplying a plant by cutting off a piece of stem and rooting it in water or potting compost. Very easy with mint, basil and geranium.',
  'amendement':
      'soil conditioner',
  'Matière ajoutée au sol pour améliorer sa structure durablement (compost, fumier, sable pour un sol lourd, chaux pour un sol acide). Différent de l\'engrais qui nourrit directement la plante.':
      'Material added to the soil to improve its structure for the long term (compost, manure, sand for a heavy soil, lime for an acid one). Different from fertiliser, which feeds the plant directly.',
  'pré-germination':
      'pre-germination',
  'Faire germer les graines avant de les semer, par exemple entre deux feuilles de papier humide. Accélère la levée et permet de ne semer que les graines viables.':
      'Sprouting seeds before you sow them, for example between two sheets of damp paper. It speeds up emergence and means you only sow seeds that are viable.',
  'oïdium':
      'powdery mildew',
  'Maladie fongique en "poudre blanche" qui recouvre les feuilles par temps sec et chaud. Touche surtout courgettes, concombres, rosiers. Traiter avec du lait dilué ou du bicarbonate dès les premiers symptômes.':
      'A fungal disease that coats the leaves in a "white powder" in dry, warm weather. It mostly hits courgettes, cucumbers and roses. Treat with diluted milk or bicarbonate of soda at the first symptoms.',
  'rouille':
      'rust',
  'Champignon qui forme de petits points orangés ou bruns sous les feuilles. Favorisé par l\'humidité. Arrose au pied, aère les plants et retire les feuilles atteintes.':
      'A fungus that forms little orange or brown spots under the leaves. Encouraged by damp. Water at the base, ventilate your plants and remove affected leaves.',
  'fumagine':
      'sooty mould',
  'Dépôt noirâtre qui s\'installe sur les feuilles après une attaque de pucerons ou cochenilles — elles excrètent un miellat sucré sur lequel ce champignon se développe.':
      'A blackish deposit that settles on leaves after an attack of aphids or scale insects — they excrete a sweet honeydew on which this fungus grows.',
  'pourriture grise':
      'grey mould',
  'Aussi appelée botrytis : duvet gris qui s\'installe sur feuilles, tiges et fruits par temps humide. Retire les parties atteintes et aère la culture.':
      'Also called botrytis: a grey fuzz that settles on leaves, stems and fruit in damp weather. Remove the affected parts and ventilate the crop.',
  'cloque':
      'leaf curl',
  'Maladie du pêcher et du nectarinier : les jeunes feuilles se boursouflent et deviennent rouges au printemps. Traiter préventivement à la bouillie bordelaise avant l\'ouverture des bourgeons.':
      'A disease of peach and nectarine trees: the young leaves blister and turn red in spring. Treat preventively with Bordeaux mixture before the buds open.',
  'fonte des semis':
      'damping off',
  'Les jeunes plants s\'effondrent brusquement au niveau du collet à cause d\'un champignon. Souvent dû à un excès d\'humidité — aère bien et arrose avec parcimonie.':
      'Young seedlings suddenly collapse at the base of the stem because of a fungus. Often caused by too much moisture — ventilate well and water sparingly.',
  'chlorose':
      'chlorosis',
  'Jaunissement des feuilles alors que les nervures restent vertes. Signe d\'une carence en fer (souvent sur sol calcaire). Corrige avec un apport de chélate de fer ou de compost.':
      'Leaves turn yellow while the veins stay green. A sign of iron deficiency (often on chalky soil). Correct it with iron chelate or compost.',
  'doryphore':
      'Colorado beetle',
  'Gros coléoptère rayé jaune et noir, bien connu comme nuisible n°1 de la pomme de terre. Les larves rose-orange dévorent le feuillage. Ramassage à la main = méthode la plus efficace.':
      'A big beetle striped yellow and black, well known as the number 1 pest of the potato. The pink-orange larvae devour the foliage. Hand-picking is the most effective method.',
  'altise':
      'flea beetle',
  'Minuscule insecte noir sauteur qui perce de petits trous dans les feuilles de radis, choux, roquette. Maintenir le sol humide et couvrir avec un filet anti-insectes les décourage.':
      'A tiny black jumping insect that bites little holes in the leaves of radishes, cabbages and rocket. Keeping the soil damp and covering the crop with insect-proof netting puts them off.',
  'cochenille':
      'scale insect',
  'Insecte écailleux (blanc, brun ou noir) collé aux tiges et feuilles, où il suce la sève. Traite au savon noir ou avec un coton imbibé d\'alcool.':
      'A scaly insect (white, brown or black) stuck to stems and leaves, where it sucks the sap. Treat with insecticidal soap or a cotton bud dipped in alcohol.',
  'carpocapse':
      'codling moth',
  'Papillon dont la chenille creuse les fruits à pépins (pommes, poires) — c\'est le fameux "ver de la pomme". Pose des pièges à phéromones au printemps pour limiter les dégâts.':
      'A moth whose caterpillar bores into pome fruit (apples, pears) — the famous "worm in the apple". Hang pheromone traps in spring to limit the damage.',
  'cotylédon':
      'seed leaf (cotyledon)',
  'Les toutes premières "fausses feuilles" qui sortent de la graine lors de la germination. Elles sont lisses et différentes des vraies feuilles qui suivent — repère clé pour savoir quand repiquer.':
      'The very first "false leaves" that come out of the seed when it germinates. They are smooth and different from the true leaves that follow — a key sign of when to transplant.',
  'plantule':
      'seedling',
  'Très jeune plant qui vient de lever : il a juste ses cotylédons ou ses toutes premières vraies feuilles. Encore fragile, à bichonner.':
      'A very young plant that has just come up: it only has its seed leaves or its very first true leaves. Still fragile, so pamper it.',
  'collet':
      'crown (root collar)',
  'Zone de jonction entre la racine et la tige, juste au ras du sol. Très sensible à la pourriture : ne jamais enfouir ou pailler directement dessus.':
      'The junction between root and stem, right at soil level. Very prone to rot: never bury it or mulch directly on top of it.',
  'motte':
      'root ball',
  'Bloc de terre qui entoure les racines d\'un plant quand tu le sors de son godet. On repique toujours avec sa motte pour ne pas traumatiser les racines.':
      'The block of soil around a plant\'s roots when you take it out of its pot. Always transplant with the root ball so you do not shock the roots.',
  'stolon':
      'runner',
  'Longue tige rampante qui sort de la plante mère et crée un nouveau plant au sol. Le fraisier en est le champion : un pied peut en produire 10 en une saison !':
      'A long creeping stem that grows out from the mother plant and makes a new plant on the ground. Strawberries are the champions: one plant can make 10 in a single season!',
  'tubercule':
      'tuber',
  'Réserve souterraine charnue qui stocke l\'énergie de la plante. Pomme de terre, topinambour, patate douce sont des tubercules.':
      'A fleshy underground store that holds the plant\'s energy. Potato, Jerusalem artichoke and sweet potato are tubers.',
  'bulbe':
      'bulb',
  'Organe souterrain arrondi formé d\'écailles serrées autour d\'un bourgeon central. Oignon, ail, échalote, tulipe, narcisse sont des bulbes.':
      'A rounded underground organ made of scales packed around a central bud. Onion, garlic, shallot, tulip and daffodil are bulbs.',
  'rhizome':
      'rhizome',
  'Tige souterraine qui pousse horizontalement et produit des racines et des tiges aériennes. Gingembre, menthe, bambou se propagent par rhizomes.':
      'An underground stem that grows horizontally and produces roots and shoots above ground. Ginger, mint and bamboo spread by rhizomes.',
  'rustique':
      'hardy',
  'Plante qui résiste au froid et au gel sans protection. Chou kale, poireau, mâche, épinard sont rustiques. À l\'inverse, tomate ou basilic sont non rustiques.':
      'A plant that withstands cold and frost without protection. Kale, leek, corn salad and spinach are hardy. By contrast, tomato and basil are tender.',
  'montée en graine':
      'bolting',
  'Quand une plante passe en mode reproduction et fabrique une tige florale. Pour les légumes-feuilles (salade, épinard), c\'est la fin de la récolte : les feuilles deviennent dures et amères.':
      'When a plant switches to reproduction mode and makes a flower stalk. For leafy vegetables (lettuce, spinach) it is the end of the harvest: the leaves turn tough and bitter.',
  'npk':
      'NPK',
  'Les trois éléments essentiels à toute plante, affichés sur les engrais. N = azote (feuilles vertes), P = phosphore (racines et fleurs), K = potassium (fruits et résistance).':
      'The three elements every plant needs, shown on fertiliser packs. N = nitrogen (green leaves), P = phosphorus (roots and flowers), K = potassium (fruit and resilience).',
  'humus':
      'humus',
  'Couche supérieure sombre du sol, issue de la décomposition des matières organiques. C\'est la partie la plus fertile et la plus vivante — l\'objectif à nourrir avec le compost et le paillage.':
      'The dark top layer of the soil, made from the breakdown of organic matter. It is the most fertile and liveliest part — the thing to feed with compost and mulch.',
  'ph du sol':
      'soil pH',
  'Mesure l\'acidité ou l\'alcalinité du sol, de 0 à 14. Neutre = 7. La plupart des légumes préfèrent un pH entre 6,5 et 7,5 (légèrement acide à neutre). Des bandelettes en jardinerie permettent de le tester.':
      'Measures how acid or alkaline the soil is, on a scale from 0 to 14. Neutral = 7. Most vegetables prefer a pH between 6.5 and 7.5 (slightly acid to neutral). Test strips from the garden centre let you check it.',
  'mi-ombre':
      'partial shade',
  'Emplacement qui reçoit 3 à 5 heures de soleil direct par jour, ou un soleil filtré. Idéal pour les salades, épinards, mâche, menthe — qui grillent en plein soleil l\'été.':
      'A spot that gets 3 to 5 hours of direct sun a day, or filtered sun. Ideal for lettuce, spinach, corn salad and mint — which scorch in full summer sun.',
  'saints de glace':
      'Ice Saints',
  'Période du 11 au 13 mai, traditionnellement les dernières gelées en France. Avant cette date, on évite de sortir les légumes fragiles (tomate, courgette, basilic). Après = place libre !':
      'The period from 11 to 13 May, traditionally the last frosts in France. Before this date, avoid putting tender vegetables out (tomato, courgette, basil). After it, the coast is clear!',
  'harmattan':
      'harmattan',
  'Vent sec et poussiéreux venu du Sahara qui souffle sur l\'Afrique de l\'Ouest de novembre à mars. Il dessèche les cultures en quelques jours : paille généreusement, arrose le soir et abrite les jeunes plants derrière une haie ou une ombrière.':
      'A dry, dusty wind from the Sahara that blows over West Africa from November to March. It dries crops out in just a few days: mulch generously, water in the evening and shelter young plants behind a hedge or a shade net.',
  'hivernage':
      'rainy season (hivernage)',
  'En Afrique de l\'Ouest, c\'est le nom de la saison des pluies (environ juin à octobre selon la latitude). C\'est LA grande saison de culture : mil, maïs, niébé et arachide se sèment dès les premières pluies utiles.':
      'In West Africa, the name for the rainy season (roughly June to October depending on latitude). It is THE big growing season: millet, maize, cowpea and groundnut are sown as soon as the first useful rains arrive.',
  'saison sèche':
      'dry season',
  'Période sans pluie (environ novembre à mai en Afrique de l\'Ouest). Le maraîchage y reste possible près d\'un point d\'eau : c\'est même la meilleure saison pour tomates, oignons, choux et salades, loin de l\'humidité et des maladies.':
      'A period without rain (roughly November to May in West Africa). Market gardening is still possible near a source of water: it is even the best season for tomatoes, onions, cabbages and lettuces, away from damp and disease.',
  'maraîchage':
      'market gardening',
  'Culture intensive de légumes frais sur de petites surfaces, souvent irriguée à l\'arrosoir ou au goutte-à-goutte. En Afrique de l\'Ouest, les périmètres maraîchers battent leur plein en saison sèche, autour des bas-fonds et des puits.':
      'Intensive growing of fresh vegetables on small plots, often irrigated with a watering can or drip lines. In West Africa, market-garden plots are in full swing in the dry season, around lowlands and wells.',
  'jardin de case':
      'compound garden',
  'Petit jardin vivrier installé juste autour de la maison (la « case ») : quelques légumes-feuilles, un papayer, un moringa, des aromates... Arrosé avec les eaux du ménage, il fournit la sauce du jour à portée de main.':
      'A small food garden right around the house (the "case", or hut): a few leafy vegetables, a papaya tree, a moringa, herbs... Watered with household water, it puts the day\'s sauce within arm\'s reach.',
  'billon':
      'ridge',
  'Butte de terre allongée formée à la houe, sur laquelle on sème ou repique. Le billon draine l\'excès d\'eau en saison des pluies, réchauffe le sol et facilite le buttage — incontournable pour igname, patate douce et manioc.':
      'A long mound of earth shaped with a hoe, on which you sow or transplant. The ridge drains excess water in the rainy season, warms the soil and makes earthing up easier — a must for yam, sweet potato and cassava.',
  'butte d\'igname':
      'yam mound',
  'Gros monticule de terre meuble (50 cm à 1 m de haut) monté à la houe pour chaque plant d\'igname. La butte offre au tubercule un volume de terre souple et profonde où grossir sans se déformer.':
      'A big mound of loose soil (50 cm to 1 m high) built with a hoe for each yam plant. The mound gives the tuber a volume of soft, deep soil to swell in without getting misshapen.',
  'zaï':
      'zaï',
  'Technique sahélienne : creuser en saison sèche des petites cuvettes (20-30 cm) remplies de fumier ou compost, où l\'on sème aux premières pluies. Chaque trou concentre eau et fertilité — il fait reverdir même les sols durcis.':
      'A Sahelian technique: in the dry season, dig small pits (20-30 cm) filled with manure or compost, and sow into them with the first rains. Each hole concentrates water and fertility — it can green even hardened soils.',
  'demi-lune':
      'half-moon',
  'Cuvette en forme de croissant creusée perpendiculairement à la pente pour capter l\'eau de ruissellement. Comme le zaï, cette technique sahélienne permet de cultiver mil ou sorgho sur des terres dégradées.':
      'A crescent-shaped basin dug across the slope to catch run-off water. Like zaï, this Sahelian technique makes it possible to grow millet or sorghum on degraded land.',
  'ombrière':
      'shade net',
  'Structure légère (filet d\'ombrage, claie de tiges ou de palmes) tendue au-dessus des cultures pour tamiser 30 à 50 % du soleil. Indispensable pour réussir pépinières et salades sous le soleil tropical ou en canicule.':
      'A light structure (shade netting, a frame of stems or palm fronds) stretched over crops to filter out 30 to 50% of the sun. Essential for getting nurseries and lettuces to succeed in tropical sun or a heatwave.',
  'canari':
      'canari (clay pot)',
  'Grande jarre en terre cuite poreuse, enterrée au milieu des cultures et remplie d\'eau. L\'eau suinte lentement à travers l\'argile et abreuve les racines voisines — un goutte-à-goutte traditionnel, cousin des oyas.':
      'A large porous terracotta jar, buried among the crops and filled with water. The water seeps slowly through the clay and waters the nearby roots — a traditional drip irrigation, cousin of the olla.',
  'semenceau':
      'seed tuber',
  'Fragment de tubercule (ou petit tubercule entier) utilisé comme semence, notamment pour l\'igname et la pomme de terre. Choisis des semenceaux sains et fermes : c\'est la garantie d\'une belle levée.':
      'A piece of tuber (or a small whole tuber) used as seed, notably for yam and potato. Choose healthy, firm seed tubers: it is the guarantee of good emergence.',
  'shiny':
      'shiny',
  'Médaille et version "légendaire" d\'un badge : la plus rare, la plus brillante. Obtenue après de longues séries d\'actions parfaites !':
      'A medal and "legendary" version of a badge: the rarest, the shiniest. Earned after long runs of perfect actions!',
  'défi':
      'challenge',
  'Mini-quête photo à réaliser dans Kultiva (photographier un semis, une récolte, une fleur…). Chaque défi réussi débloque un badge, et la photo reste sur ton téléphone.':
      'A mini photo quest to complete in Kultiva (photograph a seedling, a harvest, a flower…). Each challenge you complete unlocks a badge, and the photo stays on your phone.',

  // ─── familles (26 phrases, 26 mots) ───
  'Solanacées':
      'Nightshades (Solanaceae)',
  'Apiacées':
      'Carrot family (Apiaceae)',
  'Brassicacées':
      'Cabbage family (Brassicaceae)',
  'Fabacées':
      'Legumes (Fabaceae)',
  'Alliacées':
      'Onion family (Alliaceae)',
  'Cucurbitacées':
      'Cucurbits (Cucurbitaceae)',
  'Astéracées':
      'Daisy family (Asteraceae)',
  'Chénopodiacées':
      'Goosefoot family (Chenopodiaceae)',
  'Amarantacées':
      'Amaranth family (Amaranthaceae)',
  'Asparagacées':
      'Asparagus family (Asparagaceae)',
  'Lamiacées':
      'Mint family (Lamiaceae)',
  'Malvacées':
      'Mallow family (Malvaceae)',
  'Rosacées':
      'Rose family (Rosaceae)',
  'Zingibéracées':
      'Ginger family (Zingiberaceae)',
  'Dioscoréacées':
      'Yam family (Dioscoreaceae)',
  'Valérianacées':
      'Valerian family (Valerianaceae)',
  'Poacées':
      'Grasses (Poaceae)',
  'Euphorbiacées':
      'Spurge family (Euphorbiaceae)',
  'Polygonacées':
      'Knotweed family (Polygonaceae)',
  'Convolvulacées':
      'Bindweed family (Convolvulaceae)',
  'Pédaliacées':
      'Sesame family (Pedaliaceae)',
  'Aracées':
      'Arum family (Araceae)',
  'Moringacées':
      'Moringa family (Moringaceae)',
  'Basellacées':
      'Basella family (Basellaceae)',
  'Caricacées':
      'Papaya family (Caricaceae)',
  'Musacées':
      'Banana family (Musaceae)',

  // ─── canicule (7 phrases, 120 mots) ───
  'Arrose tôt le matin ou en soirée, jamais en plein soleil. Paille pour conserver la fraîcheur du sol.':
      'Water early in the morning or in the evening, never in full sun. Mulch to keep the soil cool.',
  'Salades et épinards montent vite à la chaleur. Ombre avec un voile et arrose le soir.':
      'Lettuce and spinach bolt quickly in the heat. Shade them with a light cover and water in the evening.',
  'Tomates, courgettes, aubergines : paille épais, arrose au pied le matin, ombre les fruits exposés.':
      'Tomatoes, courgettes, aubergines: mulch thickly, water at the base in the morning, shade any exposed fruit.',
  'Oignons et ail tolèrent bien la chaleur, mais évite d\'arroser les jours de canicule (favorise les maladies).':
      'Onions and garlic cope well with heat, but avoid watering on heatwave days (it encourages disease).',
  'Pommes de terre : paille pour garder le sol frais, n\'arrose pas le feuillage en plein soleil (brûlures).':
      'Potatoes: mulch to keep the soil cool, and do not water the foliage in full sun (it scorches).',
  'Carottes, radis, betteraves : arrose en profondeur tous les 2 jours pour éviter qu\'ils se fendent.':
      'Carrots, radishes, beetroot: water deeply every 2 days to stop them splitting.',
  'Basilic, persil, ciboulette : un coup d\'eau par jour à la fraîche suffit. Coupe les fleurs pour préserver les feuilles.':
      'Basil, parsley, chives: a little water a day in the cool of the evening is enough. Cut off the flowers to protect the leaves.',

  // ─── achat_marche (56 phrases, 1733 mots) ───
  'semenceaux':
      'seed tubers',
  'Choisis des semenceaux fermes de 200 à 400 g, sans taches noires ni pourriture. Un bon semenceau a une peau intacte et un « nombril » (tête) net ; écarte tout morceau ramolli ou déjà desséché.':
      'Choose firm seed tubers of 200 to 400 g, with no black spots or rot. A good seed tuber has intact skin and a clean "navel" (head); discard any piece that is soft or already dried out.',
  'boutures':
      'cuttings',
  'Prends des boutures de tige de 20 à 25 cm, prélevées au milieu d\'une tige mûre et bien lignifiée (ni trop verte, ni trop âgée). Chaque bouture doit porter au moins 5 à 7 nœuds ; laisse de côté celles qui sont fendues, sèches ou couvertes de cochenilles blanches.':
      'Take stem cuttings 20 to 25 cm long, cut from the middle of a mature, well-hardened stem (neither too green nor too old). Each cutting should carry at least 5 to 7 nodes; leave aside any that are split, dry or covered in white scale insects.',
  'Achète des boutures (lianes) de 25 à 30 cm avec 4 à 6 nœuds, coupées le matin sur des plants vigoureux. Prends-les bien vertes et fraîches, sans flétrissure, et plante-les vite : elles s\'enracinent en quelques jours.':
      'Buy cuttings (vines) 25 to 30 cm long with 4 to 6 nodes, cut in the morning from vigorous plants. Choose ones that are nice and green and fresh, with no wilting, and plant them quickly: they root within a few days.',
  'rejets':
      'suckers',
  'Choisis des rejets ou de petits cormes (tubercules) fermes, sans zones molles ni moisissure. Garde 15 à 20 cm de pétiole au-dessus du corme et une base à racines saines : c\'est le gage d\'une bonne reprise.':
      'Choose firm suckers or small corms (tubers), with no soft patches or mould. Keep 15 to 20 cm of leaf stalk above the corm and a base with healthy roots: that is the guarantee of a good take.',
  'Choisis des rejets « baïonnette » : jeunes pousses au feuillage encore effilé (lancéolé), issues d\'un pied sain et productif. Ils reprennent mieux que les rejets à larges feuilles ; vérifie que le bulbe est ferme, sans galeries de charançons.':
      'Choose "sword" suckers: young shoots with narrow, lance-shaped leaves, from a healthy, productive plant. They establish better than broad-leaved suckers; check that the corm is firm, with no weevil tunnels.',
  'Prends des plants de semence de la taille d\'un œuf, fermes et déjà pré-germés avec de petits germes trapus et verts. Évite les tubercules ridés, à longs germes blancs filés, ou vendus pour la consommation (souvent traités anti-germination).':
      'Choose seed potatoes the size of an egg, firm and already chitted, with short, stubby green sprouts. Avoid wrinkled tubers, ones with long thin white sprouts, or ones sold for eating (often treated against sprouting).',
  'rhizomes':
      'rhizomes',
  'Achète du gingembre frais et bien dodu, à peau tendue, portant des « yeux » (bourgeons) qui pointent déjà. Coupe-le en morceaux de 4 à 5 cm avec au moins un bourgeon chacun, laisse sécher la coupe un jour, puis plante ; évite les rhizomes ridés, mous ou moisis.':
      'Buy fresh, plump ginger with taut skin and "eyes" (buds) already showing. Cut it into pieces 4 to 5 cm long, each with at least one bud, let the cut dry for a day, then plant; avoid rhizomes that are wrinkled, soft or mouldy.',
  'éclats de touffe':
      'clump divisions',
  'La citronnelle se multiplie par éclats : prends une touffe avec des tiges bien vertes et surtout une base à racines vivantes. Une seule tige racinée reprend et fait une grosse touffe en quelques mois ; écarte les tiges sèches ou sans racines.':
      'Lemongrass is propagated by division: take a clump with bright green stems and, above all, a base with living roots. A single rooted stem takes and grows into a big clump within a few months; discard dry stems or ones without roots.',
  'graines':
      'seeds',
  'Prends des graines récentes (regarde la date sur le sachet) d\'une variété qui aime la chaleur, comme Roma ou Mongal. En vrac, choisis un vendeur de confiance : des graines bien sèches, pleines et de couleur uniforme germent le mieux.':
      'Choose recent seeds (check the date on the packet) of a heat-loving variety, such as Roma or Mongal. If you buy loose, pick a seller you trust: dry, plump seeds of an even colour germinate best.',
  'plants':
      'seedlings',
  'Si tu achètes des plants repiqués, choisis-les trapus (20 cm max), à tige épaisse et feuilles bien vertes. Fuis les plants filés, jaunis ou déjà en fleur dans un godet minuscule : ils peinent à redémarrer.':
      'If you buy transplants, choose stocky ones (20 cm max), with a thick stem and bright green leaves. Avoid leggy or yellowing plants, or ones already in flower in a tiny pot: they struggle to get going again.',
  'Choisis des graines fraîches d\'une variété locale bien piquante. Des graines trop vieilles germent lentement ; sème-les au chaud et sois patient, la levée peut prendre 2 à 3 semaines.':
      'Choose fresh seeds of a good hot local variety. Seeds that are too old germinate slowly; sow them somewhere warm and be patient, as emergence can take 2 to 3 weeks.',
  'Prends de jeunes plants trapus et bien verts, à racines blanches non enroulées au fond du godet. Un plant court et ramifié produira plus qu\'un plant haut et étiolé.':
      'Choose young plants that are stocky and well green, with white roots that are not coiled at the bottom of the pot. A short, bushy plant will produce more than a tall, spindly one.',
  'Prends des graines récentes d\'une variété tolérant la chaleur : le poivron germe lentement et aime le chaud. Sème en pépinière légèrement ombragée avant de repiquer.':
      'Choose recent seeds of a heat-tolerant variety: pepper is slow to germinate and loves warmth. Sow in a lightly shaded nursery before transplanting.',
  'Choisis un plant trapu à tige solide, feuilles vert foncé et racines saines. Évite les plants déjà chargés de fruits dans un petit godet, ils s\'épuisent avant même d\'être en terre.':
      'Choose a stocky plant with a sturdy stem, dark green leaves and healthy roots. Avoid plants already laden with fruit in a small pot — they wear themselves out before they are even in the ground.',
  'Prends des graines fraîches : l\'aubergine germe mieux au chaud (25 à 30 °C). En sachet, vérifie la date ; en vrac, préfère des graines pleines, sans poussière ni débris.':
      'Choose fresh seeds: aubergine germinates best in warmth (25 to 30 °C). In packets, check the date; if buying loose, pick plump seeds with no dust or debris.',
  'Repique des plants trapus de 10 à 15 cm, feuillage vert et racines saines. Fuis les plants filés ou tachés, plus fragiles au repiquage.':
      'Transplant stocky plants 10 to 15 cm tall, with green foliage and healthy roots. Avoid leggy or spotted plants, which are more fragile when transplanted.',
  'Récupère les graines d\'un beau fruit bien mûr (jaune-orangé) d\'une variété locale comme le jaxatu ou le gboma. Les graines sèches se conservent bien ; garde celles issues des plants les plus sains et productifs.':
      'Save the seeds from a fine, fully ripe (yellow-orange) fruit of a local variety such as jaxatu or gboma. Dry seeds keep well; keep the ones from the healthiest, most productive plants.',
  'Choisis de grosses graines de gombo bien pleines, dures et de couleur uniforme, sans petits trous d\'insectes. Prends-les de l\'année (au-delà, la germination chute) et fais-les tremper une nuit avant de semer.':
      'Choose big, plump okra seeds, hard and of an even colour, with no little insect holes. Use this year\'s seeds (older ones germinate poorly) and soak them overnight before sowing.',
  'Choisis de grosses graines de pastèque bien pleines et sombres, sans fissure. Tu peux récupérer les graines d\'un fruit bien mûr et sucré que tu as aimé : sèche-les soigneusement avant de les ranger.':
      'Choose big, plump, dark watermelon seeds with no cracks. You can save the seeds from a ripe, sweet fruit you enjoyed: dry them carefully before putting them away.',
  'Prends des graines de melon plates, pleines et claires. Petite astuce : le melon fructifie souvent mieux avec des graines de 2 ou 3 ans qu\'avec des graines toutes fraîches — à condition qu\'elles soient restées bien sèches et sans moisissure.':
      'Choose flat, plump, pale melon seeds. Handy tip: melons often fruit better from seeds that are 2 or 3 years old than from fresh ones — as long as they have stayed dry and mould-free.',
  'Choisis des graines de concombre plates et bien remplies, d\'une variété adaptée à la chaleur. Récentes, elles lèvent en quelques jours ; conserve-les au sec, l\'humidité les tue vite.':
      'Choose flat, well-filled cucumber seeds of a variety suited to the heat. When recent, they come up in a few days; store them dry, as damp kills them quickly.',
  'Prends de grosses graines de courgette bien pleines et fermes ; les plus lourdes donnent les plants les plus vigoureux. Deux ou trois graines par poquet suffisent, et sème directement en place.':
      'Choose big, plump, firm courgette seeds; the heaviest give the most vigorous plants. Two or three seeds per planting hole is enough, and sow straight in place.',
  'Choisis une variété qui supporte la chaleur (batavia, feuille de chêne) et des graines récentes : la laitue lève mal quand la graine est vieille ou qu\'il fait trop chaud. Sème à l\'ombre légère en saison chaude.':
      'Choose a variety that tolerates heat (batavia, oak leaf) and recent seeds: lettuce comes up badly when the seed is old or it is too hot. Sow in light shade in the hot season.',
  'Prends des graines récentes d\'une variété tropicale (KK Cross, Oxylus). En vrac, méfie-toi des graines poussiéreuses : une graine de chou saine est ronde, dure et brun foncé.':
      'Choose recent seeds of a tropical variety (KK Cross, Oxylus). If buying loose, beware of dusty seeds: a healthy cabbage seed is round, hard and dark brown.',
  'Repique des plants trapus à 4 ou 5 vraies feuilles, tige courte et racines blanches. Évite les plants hauts et grêles, plus sensibles à la chaleur et aux chenilles.':
      'Transplant stocky plants with 4 or 5 true leaves, a short stem and white roots. Avoid tall, spindly plants, which are more sensitive to heat and caterpillars.',
  'Pour la corète (mloukhiya, feuilles-gluantes), choisis des graines fraîches et bien sèches d\'une variété à larges feuilles. Sème dense en pluie fine ; les graines de l\'année lèvent nettement mieux.':
      'For jute mallow (mloukhiya, the slimy-leaved green), choose fresh, very dry seeds of a broad-leaved variety. Sow thickly and water with a fine spray; this year\'s seeds come up noticeably better.',
  'La célosie (feuille) a de toutes petites graines : prends-les fraîches et propres, sans trop de balle (débris). Sème en surface sans les enterrer, elles ont besoin de lumière pour germer.':
      'Celosia (leaf type) has tiny seeds: choose fresh, clean ones without too much chaff (debris). Sow on the surface without burying them; they need light to germinate.',
  'L\'amarante a des graines minuscules : choisis un lot propre et bien sec, sans moisissure. Une pincée suffit pour un grand carré ; sème clair en surface et arrose en pluie fine pour ne pas les enfoncer.':
      'Amaranth has minuscule seeds: choose a clean, very dry batch with no mould. A pinch is enough for a big square; sow thinly on the surface and water with a fine spray so you do not push them down.',
  'La baselle (épinard de Malabar) se sème facilement : prends des graines noires bien mûres et dures, et fais-les tremper une nuit car leur coque est épaisse.':
      'Basella (Malabar spinach) is easy to sow: choose black, fully ripe, hard seeds and soak them overnight, because their coat is thick.',
  'Encore plus simple : prends une bouture de tige de 15 à 20 cm sur un pied sain, elle s\'enracine toute seule dans un sol humide.':
      'Even simpler: take a 15 to 20 cm stem cutting from a healthy plant, and it will root by itself in damp soil.',
  'Pour l\'oseille, choisis des graines fraîches et bien sèches. C\'est une culture facile et généreuse : sème clair, éclaircis, et un seul rang suffit à parfumer la sauce de toute la famille.':
      'For sorrel, choose fresh, very dry seeds. It is an easy, generous crop: sow thinly, thin out, and a single row is enough to flavour the whole family\'s sauce.',
  'Le persil germe lentement (2 à 3 semaines) et la graine vieillit vite : prends-la de l\'année. Fais tremper les graines une nuit avant de semer pour accélérer la levée, et garde le sol frais.':
      'Parsley is slow to germinate (2 to 3 weeks) and the seed ages quickly: buy this year\'s. Soak the seeds overnight before sowing to speed up emergence, and keep the soil cool.',
  'Choisis des graines de basilic fraîches et propres, d\'une variété qui aime la chaleur (le basilic africain, grand vert, prospère en AO). Sème en surface, à peine couvertes ; elles lèvent vite au chaud.':
      'Choose fresh, clean basil seeds of a variety that likes heat (African basil, a tall green one, thrives in West Africa). Sow on the surface, barely covered; they come up quickly in warmth.',
  'La menthe se sème mal mais se bouture très facilement : prends une tige fraîche de 10 à 15 cm sur un pied sain, ôte les feuilles du bas et mets-la dans l\'eau ou en terre humide. En une semaine, les racines apparaissent.':
      'Mint is poor from seed but roots very easily from cuttings: take a fresh 10 to 15 cm stem from a healthy plant, strip the lower leaves and put it in water or damp soil. Roots appear within a week.',
  'Pour l\'oignon, préfère semer en pépinière plutôt qu\'acheter des bulbes d\'importation : c\'est bien moins cher et mieux adapté. Choisis des graines très fraîches (Violet de Galmi par exemple) — elles perdent leur pouvoir germinatif en un an à peine.':
      'For onions, it is better to sow in a nursery than to buy imported bulbs: much cheaper and better suited. Choose very fresh seeds (Violet de Galmi, for example) — they lose their ability to germinate in barely a year.',
  'Si tu achètes des plants à repiquer, prends-les de la taille d\'un crayon, ni trop gros ni filés, à racines fraîches ; repique-les rapidement pour éviter qu\'ils sèchent.':
      'If you buy seedlings to transplant, pick ones the size of a pencil, neither too big nor leggy, with fresh roots; transplant them quickly so they do not dry out.',
  'La graine de carotte vieillit vite : prends-la de l\'année et sème dense, tu éclairciras ensuite. Choisis une variété adaptée aux climats chauds (Nantaise, Amsterdam) et sème directement en place, la carotte n\'aime pas le repiquage.':
      'Carrot seed ages fast: buy this year\'s and sow thickly, then thin out afterwards. Choose a variety suited to hot climates (Nantes, Amsterdam) and sow straight in place, as carrots do not like being transplanted.',
  'Choisis des graines de niébé lisses, pleines et brillantes, sans petits trous ronds (signe de bruches). Un lot propre, sans poussière fine ni insectes, garde un bon taux de levée ; si les semences sont traitées (colorées), garde-les pour semer et ne les mange pas.':
      'Choose smooth, plump, shiny cowpea seeds with no little round holes (a sign of bruchid beetles). A clean batch, with no fine dust or insects, keeps a good germination rate; if the seed is treated (coloured), keep it for sowing and do not eat it.',
  'Achète l\'arachide de semence en coques bien remplies ; décortique juste avant de semer et garde les grosses graines saines, sans moisissure ni germe cassé. Ne sème jamais des graines rances ou tachées de noir (aflatoxine), elles lèvent mal.':
      'Buy groundnut seed in well-filled shells; shell it just before sowing and keep the big, healthy seeds, with no mould or broken sprout. Never sow rancid seeds or ones spotted with black (aflatoxin), as they come up poorly.',
  'Prends des grains de semence gros et lourds, sans trous de charançon, d\'une variété adaptée à ta saison des pluies. Des semences colorées (rose, rouge, vert) sont traitées au fongicide : elles germent mieux mais ne se mangent pas et ne se donnent pas aux animaux — réserve-les au semis.':
      'Choose big, heavy seed grains with no weevil holes, of a variety suited to your rainy season. Coloured seed (pink, red, green) has been treated with fungicide: it germinates better but is not for eating or for feeding to animals — keep it strictly for sowing.',
  'Choisis des épis ou des graines de mil bien pleins, d\'une variété locale adaptée à la longueur de ta saison des pluies. Écarte les graines poussiéreuses ou grignotées ; si les semences sont traitées (colorées), garde-les pour semer, jamais pour la cuisine.':
      'Choose full ears or grains of millet, of a local variety suited to the length of your rainy season. Discard dusty or nibbled grains; if the seed is treated (coloured), keep it for sowing, never for cooking.',
  'Prends des graines de sorgho grosses, saines et de couleur homogène, sans moisissure. Une variété locale éprouvée germe et résiste mieux ; méfie-toi des graines traitées (colorées), destinées au semis et non à l\'assiette.':
      'Choose big, healthy sorghum seeds of an even colour, with no mould. A proven local variety germinates and resists better; beware of treated (coloured) seed, meant for sowing and not for the plate.',
  'La graine de fonio est minuscule : choisis un lot très propre, bien vanné, sans sable ni balle. Prends-le auprès d\'un producteur de confiance et sème à la volée sur sol bien affiné, la levée est fine et fragile.':
      'Fonio seed is minuscule: choose a very clean batch, well winnowed, with no sand or chaff. Buy from a producer you trust and broadcast it over finely raked soil; the emergence is fine and fragile.',
  'Choisis des graines de sésame de l\'année, propres, sèches et de couleur uniforme (claires ou noires selon la variété). Très fines, un petit sachet suffit ; vieilles, elles rancissent et lèvent mal.':
      'Choose this year\'s sesame seeds, clean, dry and of an even colour (light or black depending on the variety). They are very fine, so a small packet is enough; when old, they go rancid and come up poorly.',
  'Pour le bissap (oseille de Guinée, hibiscus), prends des graines réniformes brun foncé, dures et pleines, sans trous d\'insectes. Les graines de l\'année lèvent vite ; choisis la variété selon l\'usage — calices rouges pour la boisson, feuilles pour la sauce.':
      'For bissap (roselle, Guinea sorrel, hibiscus), choose dark brown, kidney-shaped seeds, hard and plump, with no insect holes. This year\'s seeds come up quickly; pick the variety by use — red calyces for the drink, leaves for the sauce.',
  'Choisis des graines de moringa fraîches, à coque beige et ailée, bien pleines (secoue-les : une graine vide sonne creux). Fraîches, elles germent en une semaine ; elles perdent vite leur pouvoir germinatif, alors évite les vieux stocks.':
      'Choose fresh moringa seeds, with a beige, winged shell and well filled (shake them: an empty seed sounds hollow). Fresh, they germinate in a week; they quickly lose their ability to germinate, so avoid old stock.',
  'Tu peux aussi prendre une bouture de branche dure d\'environ 1 m : plantée directement, elle donne vite un arbre (mais aux racines moins profondes qu\'un semis).':
      'You can also take a hardwood branch cutting about 1 m long: planted straight in, it quickly makes a tree (but with shallower roots than one grown from seed).',
  'Récupère les graines noires d\'une papaye bien mûre et savoureuse ; rince-les pour ôter la pulpe et sème-les fraîches, elles lèvent d\'autant mieux. Sème plusieurs pieds pour pouvoir garder les femelles ou hermaphrodites, les plus productifs.':
      'Save the black seeds of a ripe, tasty papaya; rinse them to remove the pulp and sow them fresh, and they will come up all the better. Sow several plants so you can keep the females or hermaphrodites, which are the most productive.',
  'En pépinière, choisis de jeunes plants en sachet, trapus et bien verts, au pivot non spiralé. Repique-les jeunes (20 à 30 cm) : le papayer déteste qu\'on abîme ses racines.':
      'In a nursery, choose young bagged plants, stocky and well green, with an untwisted taproot. Transplant them young (20 to 30 cm): papaya hates having its roots damaged.',
  // ─── accessoires (177 phrases, 3323 mots) ───
  'Toute l\'année, et deux fois par jour en canicule.':
      'All year round, and twice a day in a heatwave.',
  'Arrose au pied, jamais sur les feuilles : l\'eau sur le feuillage appelle le mildiou. Retire la pomme pour les plants installés, remets-la pour les jeunes semis que le jet déchausserait.':
      'Water at the base, never on the leaves: water on the foliage invites blight. Take the rose off for established plants, put it back for young seedlings that the jet would wash out.',
  'Un arrosoir de 10 L couvre deux carrés de 1,20 m. En dessous de 5 L, tu feras trois allers-retours.':
      'A 10 L watering can covers two 1.20 m beds. Below 5 L, you\'ll be making three trips.',
  'Vide-le avant l\'hiver : l\'eau qui gèle dedans fend le plastique. Rince la pomme, le calcaire la bouche trou par trou.':
      'Empty it before winter: water freezing inside splits the plastic. Rinse the rose, limescale blocks it hole by hole.',
  'D\'avril à septembre, deux ou trois jours après chaque pluie.':
      'From April to September, two or three days after each rain.',
  'Gratte les deux premiers centimètres quand la surface est sèche : tu casses la croûte et tu coupes les herbes au collet. Jamais plus profond — tu abîmerais les racines de ce que tu veux garder.':
      'Scrape the top two centimetres when the surface is dry: you break the crust and cut the weeds at the collar. Never deeper — you would damage the roots of what you want to keep.',
  'Une seule. Un fer de 14 cm passe entre les rangs d\'un carré, un fer large ne passe nulle part.':
      'Just one. A 14 cm blade fits between the rows of a bed, a wide one fits nowhere.',
  'Affûte le fer deux fois par saison et graisse le manche à l\'huile de lin.':
      'Sharpen the blade twice a season and oil the handle with linseed oil.',
  'Au semis, avant d\'oublier — c\'est-à-dire tout de suite.':
      'At sowing, before you forget — which means right now.',
  'Écris le nom et la date, au crayon de papier : le feutre s\'efface au soleil en trois semaines. Plante l\'étiquette au nord du rang, elle ne fera pas d\'ombre.':
      'Write the name and the date, in pencil: marker fades in the sun within three weeks. Put the label at the north end of the row, where it casts no shade.',
  'Une par variété, pas par plant. Une vingtaine couvre un potager de quatre carrés.':
      'One per variety, not per plant. Twenty covers a garden of four beds.',
  'Lave-les en fin de saison : elles se réécrivent des années.':
      'Wash them at the end of the season: they can be rewritten for years.',
  'Des bandes découpées dans un pot de yaourt et un crayon de papier font exactement le même travail.':
      'Strips cut from a yoghurt pot and a pencil do exactly the same job.',
  'Pour la ronce, le rosier, le compost et tout ce qui pique.':
      'For brambles, roses, the compost heap and anything that pricks.',
  'Enlève-les pour semer et repiquer : les doigts nus sentent si la motte est assez humide, les gants l\'écrasent.':
      'Take them off to sow and prick out: bare fingers can feel whether the rootball is damp enough, gloves just crush it.',
  'Une paire enduite pour le gros œuvre, une paire fine pour la récolte. Deux paires, pas une.':
      'A coated pair for heavy work, a thin pair for harvesting. Two pairs, not one.',
  'Sèche-les à l\'ombre et à plat. Au soleil, l\'enduit craquelle en une saison.':
      'Dry them flat and in the shade. In the sun, the coating cracks within a season.',
  'En février-mars avant les semis, et en octobre avant l\'hiver.':
      'In February and March before sowing, and in October before winter.',
  'Plante les dents, recule d\'un pas en basculant le manche vers toi : la terre se soulève et se fissure sans être retournée. Les couches du sol restent dans l\'ordre, et la vie qui les habite avec.':
      'Push the tines in and step back while tipping the handle towards you: the soil lifts and cracks without being turned over. The layers stay in order, and the life in them with them.',
  'Une grelinette à 4 dents suffit pour des carrés ; la 5 dents est faite pour la pleine terre.':
      'A 4-tine fork is enough for raised beds; the 5-tine one is made for open ground.',
  'Brosse la terre des dents et passe un chiffon huilé avant de la ranger.':
      'Brush the soil off the tines and wipe them with an oiled cloth before storing.',
  'Du premier radis à la dernière courge.':
      'From the first radish to the last squash.',
  'Récolte le matin, avant que le soleil ne fasse transpirer les feuilles : les salades tiennent deux jours de plus. Ne tasse pas, les tomates du fond s\'écrasent sous le reste.':
      'Harvest in the morning, before the sun makes the leaves sweat: salads keep two days longer. Don\'t pack it down, the tomatoes at the bottom get crushed under the rest.',
  'Un panier de 10 L porte une récolte de courgettes. Au-delà, c\'est la cagette.':
      'A 10 L basket holds one courgette harvest. Beyond that, use a crate.',
  'Rince-le et sèche-le à l\'ombre, surtout s\'il est en osier.':
      'Rinse it and dry it in the shade, especially if it is wicker.',
  'Une cagette à fruits du marché fait l\'affaire, et elle s\'empile.':
      'A fruit crate from the market does the job, and it stacks.',
  'D\'octobre à décembre pour l\'ail, l\'oignon et l\'échalote.':
      'From October to December for garlic, onion and shallot.',
  'Enfonce, tourne d\'un quart de tour, retire : tu emportes une carotte de terre. Pose le bulbe pointe en haut au fond du trou et rebouche avec la terre prélevée.':
      'Push in, give it a quarter turn, pull out: you lift a plug of soil. Set the bulb pointed end up at the bottom of the hole and fill back in with the soil you took out.',
  'Un seul. La profondeur se règle à trois fois la hauteur du bulbe.':
      'Just one. Set the depth to three times the height of the bulb.',
  'Essuie-le après usage : il rouille là où la peinture part.':
      'Wipe it after use: it rusts wherever the paint comes off.',
  'Toute l\'année : tailler, récolter, couper les gourmands.':
      'All year round: pruning, harvesting, pinching out side shoots.',
  'Désinfecte la lame à l\'alcool entre deux plants quand l\'un est malade, sinon tu transportes le virus d\'un pied à l\'autre. Coupe en biais, juste au-dessus d\'un œil.':
      'Disinfect the blade with alcohol between two plants when one is diseased, otherwise you carry the virus from one to the next. Cut on a slant, just above a bud.',
  'Un seul, mais un dont les lames se remplacent : c\'est ce qui fait la différence entre dix ans et deux.':
      'Just one, but one whose blades can be replaced: that is the difference between ten years and two.',
  'Essuie la sève après chaque usage, affûte une fois par mois, huile l\'axe.':
      'Wipe the sap off after each use, sharpen once a month, oil the pivot.',
  'Au repiquage, de mars à juin.':
      'At pricking out, from March to June.',
  'Creuse plus large que la motte, pose, rebouche et tasse à la main avant d\'arroser. Ne tire jamais un plant par la tige : glisse la lame dessous et soulève la motte entière.':
      'Dig wider than the rootball, set it in, fill back and firm by hand before watering. Never pull a plant up by the stem: slide the blade underneath and lift the whole rootball.',
  'Un seul. Le modèle gradué évite de deviner la profondeur.':
      'Just one. The graduated model saves you guessing the depth.',
  'Le manche en bois se fend s\'il passe l\'hiver dehors.':
      'A wooden handle splits if it spends the winter outdoors.',
  'À la plantation — pas quand le plant penche. À ce moment-là, les racines occupent déjà la place du tuteur.':
      'At planting — not when the plant starts leaning. By then the roots already occupy the stake\'s place.',
  'Plante le tuteur d\'abord, le plant ensuite, à 5 cm. Attache en huit avec un lien souple, sans serrer : la tige va grossir.':
      'Put the stake in first and the plant second, 5 cm away. Tie in a figure of eight with soft twine, loosely: the stem is going to thicken.',
  'Un par pied de tomate, trois par poquet de haricots grimpants.':
      'One per tomato plant, three per station of climbing beans.',
  'Brosse et laisse sécher en fin de saison : les champignons passent l\'hiver dans le bois.':
      'Brush them and let them dry at the end of the season: fungi overwinter in the wood.',
  'Une branche de noisetier ou de châtaignier coupée en hiver tient trois saisons.':
      'A hazel or chestnut branch cut in winter lasts three seasons.',
  'Au printemps, avant que les coureuses ne partent au sol.':
      'In spring, before the runners take off along the ground.',
  'Plante deux pieds de courge ou de haricot d\'Espagne de chaque côté et guide les premières tiges à la main : ensuite elles s\'accrochent seules. Les fruits suspendus restent propres et poussent droits.':
      'Plant two squash or runner bean plants on each side and guide the first stems by hand: after that they climb on their own. Hanging fruit stays clean and grows straight.',
  'Une arche de 2 m de large nourrit quatre pieds grimpants et libère autant de surface au sol.':
      'A 2 m wide arch feeds four climbing plants and frees up as much ground.',
  'Ancre-la ou démonte-la avant les coups de vent d\'automne : couverte de feuilles, elle fait voile.':
      'Anchor it or take it down before the autumn gales: covered in leaves, it acts like a sail.',
  'Deux panneaux de treillis à béton cintrés et liés font une arche solide pour trois fois moins.':
      'Two panels of reinforcing mesh bent and tied together make a solid arch for three times less.',
  'Au montage du jardin, idéalement en février-mars.':
      'When setting the garden up, ideally in February or March.',
  'Pose-le sur du carton brun, pas sur une bâche : le carton étouffe l\'herbe puis disparaît, et les vers remontent du sol. Remplis en couches — branches, tontes, compost, terreau en surface.':
      'Set it on brown cardboard, not on a membrane: cardboard smothers the grass then disappears, and the worms come up. Fill it in layers — branches, grass clippings, compost, potting soil on top.',
  '1,20 m de côté, pas plus : c\'est la portée de deux bras, et tu ne marcheras jamais dedans.':
      '1.20 m a side, no more: that is the reach of two arms, and you will never have to walk inside it.',
  'Huile l\'intérieur à l\'huile de lin tous les deux ans. Jamais de produit de traitement : il migre dans la terre.':
      'Oil the inside with linseed oil every two years. Never a wood treatment: it migrates into the soil.',
  'Quatre planches de douglas non traité de 27 mm, vissées aux angles sur des tasseaux.':
      'Four untreated Douglas fir boards 27 mm thick, screwed at the corners onto battens.',
  'De février à avril, puis de septembre à novembre.':
      'From February to April, then from September to November.',
  'Oriente la pente au sud et ouvre dès que le soleil tape : il fait 15 °C de plus à l\'intérieur, et des semis cuisent en une heure. Referme avant le coucher du soleil.':
      'Face the slope south and open it as soon as the sun hits: it is 15 °C warmer inside, and seedlings cook in an hour. Close it before sunset.',
  'Un châssis de 1 m² abrite les semis de tout un potager de quatre carrés.':
      'A 1 m² frame shelters the seedlings of a whole four-bed garden.',
  'Lave le vitrage chaque automne : 20 % de lumière en plus pour un coup d\'éponge.':
      'Wash the glass every autumn: 20 % more light for one wipe of a sponge.',
  'Une vieille fenêtre posée sur un cadre de planches fait un châssis parfait.':
      'An old window laid on a frame of boards makes a perfect cold frame.',
  'Les deux semaines qui suivent un repiquage précoce, et sur les derniers plants d\'automne.':
      'The two weeks following an early transplant, and over the last autumn plants.',
  'Pose-la le soir, retire-la le matin si le soleil donne. Enfonce le bord d\'un centimètre dans la terre, sinon le vent la promène dans le jardin.':
      'Put it on in the evening, take it off in the morning if the sun is out. Push the rim a centimetre into the soil, or the wind will walk it around the garden.',
  'Une par plant précoce. Quatre ou cinq suffisent — ce n\'est pas une couverture, c\'est une avance.':
      'One per early plant. Four or five is enough — it is not a blanket, it is a head start.',
  'Range-les emboîtées à l\'abri : le plastique devient cassant après un hiver au gel.':
      'Store them stacked under cover: the plastic turns brittle after a winter of frost.',
  'Une bouteille d\'eau de 5 L coupée, goulot laissé ouvert pour que l\'air circule.':
      'A 5 L water bottle cut in half, with the neck left open so the air can circulate.',
  'En avril-mai, au semis des haricots et des pois grimpants.':
      'In April and May, when sowing beans and climbing peas.',
  'Plante trois rames en tipi, liées en haut, et sème quatre grains au pied de chacune. Un tipi encaisse le vent qu\'un rang droit prend de plein fouet.':
      'Set three canes in a wigwam, tied at the top, and sow four seeds at the foot of each. A wigwam takes the wind that a straight row meets head on.',
  'Une rame de 1,80 m pour trois pieds. Neuf rames font un carré de haricots.':
      'One 1.80 m cane for three plants. Nine canes make a bed of beans.',
  'Rentre-les sèches et debout : couchées à terre tout l\'hiver, elles pourrissent par le bas.':
      'Bring them in dry and standing up: left lying on the ground all winter, they rot from the bottom.',
  'Le bambou se coupe en janvier dans n\'importe quelle haie qui en porte, et sèche deux mois à l\'abri.':
      'Bamboo is cut in January from any hedge that carries it, and dries for two months under cover.',
  'De mars à mai, puis de septembre aux premières gelées.':
      'From March to May, then from September to the first frosts.',
  'Tends la bâche sans pli : un pli retient l\'eau, et le poids déchire l\'arceau. Laisse les deux bouts ouverts par beau temps, sinon l\'air stagnant fait pourrir les salades.':
      'Stretch the cover without a crease: a crease holds water, and the weight tears the hoop. Leave both ends open in fine weather, or the still air rots the salads.',
  'Un tunnel de 3 m couvre deux carrés mis bout à bout.':
      'A 3 m tunnel covers two beds set end to end.',
  'Replie la bâche sèche à l\'automne. Rangée mouillée, elle moisit en un hiver.':
      'Fold the cover away dry in autumn. Stored wet, it goes mouldy in one winter.',
  'Des arceaux en tuyau PER et une bâche de 100 microns clipsée rendent le même service.':
      'Hoops of plastic water pipe and a 100 micron sheet clipped on do the same job.',
  'Toute l\'année. C\'est d\'abord un choix de dos.':
      'All year round. It is first of all a choice you make for your back.',
  'Remplis sur 25 cm au minimum : en dessous, la terre sèche en une demi-journée d\'été. Place-la à l\'est, le soleil du matin suffit aux salades et ne les brûle pas.':
      'Fill it to at least 25 cm: below that, the soil dries out in half a summer day. Face it east, the morning sun is enough for salads and does not scorch them.',
  'Une table de 80 × 40 cm tient dix salades, ou un rang de radis qu\'on renouvelle toutes les trois semaines.':
      'An 80 × 40 cm table holds ten salads, or a row of radishes renewed every three weeks.',
  'Vérifie que le fond est percé et que l\'eau sort vraiment : une table qui retient l\'eau noie les racines.':
      'Check that the base is drilled and that the water really drains: a table that holds water drowns the roots.',
  'À la plantation, en mai — pas une fois que le pied fait un mètre et part dans tous les sens.':
      'At planting, in May — not once the plant is a metre tall and heading off in all directions.',
  'Conduis une seule tige par pied en l\'enroulant autour d\'une ficelle verticale, et pince les gourmands chaque semaine. Moins de fruits, mais plus gros, et un feuillage qui sèche vite après la pluie — donc moins de mildiou.':
      'Train a single stem per plant by winding it around a vertical string, and pinch out the side shoots every week. Fewer fruit, but bigger, and foliage that dries fast after rain — so less blight.',
  'Un treillis de 1,20 m porte quatre pieds espacés de 40 cm.':
      'A 1.20 m trellis carries four plants spaced 40 cm apart.',
  'Retire ficelles et feuilles sèches avant l\'hiver : le mildiou hiverne dessus.':
      'Take the strings and dry leaves off before winter: blight overwinters on them.',
  'Une ficelle de chanvre tendue entre une barre haute et le sol fait exactement ça.':
      'A hemp string tied between a high bar and the ground does exactly that.',
  'À la plantation d\'une tomate.':
      'When planting a tomato.',
  'Plante la spirale à 10 cm du pied et fais passer la tige dans les boucles au fur et à mesure : rien à attacher, la tige se cale d\'elle-même. Tourne toujours dans le même sens.':
      'Push the spiral in 10 cm from the plant and feed the stem through the loops as it grows: nothing to tie, the stem settles itself. Always turn the same way.',
  'Un par pied. 1,70 m de haut pour une tomate indéterminée, qui ne s\'arrête jamais de monter.':
      'One per plant. 1.70 m tall for an indeterminate tomato, which never stops climbing.',
  'Essuie la terre et range-les au sec : ils durent dix ans.':
      'Wipe the soil off and store them dry: they last ten years.',
  'Dès la plantation des salades, et après chaque pluie de printemps.':
      'As soon as the salads go in, and after every spring shower.',
  'Éparpille quelques granulés autour des jeunes plants, jamais en tas : un tas rassemble les limaces au même endroit au lieu de les éloigner. Le phosphate de fer les fait cesser de manger, et elles meurent cachées — tu ne verras pas de cadavres, c\'est normal.':
      'Scatter a few pellets around the young plants, never in a heap: a heap gathers the slugs in one place instead of keeping them away. Iron phosphate makes them stop feeding, and they die out of sight — you will not find any bodies, and that is normal.',
  '5 g par m², à renouveler après une forte pluie.':
      '5 g per m², renewed after heavy rain.',
  'Garde la boîte fermée et au sec : mouillés, les granulés se délitent et ne servent plus.':
      'Keep the tub closed and dry: wet pellets break down and stop working.',
  'Une planche posée à plat le soir : tu ramasses dessous au matin. Gratuit, mais il faut y aller tous les jours.':
      'A plank laid flat in the evening: you collect underneath in the morning. Free, but you have to go out every day.',
  'De mai à août, contre la mouche de la carotte et la piéride du chou.':
      'From May to August, against carrot fly and the cabbage white.',
  'Pose-le dès le semis, avant que l\'insecte n\'arrive : posé après la ponte, il enferme les chenilles avec le chou. Enterre ou leste les bords, la mouche passe par le moindre jour.':
      'Put it on from sowing, before the insect arrives: laid on after egg-laying, it shuts the caterpillars in with the cabbage. Bury or weight the edges, the fly gets through the smallest gap.',
  'Maille de 0,8 mm contre la mouche de la carotte, 1,35 mm suffit contre les papillons. Prévois 1 m de plus que le carré dans chaque sens.':
      '0.8 mm mesh against carrot fly, 1.35 mm is enough against butterflies. Allow 1 m more than the bed in each direction.',
  'Rentre-le sec et plié : les UV le fragilisent en deux saisons dehors.':
      'Bring it in dry and folded: UV makes it brittle after two seasons outdoors.',
  'Trois semaines avant la maturité des fraises et des cerises.':
      'Three weeks before the strawberries and cherries ripen.',
  'Tends-le sur des arceaux, jamais à même les feuilles : posé dessus, les oiseaux picorent à travers et les oisillons s\'y prennent les pattes. Maille de 15 à 20 mm.':
      'Stretch it over hoops, never straight onto the leaves: laid on top, the birds peck through it and fledglings catch their feet in it. 15 to 20 mm mesh.',
  'La surface du carré, plus 50 cm de retombée sur chaque bord pour le fixer au sol.':
      'The area of the bed, plus 50 cm of overhang on each side to pin it down.',
  'Enroule-le au lieu de le froisser : les mailles se déchirent aux plis.':
      'Roll it rather than crumple it: the mesh tears along the folds.',
  'De juin à septembre en France. Aux heures chaudes toute l\'année sous les tropiques.':
      'From June to September in France. During the hot hours all year round in the tropics.',
  'Tends-le à 50 cm au-dessus des cultures, pas posé dessus : l\'air doit circuler, sinon tu fabriques une étuve. 30 % d\'ombrage pour les tomates et les aubergines, 50 % pour les salades et les semis.':
      'Stretch it 50 cm above the crops, not resting on them: the air has to circulate, or you build an oven. 30 % shade for tomatoes and aubergines, 50 % for salads and seedlings.',
  'Une toile de 2 × 3 m couvre deux carrés.':
      'A 2 × 3 m sheet covers two beds.',
  'Les œillets lâchent avant la toile : double-les d\'une sangle cousue.':
      'The eyelets give way before the fabric: back them with a sewn strap.',
  'Un vieux voilage, ou une canisse posée sur quatre piquets, tamise autant.':
      'An old net curtain, or a reed screen on four posts, filters just as well.',
  'De février à avril, sur les semis et les premiers repiquages.':
      'From February to April, over seedlings and the first transplants.',
  'Pose-le flottant, bords enterrés, sans tendre : les plants le soulèvent en poussant. Il gagne 2 à 3 °C la nuit et coupe le vent, ce qui compte autant. Retire-le à la floraison, les insectes doivent pouvoir passer.':
      'Lay it loose, edges buried, without stretching: the plants lift it as they grow. It gains 2 to 3 °C at night and cuts the wind, which counts just as much. Take it off at flowering, the insects have to get through.',
  'Un voile P17 de 2 × 5 m couvre deux carrés et se recoupe aux ciseaux.':
      'A P17 fleece of 2 × 5 m covers two beds and can be cut down with scissors.',
  'Il tient deux ou trois saisons. Répare les déchirures au ruban adhésif de serre.':
      'It lasts two or three seasons. Mend tears with greenhouse tape.',
  'De novembre à mars, posé avant la première gelée annoncée.':
      'From November to March, put on before the first forecast frost.',
  'Enveloppe sans serrer et laisse le haut ouvert : un voile fermé retient l\'humidité et fait pourrir le cœur de la plante. Il protège jusqu\'à −5 °C, pas au-delà — en dessous, il faut rentrer les pots.':
      'Wrap without tightening and leave the top open: a closed fleece holds moisture and rots the heart of the plant. It protects down to −5 °C, no further — below that, the pots have to come in.',
  'Un voile P30 de 2 × 5 m enveloppe trois artichauts, ou deux agrumes en pot.':
      'A P30 fleece of 2 × 5 m wraps three artichokes, or two citrus trees in pots.',
  'Secoue la neige : son poids mouillé casse les branches que le voile protège.':
      'Shake the snow off: its wet weight breaks the very branches the fleece is protecting.',
  'Au démarrage d\'un tas, et quand il ne chauffe plus.':
      'When starting a heap, and when it stops heating up.',
  'Saupoudre une poignée tous les 20 cm de déchets, puis arrose : il apporte l\'azote et les ferments qui manquent à un tas trop sec ou trop ligneux. ⚠️ Un tas qui sent mauvais manque d\'air, pas d\'activateur — retourne-le d\'abord.':
      'Scatter a handful every 20 cm of waste, then water: it brings the nitrogen and the ferments a heap that is too dry or too woody is missing. ⚠️ A heap that smells bad lacks air, not activator — turn it first.',
  'Une poignée par couche. Un tas bien équilibré en vert et en brun n\'en a pas besoin du tout.':
      'A handful per layer. A heap well balanced in green and brown does not need any at all.',
  'Referme le sac : à l\'humidité, la poudre s\'agglomère en blocs.':
      'Close the bag again: in damp air, the powder cakes into lumps.',
  'Une couche de tontes fraîches, ou du purin d\'ortie dilué, fait le même apport d\'azote.':
      'A layer of fresh grass clippings, or diluted nettle tea, brings the same nitrogen.',
  'Toute l\'année. Le tas ne démarre vraiment qu\'au printemps, quand il se réchauffe.':
      'All year round. The heap only really starts in spring, when it warms up.',
  'Alterne une couche de vert — épluchures, tontes — et une couche de brun — feuilles, carton, broyat — à peu près moitié-moitié. Retourne tous les deux mois. Ni viande, ni laitage, ni plante malade.':
      'Alternate a layer of green — peelings, clippings — and a layer of brown — leaves, cardboard, wood chip — roughly half and half. Turn it every two months. No meat, no dairy, no diseased plants.',
  'Un bac de 300 à 600 L suffit à une famille et rend de quoi pailler et amender quatre carrés par an.':
      'A 300 to 600 L bin is enough for a family and gives you enough to mulch and feed four beds a year.',
  'Pose-le à l\'ombre et sur la terre nue : les vers doivent pouvoir monter du sol.':
      'Put it in the shade and on bare soil: the worms have to be able to come up from the ground.',
  'Quatre palettes vissées en carré, dont une face démontable pour sortir le compost par le bas.':
      'Four pallets screwed into a square, with one side removable to take the compost out from the bottom.',
  'Au printemps à la plantation, puis une fois par mois sur les gourmands : tomate, courgette, chou, poireau.':
      'In spring at planting, then once a month on the hungry ones: tomato, courgette, cabbage, leek.',
  'Griffe-le en surface et arrose. Enfoui trop profond, il nourrit sous les racines. Jamais sur une terre sèche, ni sur un plant qui souffre déjà de la chaleur.':
      'Rake it into the surface and water. Buried too deep, it feeds below the roots. Never on dry soil, nor on a plant already suffering from the heat.',
  '100 g par m² au printemps, et c\'est tout. Trop d\'azote donne un feuillage magnifique et pas de fruits.':
      '100 g per m² in spring, and that\'s all. Too much nitrogen gives magnificent foliage and no fruit.',
  'Les granulés se gardent des années au sec ; un engrais liquide, un an.':
      'Granules keep for years in the dry; a liquid feed, one year.',
  'Le purin d\'ortie dilué à 10 % remplace l\'azote, la cendre de bois tamisée apporte la potasse.':
      'Nettle tea diluted to 10 % replaces the nitrogen, and sieved wood ash brings the potash.',
  'Toute l\'année, et c\'est la solution quand il n\'y a pas de jardin.':
      'All year round, and it is the answer when there is no garden.',
  'Démarre avec 250 g de vers (Eisenia) et nourris petit : ils mangent environ la moitié de leur poids par jour, épluchures coupées fin. Ni agrumes, ni oignon, ni ail — ils acidifient le bac et les vers fuient.':
      'Start with 250 g of worms (Eisenia) and feed them little: they eat about half their own weight a day, peelings chopped small. No citrus, no onion, no garlic — they acidify the bin and the worms leave.',
  'Trois plateaux traitent les déchets de deux personnes, et rendent du lombricompost plus le jus à diluer pour les plantes.':
      'Three trays handle the waste of two people, and give you worm compost plus the liquid to dilute for your plants.',
  'Entre 15 et 25 °C : ni au soleil d\'été, ni dehors en hiver. Un bac trop humide se corrige avec du carton déchiré.':
      'Between 15 and 25 °C: not in the summer sun, not outdoors in winter. A bin that is too wet is corrected with torn cardboard.',
  'Deux seaux de 20 L emboîtés, le premier percé au fond, font un lombricomposteur d\'essai.':
      'Two 20 L buckets stacked, the top one drilled at the bottom, make a trial wormery.',
  'Au printemps, sur une terre réchauffée et désherbée.':
      'In spring, on warmed and weeded soil.',
  'Étale 5 à 7 cm en dégageant le collet des plants. Réserve-le aux massifs, aux fraisiers et aux petits fruits : il acidifie en se décomposant, et il est trop lent pour un carré qu\'on remanie chaque année.':
      'Spread 5 to 7 cm, keeping it clear of the collar of the plants. Save it for borders, strawberries and soft fruit: it acidifies as it breaks down, and it is too slow for a bed you rework every year.',
  'Un sac de 50 L couvre 1 m² sur 5 cm d\'épaisseur.':
      'A 50 L bag covers 1 m² to a depth of 5 cm.',
  'Il tient deux à trois ans. Recharge d\'un centimètre chaque printemps.':
      'It lasts two to three years. Top it up by a centimetre each spring.',
  'De mai aux premières gelées, dès que la terre est réchauffée.':
      'From May to the first frosts, as soon as the soil has warmed up.',
  'Étale 3 à 5 cm sur une terre déjà humide et désherbée : pailler une terre sèche la garde sèche. Dégage le pied des plants de 5 cm, sinon le collet pourrit.':
      'Spread 3 to 5 cm on soil that is already damp and weeded: mulching dry soil keeps it dry. Keep it 5 cm clear of the base of the plants, or the collar rots.',
  'Un sac de 100 L couvre 2,5 m² sur 4 cm — soit deux carrés.':
      'A 100 L bag covers 2.5 m² to a depth of 4 cm — two beds.',
  'Il disparaît en une saison en nourrissant le sol. C\'est voulu, pas un défaut.':
      'It disappears in one season, feeding the soil as it goes. That is the point, not a fault.',
  'Les tontes séchées deux jours, les feuilles mortes ou la paille font le même travail pour rien.':
      'Grass clippings dried for two days, dead leaves or straw do the same job for nothing.',
  'Au semis et au rempotage, de février à juin.':
      'At sowing and potting on, from February to June.',
  'Tamise-le pour les semis : une graine de carotte ne traverse pas un morceau d\'écorce. En pleine terre, ne remplace jamais la terre par du terreau — mélange-les à moitié, le terreau seul sèche vite et se tasse.':
      'Sieve it for seedlings: a carrot seed cannot push past a piece of bark. In open ground, never replace the soil with potting compost — mix them half and half, compost on its own dries fast and settles.',
  'Un sac de 20 L remplit trente godets. Une table de culture de 80 × 40 cm sur 25 cm de profondeur en demande 80 L.':
      'A 20 L bag fills thirty pots. An 80 × 40 cm growing table 25 cm deep needs 80 L.',
  'Referme le sac : à l\'air, le terreau sèche et devient hydrophobe — l\'eau glisse dessus sans entrer.':
      'Close the bag again: in the open air, compost dries out and turns water-repellent — the water runs off without going in.',
  'Toute l\'année sur un balcon. Au printemps pour démarrer.':
      'All year round on a balcony. In spring to get started.',
  'Compte 30 cm de profondeur pour une tomate, 20 pour des salades, 40 pour une carotte longue. Ne mets des billes d\'argile que si l\'eau ne s\'évacue pas : sinon elles prennent la place des racines.':
      'Allow 30 cm of depth for a tomato, 20 for salads, 40 for a long carrot. Only add clay pebbles if the water does not drain: otherwise they take the place of the roots.',
  'Un bac de 80 × 40 cm porte deux pieds de tomate, ou huit salades.':
      'An 80 × 40 cm planter carries two tomato plants, or eight salads.',
  'Une terre cuite pleine d\'eau éclate au gel : vide-la ou rentre-la avant l\'hiver.':
      'Terracotta full of water shatters in a frost: empty it or bring it in before winter.',
  'Un grand sac de terreau couché, percé dessous et fendu dessus, fait un bac de culture pour une saison.':
      'A big bag of potting compost laid flat, holed underneath and slit on top, makes a growing bed for one season.',
  'En janvier-février, quand on prépare l\'année sur le papier.':
      'In January and February, when you are planning the year on paper.',
  'Commence par cinq ou six variétés faciles — radis, laitue, haricot, courgette, basilic, tomate cerise — plutôt que par vingt sachets dont la moitié finira périmée. Note la date d\'achat sur chaque sachet.':
      'Start with five or six easy varieties — radish, lettuce, bean, courgette, basil, cherry tomato — rather than twenty packets half of which will go out of date. Write the purchase date on each packet.',
  'Un sachet de radis sème plusieurs rangs : échelonne-les de trois semaines. Un sachet de tomate suffit à plusieurs saisons.':
      'One packet of radish sows several rows: stagger them three weeks apart. One packet of tomato is enough for several seasons.',
  'Au sec, au frais, à l\'obscurité. Les graines de panais et d\'oignon ne germent plus après deux ans ; celles de tomate tiennent bien plus longtemps.':
      'Dry, cool and dark. Parsnip and onion seed no longer germinates after two years; tomato seed keeps far longer.',
  'Récupère tes graines de tomate : laisse fermenter la pulpe trois jours, rince, sèche. ⚠️ Pas sur un hybride F1, la descendance ne ressemble à rien.':
      'Save your own tomato seed: let the pulp ferment for three days, rinse, dry. ⚠️ Not from an F1 hybrid, the offspring look like nothing.',
  'De mai à septembre, installé avant les grosses chaleurs.':
      'From May to September, installed before the real heat.',
  'Un goutteur par pied, pas un tuyau en serpentin : l\'eau doit arriver aux racines, pas entre les plants. Fais tourner tôt le matin, 20 à 30 minutes d\'affilée plutôt que peu chaque jour — un arrosage long fait descendre les racines.':
      'One dripper per plant, not a hose snaking about: the water has to reach the roots, not the space between plants. Run it early in the morning, 20 to 30 minutes at a stretch rather than a little every day — a long watering sends the roots down.',
  'Quatre goutteurs de 2 L/h par carré de 1,20 m.':
      'Four 2 L/h drippers per 1.20 m bed.',
  'Démonte et rince les goutteurs à l\'automne, le calcaire les bouche. Vide la ligne avant le gel.':
      'Take the drippers off and rinse them in autumn, limescale blocks them. Drain the line before the frost.',
  'De juin à septembre, et pendant les absences.':
      'From June to September, and while you are away.',
  'Enterre-la jusqu\'au col entre deux ou trois plants, puis remplis : la terre cuite suinte à la demande et les racines viennent chercher l\'eau. Garde le couvercle, sinon tu arroses les moustiques.':
      'Bury it up to the neck between two or three plants, then fill it: the terracotta seeps on demand and the roots come to find the water. Keep the lid on, or you are watering mosquitoes.',
  'Une oya de 5 L alimente trois pieds de tomate pendant trois à cinq jours en été. Deux par carré.':
      'A 5 L olla feeds three tomato plants for three to five days in summer. Two per bed.',
  'Déterre-la avant l\'hiver : pleine d\'eau, elle éclate au gel. Brosse le dépôt blanc à l\'eau claire, sans savon.':
      'Dig it up before winter: full of water, it shatters in a frost. Brush the white deposit off with clean water, no soap.',
  'Deux pots de terre cuite non émaillés collés bord à bord, le trou du bas bouché au mastic, font une oya.':
      'Two unglazed terracotta pots glued rim to rim, the bottom hole sealed with mastic, make an olla.',
  'Avant de partir, et de juin à août.':
      'Before you go away, and from June to August.',
  'Règle un créneau long et peu fréquent : 30 minutes trois fois par semaine plutôt que 10 minutes tous les jours. ⚠️ Fais un cycle complet devant toi avant de partir — une pile faible ou un robinet à moitié ouvert, et tu retrouves tout sec.':
      'Set a long, infrequent slot: 30 minutes three times a week rather than 10 minutes every day. ⚠️ Run a full cycle in front of you before you leave — a weak battery or a half-open tap, and you come back to everything dry.',
  'Un seul, sur le robinet, en tête du goutte à goutte.':
      'Just one, on the tap, at the head of the drip line.',
  'Retire la pile et rentre le boîtier l\'hiver : il gèle et se fend.':
      'Take the battery out and bring the unit in for winter: it freezes and splits.',
  'Toute l\'année : il se remplit l\'hiver pour servir l\'été.':
      'All year round: it fills in winter to serve in summer.',
  'Raccorde-le à une descente de gouttière avec un collecteur filtrant, et pose le robinet assez haut pour glisser un arrosoir dessous. L\'eau de pluie est sans calcaire et à température ambiante : les plants ne prennent pas le choc froid du robinet.':
      'Connect it to a downpipe with a filtering diverter, and set the tap high enough to slide a watering can underneath. Rainwater has no limescale and is at air temperature: the plants do not get the cold shock of the mains.',
  '1 mm de pluie sur 10 m² de toit rend 10 L. Une cuve de 300 L se vide en une semaine de canicule sur quatre carrés.':
      '1 mm of rain on 10 m² of roof gives 10 L. A 300 L butt empties in a week of heatwave over four beds.',
  'Couvre-la : à la lumière l\'eau verdit, et une cuve ouverte est un piège pour les animaux. Nettoie le fond une fois par an.':
      'Cover it: in the light the water turns green, and an open butt is a trap for animals. Clean the bottom once a year.',
  'Un bidon alimentaire de 200 L d\'occasion et un collecteur de gouttière suffisent.':
      'A second-hand 200 L food-grade drum and a gutter diverter are enough.',
  'De mai à septembre, sur les rangs serrés.':
      'From May to September, on close-planted rows.',
  'Déroule-le le long du rang, enterré de 5 cm ou glissé sous le paillis, et branche-le sur un robinet à faible pression. Il est fait pour les rangs continus — salades, carottes, fraisiers — là où le goutte à goutte demanderait trente goutteurs.':
      'Unroll it along the row, buried 5 cm down or slipped under the mulch, and connect it to a low-pressure tap. It is made for continuous rows — salads, carrots, strawberries — where drip irrigation would need thirty drippers.',
  '15 m de tuyau couvrent quatre carrés de 1,20 m.':
      '15 m of hose covers four 1.20 m beds.',
  'Il se bouche au calcaire et à la terre : rince-le à pleine pression en début de saison.':
      'It clogs with limescale and soil: flush it at full pressure at the start of the season.',
};
