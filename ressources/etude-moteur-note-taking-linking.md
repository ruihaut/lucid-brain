# Concevoir le "moteur" d'un Second Cerveau (PKM) augmenté par IA : méthodes, techniques et analyse d'outils

## TL;DR
- **La brique fondamentale doit être la "note atomique concept-oriented" (une idée par note, autonome, reformulée), reliée à d'autres notes — car c'est le lien et son écriture, pas le stockage, qui produit la connaissance.** Votre concept de "Cortex" (dossiers reliables) est sain à condition qu'il reste une couche souple par-dessus un graphe de liens, jamais l'inverse.
- **Techniquement, le moteur idéal est un pipeline en 6 étapes** : transcription (Whisper/captions natives) → découpage en propositions atomiques par LLM → extraction de concepts/entités → embeddings + similarité cosinus pour suggérer des liens → stockage vectoriel (pgvector au départ) + graphe → RAG pour "discuter" avec sa base.
- **Le principal danger n'est pas technique mais cognitif : le "collector's fallacy" et l'auto-linking 100% automatique qui retire la friction bénéfique.** La bonne architecture est "la machine propose, l'humain confirme" : l'IA génère les notes et suggère les liens, mais pousse activement l'utilisateur à retravailler/valider, sinon vous reproduisez exactement le problème du doomscrolling que vous voulez résoudre.

## Key Findings

1. **L'atomicité ne se réduit pas à la brièveté.** Une bonne note atomique contient *une seule idée*, est autonome (compréhensible seule) et reformulée dans ses propres mots. zettelkasten.de insiste : réduire l'atomicité à "faire des notes courtes" est un sophisme (false dichotomy).

2. **Organiser par concept, pas par source.** Andy Matuschak : les notes evergreen doivent être "concept-oriented" plutôt que par livre/auteur/projet — c'est ce qui fait émerger des connexions inattendues entre domaines.

3. **Le lien EST la pensée.** Matuschak : ajouter des liens "crée une pression pour réfléchir soigneusement à la façon dont les idées se relient" et favorise l'"elaborative encoding". C'est un argument central pour NE PAS tout automatiser.

4. **PARA et CODE sont complémentaires du Zettelkasten**, pas concurrents : PARA (Projects/Areas/Resources/Archives) organise par *actionnabilité*, le Zettelkasten par *connexion conceptuelle*. Votre app peut offrir les deux vues.

5. **Le "collector's fallacy" est le risque n°1 de votre cible grand public** : accumuler donne l'illusion du progrès. "Savoir qu'une chose existe" n'est pas "la connaître" (Tietze).

6. **La transcription est un problème résolu** : captions natives d'abord, Whisper en fallback. C'est le standard de l'industrie.

7. **Le découpage atomique est le vrai différenciateur technique** : le "propositional chunking" (LLM décompose en faits atomiques auto-contenus) est directement l'implémentation technique de la "note atomique".

8. **L'auto-linking par embeddings fonctionne mais doit rester une suggestion.** Mem.ai et Reflect le font déjà via similarité sémantique ; les meilleurs retours d'expérience valorisent une IA "optionnelle et discrète", pas intrusive.

## Details

### AXE 1 — Méthodes conceptuelles

**Zettelkasten (Niklas Luhmann).** Selon Sönke Ahrens (*How to Take Smart Notes*, 2017), Luhmann a publié plus de 70 livres et plus de 400 articles académiques ; sa Zettelkasten comptait plus de 90 000 fiches accumulées sur environ 40 ans à partir des années 1950. Le workflow canonique distingue trois types de notes :
- **Notes fugitives (fleeting)** : capture brute, temporaire — l'équivalent de l'"inbox" GTD. La plupart doivent mourir.
- **Notes littéraires (literature)** : ce que vous retenez d'une source, dans vos propres mots, avec la référence.
- **Notes permanentes (permanent)** : le cœur du système — une idée clarifiée, autonome, reliée aux notes existantes.
- **Notes structure/index (structure notes)** : points d'entrée qui organisent des ensembles de notes.

Principe clé (David Clear, cité par la communauté) : à chaque nouvelle note, la relier à au moins une note existante, et écrire *pourquoi* elles se relient. Éviter les notes orphelines. C'est de cette activité que naissent les "possibilités combinatoires jamais planifiées" dont parlait Luhmann lui-même.

**Notes atomiques.** zettelkasten.de ("The Complete Guide to Atomic Note-Taking") : l'atomicité est "une bonne pensée qui se manifeste dans vos notes". Une note atomique = un concept unique, ce qui la rend facile à relier, réarranger et réutiliser. Le piège à éviter : confondre "court" et "atomique".

**Evergreen notes (Andy Matuschak).** Principes (notes.andymatuschak.org) :
- *Should be atomic* — un concept par note ; on peut écrire/finir une note en moins de 30 min.
- *Should be concept-oriented* — factoriser par concept, pas par source.
- *Should be densely linked* — "si nous nous forçons à ajouter beaucoup de liens, cela nous fait penser de manière expansive".
- *Prefer associative ontologies to hierarchical taxonomies* — préférer les liens aux arborescences rigides.
- *Write notes for yourself by default.*
Philosophie fondatrice : "'Better note-taking' misses the point; what matters is 'better thinking'." Le but n'est pas de prendre des notes mais de mieux penser. Le maintien des liens "approche la répétition espacée" (on relit d'anciennes notes en cherchant où relier les nouvelles). (À noter : Matuschak lui-même signale que le bénéfice mémoriel de l'elaborative encoding est débattu — cf. Karpicke & Smith 2012, qui suggèrent que la pratique de récupération seule peut suffire.)

**PARA + CODE (Tiago Forte, Building a Second Brain, 2022).**
- **PARA** : Projects (objectifs avec deadline), Areas (responsabilités continues), Resources (sujets d'intérêt), Archives (inactif). Organise par *actionnabilité*, pas par sujet.
- **CODE** : Capture (ne capturer que ce qui "résonne"), Organize, Distill, Express. "Express" est l'étape cruciale : "Un second cerveau qui ne fait que capturer et n'exprime jamais est une bibliothèque que personne ne visite."
- **Progressive Summarization** : surlignage en couches. Forte (fortelabs.com) décrit 4 couches : Layer 1 = le passage capturé ; Layer 2 = mise en gras des meilleurs passages ; Layer 3 = surlignage du "best of the best" ; Layer 4 = résumé exécutif informel en ses propres mots en haut de la note. À faire de manière "paresseuse" : ne distiller que les notes qu'on ré-ouvre.
- **Intermediate Packets** : petits blocs réutilisables de travail (les "briques Lego" de la connaissance).
- Fait notable : les commentateurs 2026 observent que l'étape "Distill" (Progressive Summarization manuelle) est désormais partiellement remplaçable par l'IA — exactement votre créneau.

**Méthode Cornell.** Développée par Walter Pauk (Cornell, années 1950). Page divisée en 3 : colonne de notes (droite, ~2/3), colonne d'indices/questions (gauche, ~1/3, remplie *après*), résumé (bas). Cycle "Record, Questions, Recite, Reflect, Review". Sa force : le rappel actif (active recall) est intégré au format — on masque les notes et on répond aux questions-indices. Pertinent pour votre app : générer automatiquement une "colonne d'indices" (questions) et un résumé à partir d'un contenu transcrit.

**Mind mapping et brainstorming (Tony Buzan, etc.).**
- **Mind mapping** : depuis un sujet central, ramification divergente — idéal pour prototyper visuellement plusieurs solutions.
- **Concept mapping** : relations explicites et étiquetées entre concepts (plus formel que le mind map).
- **SCAMPER** (Bob Eberle, 1971, d'après Alex Osborn) : Substitute, Combine, Adapt, Modify, Put to another use, Eliminate, Reverse — 7 prompts pour innover sur un objet existant. Domaine public.
- **Six chapeaux (Edward de Bono)** : blanc (faits), rouge (émotions), noir (risques), jaune (bénéfices), vert (créativité), bleu (contrôle du processus) — "parallel thinking".
- **Technique Feynman** : expliquer simplement pour révéler ses lacunes de compréhension. Directement implémentable par un LLM qui demande à l'utilisateur d'expliquer une note "comme à un enfant".
- **Association libre / brainwriting / reverse brainstorming** : compléments.

**Spaced repetition et mémorisation.** Le lien Matuschak est explicite : le maintien des notes evergreen approche la répétition espacée ; et "la répétition espacée peut aider à développer des intuitions incrémentales" quand on ne peut pas encore écrire une note atomique complète. RemNote, Readwise et Anki intègrent le SRS. Pour votre app : proposer de transformer des notes atomiques en cartes de révision (question-indice → réponse).

**Débats et critiques (à intégrer au design).**
- **Collector's fallacy** (Christian Tietze, zettelkasten.de) : "'savoir qu'une chose existe' n'est pas 'la connaître'... Rien n'est gagné tant que nous n'avons pas fusionné cela dans notre propre savoir." Le fait d'accumuler procure une récompense trompeuse. Le forum précise que le sophisme consiste à "confondre la préparation elle-même (et le sentiment de faire grossir la pile) avec un progrès vers le produit".
- **Productivity porn** : passer plus de temps à peaufiner le système qu'à produire (le piège Tana/Obsidian du "tinkering" perpétuel).
- **Sur-organisation** : les taxonomies hiérarchiques rigides freinent l'émergence ; préférer l'associatif.
- **Critique de l'IA dans le vault** (Simon Späti, ssp.sh, "Keep AI Out of Your (Obsidian) Vault") : verbatim — *"don't use it for tagging or organization, because eventually all your relations and connections won't count for anything, since they aren't made by you. The power lies in the deliberately created graph of notes, your very own Second Brain."* Il cite aussi le CEO d'Obsidian Steph Ango : un résumé de PDF est du bruit ; une idée tirée de la lecture est du signal. **C'est LA tension centrale de votre produit.**

### AXE 2 — Moyens techniques

**1. Transcription audio/vidéo (speech-to-text).**
- **Stratégie recommandée** : d'abord récupérer les *captions natives* (YouTube, TikTok, Reels ont souvent des sous-titres auto), puis *fallback Whisper* si absentes. C'est le pattern de tous les services d'extraction (Supadata, Apify, etc.).
- **Whisper (OpenAI)** reste le standard open-source (MIT, 99+ langues) mais n'est plus le plus précis : NVIDIA Canary-Qwen, IBM Granite Speech et Qwen3-ASR ont un WER plus bas en anglais début 2026. **Whisper Large V3 Turbo** (sorti le 1er octobre 2024, DevDay, licence MIT) a un décodeur élagué de 32 à 4 couches (1,55 B → 809 M params) : selon la model card OpenAI (Hugging Face), il est environ 8× plus rapide sur A100 ; les benchmarks communautaires (faster-whisper) rapportent un WER "batched" d'environ 7,7 % et une hausse de seulement 0,3–0,7 point de WER par rapport à large-v3 (~2,7 % → 3-4 % sur LibriSpeech clean).
- **Optimisations** : faster-whisper (4x plus rapide, self-hosting), whisper.cpp (edge/mobile), WhisperX (VAD + réduction d'hallucinations). Whisper hallucine sur les silences/audio bruité et n'a pas de diarisation native (ajouter pyannote.audio).
- **APIs managées** : Deepgram Nova-3, AssemblyAI (intelligence audio intégrée : résumé, sentiment), gpt-4o-transcribe.
- **Extraction depuis les plateformes sociales** : services/APIs type Supadata, Apify (extraction captions → fallback Whisper), 95%+ de précision sur audio clair. ⚠️ Attention juridique : ne traiter que le contenu public et respecter les CGU des plateformes.

**2. Découpage en notes atomiques (le cœur du moteur).**
La littérature récente (arXiv 2024-2026) distingue plusieurs stratégies de "chunking" :
- **Fixed-size / recursive character** : simple mais casse la sémantique.
- **Semantic chunking** : détecte les ruptures de sujet via chute de similarité cosinus entre phrases consécutives (méthode Kamradt) — chunks thématiquement cohérents.
- **Propositional / atomic chunking** : un LLM décompose le texte en *propositions*. Source de référence : Tong Chen et al., "Dense X Retrieval: What Retrieval Granularity Should We Use?", EMNLP 2024 (arXiv:2312.06648) — verbatim : *"Propositions are defined as atomic expressions within text, each encapsulating a distinct factoid and presented in a concise, self-contained natural language format."* Leur modèle "Propositionizer" est un Flan-T5-large distillé depuis GPT-4 (corpus FactoidWiki de 42k passages). Trois principes : signification distincte, minimalisme (pas deux faits dans un chunk), auto-contenu (résoudre les pronoms/références). **C'est exactement l'implémentation technique de la "note atomique".**
- **LumberChunker** : LLM insère des breakpoints aux changements de sujet ; surpasse semantic/recursive/proposition sur texte narratif mais coûteux.
- **Recommandation** : pipeline hybride — segmentation phrase/paragraphe → détection sémantique de frontières → passe LLM "propositionizer" pour produire des notes atomiques auto-contenues avec résolution des références. Coût typique observé : ~0,0004 $/document avec GPT-4o-mini pour l'extraction.

**3. Extraction de concepts/entités et auto-tagging.**
- **Keyword extraction** (KP-Miner, etc.), **NER**, **topic modeling** classiques restent utiles mais sont surpassés par les LLM.
- **Zero-shot / few-shot classification par LLM** : donner au LLM le label + une description (~50 mots) améliore nettement le tagging. Scikit-LLM permet d'intégrer ça dans un pipeline scikit-learn. Pour un dossier "Cortex", générer une taxonomie de tags puis assigner en zero-shot (cohérence >90% rapportée dans la littérature bancaire).
- **Recommandation** : auto-tagging comme *suggestion* (l'utilisateur valide), pas comme vérité imposée.

**4. Création automatique de liens (embeddings + similarité).**
- Principe : encoder chaque note en vecteur (embedding), calculer la **similarité cosinus** entre notes ; les notes proches sont candidates au lien. Formule : cos(θ) = (A·B)/(‖A‖‖B‖), ∈ [-1,1].
- ⚠️ **Attention** : Harald Steck, Chaitanya Ekanadham & Nathan Kallus (Netflix & Cornell), "Is Cosine-Similarity of Embeddings Really About Similarity?", Companion Proc. ACM Web Conference 2024 (arXiv:2403.05440), montrent — verbatim — que *"cosine-similarity can yield arbitrary and therefore meaningless 'similarities'... we caution against blindly using cosine-similarity and outline alternatives."* Combiner avec du BM25/full-text (recherche hybride) est plus robuste.
- **Modèles d'embeddings 2025-2026** : OpenAI text-embedding-3-small (1536 dim, ~0,02 $/M tokens, standard économique) et -3-large (3072 dim) ; open-source : BGE-M3 (multilingue 100+ langues, MIT), Qwen3-Embedding, EmbeddingGemma-300M, NV-Embed-v2 (top MTEB). Pour multilingue FR : BGE-M3 ou Cohere embed-v4 sont de bons choix. Matryoshka (MRL) permet de réduire les dimensions pour économiser.
- **Recommandation** : auto-linking = suggestion classée par score (top-k), l'utilisateur confirme. Ne PAS écrire de liens silencieusement.

**5. Bases de données vectorielles & RAG.**
- **RAG** (Retrieval-Augmented Generation) : pour "discuter" avec sa base — on récupère les chunks les plus similaires à la question et on les passe au LLM comme contexte. C'est ce qui permet "poser une question à son second cerveau".
- **Choix de vector DB** :
  - **pgvector** (extension Postgres) : idéal au démarrage — vecteurs et données relationnelles dans un seul système, pas de service supplémentaire. Recommandé comme point de départ par plusieurs praticiens en production.
  - **Chroma** : parfait pour le prototypage local (zéro config).
  - **Qdrant** (Rust) : self-hosted performant, excellent filtrage, "un docker run de la prod".
  - **Pinecone** : managé, zéro ops, scale à des milliards de vecteurs, mais coût qui grimpe.
  - **Weaviate** : recherche hybride native + modules de vectorisation, mais plus lourd.
  - **Milvus** : pour 100M+ vecteurs.
  - Consensus des praticiens : "la DB est rarement le goulot ; le chunking et la stratégie d'embedding le sont." Commencer avec pgvector, migrer si besoin.
- **Architecture typique** (pattern FTI / offline-online) : séparer strictement le **pipeline d'ingestion offline** (transcription → chunking → embedding → indexation) du **pipeline de requête online** (RAG). Ne jamais ingérer au moment de la requête.

**6. Knowledge graphs.**
- Construction par LLM : extraction de **triplets** (sujet, prédicat, objet) depuis le texte, puis stockage dans **Neo4j** (ou ArangoDB, GraphDB). Neo4j fournit un "LLM Knowledge Graph Builder" open-source qui transforme PDF/pages web/YouTube en graphe.
- Étapes : découpage (chunks avec overlap ~64 tokens) → extraction entités+relations → **résolution d'entités** (fusionner les nœuds identiques, normalisation en minuscules, résolution des anaphores) → écriture du graphe.
- **GraphRAG** vs **VectorRAG** : le GraphRAG capture des triplets et dépend moins du texte brut ; utile pour les questions multi-sauts. Peut être combiné avec le vector search.
- **Recommandation pour votre app** : le graphe de *notes liées* (backlinks) suffit pour la V1 ; un vrai knowledge graph d'entités (Neo4j) est un ajout "power user" de phase 2, coûteux à maintenir.

### AXE 3 — Analyse comparative des outils

| Outil | Modèle de données | Atomicité | Linking | Organisation | IA |
|---|---|---|---|---|---|
| **Obsidian** | Fichiers Markdown locaux | Page-niveau | Liens [[wiki]] bidirectionnels, backlinks, graphe global+local | Dossiers + tags + MOCs | Via plugins (Smart Connections, Copilot) — local |
| **Roam Research** | Base de données, block-based | **Bloc-niveau** (le plus granulaire) | Block references + bidirectionnel, daily notes | Émergent (peu de dossiers) | Plus faible que Tana ; cloud-only |
| **Logseq** | Markdown local, outliner | Bloc-niveau | Block refs, bidirectionnel, daily notes | Outliner, tags hérités parent→enfant | Limitée |
| **Notion** | Bases de données, blocs | Page/bloc | Backlinks (moins central) | Databases, propriétés | Notion AI (résumé, écriture) |
| **Tana** | Nodes + **supertags** | Node-niveau typé | Liens + supertags (schémas typés) | Structure typée puissante | IA profonde (parmi les meilleures) |
| **Mem / Mem.ai** | Cloud, IA-first | Note | **Auto-linking sémantique** (embeddings OpenAI + Pinecone, cosinus + re-ranking) | "Zero organization" — l'IA organise | Cœur du produit ; chat, Related Mems |
| **Reflect** | Cloud chiffré E2E | Note | Bidirectionnel manuel + backlinks IA (déclenchés par l'utilisateur), similar notes (embeddings client-side) | Daily notes | GPT intégré, transcription Whisper |
| **Capacities** | Objets typés (Person, Book…) | Objet | Liens bidirectionnels natifs | Par type d'objet | Croissante |
| **Anytype** | Objets, local-first, chiffré | Objet | Liens + graphe | Objets typés | Croissante |
| **Heptabase** | Cartes sur whiteboards | **Carte** (index card) | Liens + arrangement spatial visuel | Whiteboards, mind maps, tags | Modérée ; intègre Readwise |
| **RemNote** | Outliner, blocs | Bloc + flashcards | Bidirectionnel | Hiérarchique | **Spaced repetition natif** (SRS), Zotero, Anki |
| **Readwise Reader** | Capture/surlignage | Surlignage | Sync vers Obsidian/Notion/Roam | Bibliothèque | Résumé, SRS sur highlights |

**Détails techniques sur l'auto-linking (Mem & Reflect) — utile pour votre moteur :**
- **Mem.ai** (blog d'ingénierie "Building Mem X", Isabella Fulford) : utilise les embeddings OpenAI + la recherche vectorielle Pinecone. "Similar mems" récupère l'embedding du document courant, interroge l'index pour les embeddings les plus proches (plus haute similarité cosinus) avec filtres de métadonnées, puis "re-rank et re-weight" via un algorithme propriétaire de clustering et de normalisation de longueur. **Aucun seuil numérique publié** — c'est du top-k relatif.
- **Reflect** : "similar notes" via *embeddings client-side / on-device* (index sémantique local). Fait notable : le backlinking par IA de Reflect est **déclenché par l'utilisateur** (il surligne un paragraphe et invoque "Decorate my writing with backlinks"), pas silencieux. Les critiques valorisent que l'IA soit "disponible mais discrète".

**Enseignements clés pour votre moteur :**
1. **Granularité du linking** : Roam/Logseq (bloc) > Obsidian (page). Pour des "notes atomiques", visez le niveau note/bloc, pas la page.
2. **Tana** montre la valeur des **supertags typés** (schémas) : puissant pour les power users/chercheurs, mais courbe d'apprentissage raide — à réserver à un mode avancé.
3. **Mem** prouve que l'auto-linking sémantique fonctionne commercialement ("connexions automatiques" via embeddings), mais les critiques notent un manque de "vraie profondeur PKM" et un risque de suggestions bruitées.
4. **Reflect** illustre le bon compromis : l'IA est "disponible mais discrète", le backlinking IA est *déclenché par l'utilisateur*, pas silencieux.
5. **Heptabase** valide l'approche "carte" (index card) + canvas spatial pour les visuels — proche de la boîte de fiches physique de Luhmann.
6. **RemNote** montre l'intégration réussie du SRS pour la rétention.
7. **Tendance émergente** : tous ajoutent de l'IA (résumé, chat, auto-organisation), mais le clivage de fond reste **automatisation (Mem) vs intentionnalité (Reflect/Obsidian)**. Votre différenciateur peut être de *réconcilier* les deux.

**Le pattern "machine propose, humain confirme" existe déjà** et devrait inspirer votre moteur : le plugin Obsidian "Note Linker" "présente une liste de connexions potentielles que l'utilisateur confirme avant d'appliquer les liens" ; Smart Connections crée des embeddings locaux pour *découvrir* des notes proches, mais laisse l'humain décider. Späti recommande explicitement d'utiliser l'IA pour "trouver des notes reliées" (découverte) tout en gardant l'écriture délibérée du lien humaine.

**Ce qui différencie une bonne app de PKM** : (a) la friction de capture est minimale mais la friction de *traitement* est préservée (elle force la pensée) ; (b) les liens sont faciles à créer et *toujours* accompagnés d'un "pourquoi" ; (c) le système pousse activement à ré-exprimer/réviser (combat le collector's fallacy) ; (d) la portabilité des données (Markdown, export) ; (e) l'IA assiste sans déposséder l'utilisateur de sa pensée.

## Recommendations

**Principe directeur : "La machine propose, l'humain confirme et retravaille."** C'est la seule façon de servir à la fois le grand public (qui veut de la magie) et les power users (qui veulent de la profondeur), sans reproduire le doomscrolling passif dans l'app.

**Phase 1 — MVP (le moteur de base) :**
1. **Ingestion** : capture par partage d'URL/fichier → captions natives d'abord, Whisper (faster-whisper self-hosted ou API) en fallback.
2. **Découpage atomique** : pipeline LLM "propositionizer" (propositional chunking, façon Dense X Retrieval / Chen et al. 2024) produisant des notes atomiques auto-contenues (une idée, reformulée, références résolues). C'est votre cœur technique — investissez-y le plus.
3. **Résumé + fiche** : pour chaque contenu, générer un résumé abstractif + une fiche structurée (façon Cornell : titre-concept, points-clés, questions/indices, résumé).
4. **Stockage** : Postgres + **pgvector** (vecteurs + relationnel unifiés). Embeddings : OpenAI text-embedding-3-small ou BGE-M3 (si multilingue/self-hosted).
5. **Cortex** : dossiers souples ; l'utilisateur choisit de les relier ou non. En interne, tout est un graphe de notes.
6. **Anti-collector's fallacy dès la V1** : file d'attente de "notes à retravailler", rappels, et un indicateur "traité/non-traité". Ne jamais laisser une note capturée rester intouchée sans relance.

**Phase 2 — Intelligence de liens :**
7. **Auto-linking par similarité** : top-k suggestions classées par cosinus (+ BM25 hybride pour robustesse), présentées comme *propositions à confirmer* (modèle "Note Linker"). Demander/générer le "pourquoi" du lien.
8. **Auto-tagging zero-shot** par LLM avec descriptions de tags, en suggestion.
9. **RAG conversationnel** : "discuter avec son Cortex" — récupération hybride + génération, avec citation systématique des notes sources (provenance).
10. **Génération de flashcards** (SRS) optionnelle à partir des notes atomiques, pour la rétention.

**Phase 3 — Power users :**
11. **Knowledge graph d'entités** (Neo4j / extraction de triplets) pour la navigation multi-sauts et le GraphRAG.
12. **Supertags typés** (à la Tana) et vues multiples (PARA par actionnabilité ET graphe par concept).
13. **Modes de brainstorming assistés** : SCAMPER, six chapeaux, Feynman ("explique cette note simplement") comme prompts appliqués aux notes existantes.

**Seuils / benchmarks qui doivent faire évoluer vos choix :**
- Si le chunking atomique produit trop de notes redondantes → passer de proposition pure à LumberChunker ou ajuster le seuil de similarité de déduplication.
- Si pgvector dépasse ~10M vecteurs ou la latence de requête devient un problème → migrer vers Qdrant (self-host) ou Pinecone (managé).
- Si les suggestions de liens sont jugées "bruitées" par les utilisateurs → relever le seuil de similarité, ajouter re-ranking, ou passer en hybride vecteur+BM25.
- Si le taux de notes "jamais retravaillées" reste élevé → renforcer les mécanismes de relance (le vrai KPI de votre produit).

## Caveats
- **Sources de qualité variable** : les principes conceptuels s'appuient sur des sources primaires solides (notes.andymatuschak.org, zettelkasten.de, Forte/Building a Second Brain, Ahrens *How to Take Smart Notes*, et des articles arXiv revus). En revanche, une partie des comparatifs d'outils et des classements d'embeddings/vector DB proviennent de blogs commerciaux ou orientés SEO (souvent liés à un produit) : les chiffres précis (prix, dimensions, WER, scores MTEB) doivent être revérifiés sur les sources officielles avant décision d'ingénierie, car ils évoluent vite (le paysage embeddings/STT change quasi mensuellement).
- **Prospectif/non établi** : plusieurs affirmations "2026" sur les modèles (Qwen3-ASR SOTA, Gemini Embedding 2, Voyage-4) proviennent de pages datées mais commerciales ; traiter comme indicatif.
- **Lacune de preuve** : il n'existe pas (à ma connaissance) d'étude empirique rigoureuse comparant les résultats *cognitifs* du linking automatique vs manuel. Le débat est théorique/praticien. La recommandation "humain dans la boucle" est un pari de conception fondé sur la théorie (Matuschak, Zettelkasten) et les retours d'usage, pas sur un essai contrôlé.
- **Juridique** : l'extraction de transcriptions depuis YouTube/TikTok/Instagram doit respecter les CGU des plateformes et le droit d'auteur ; se limiter au contenu public et à un usage personnel, prévoir un examen juridique avant lancement.
- **Similarité cosinus** : ne pas s'y fier aveuglément (Steck et al. 2024, arXiv:2403.05440) ; toujours valider sur vos données réelles et envisager la recherche hybride.