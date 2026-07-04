# Vision — Lucid Brain

> **Statut :** v1 canonique, gate ① (bootstrap du 3 juillet 2026). Source brainstorm : [VISION-v1.md](VISION-v1.md). Propriétaire : le maintainer ; gardien : le DG.

## Problème

Le vrai ennemi n'est pas « je n'ai pas d'endroit où sauver mes liens » — c'est « je sauve et je n'y reviens jamais ». Les read-later capturent très bien et ne font rien digérer : les connaissances restent éparpillées entre vidéos, articles et notes, sans rien qui pousse à assimiler ni à agir.

Lucid Brain s'adresse d'abord à un utilisateur unique — le maintainer (outil personnel) — submergé par le flux h24, qui veut un second cerveau qui suit son fil rouge. Toute la valeur du produit est *après* la capture : le **« et maintenant ? »**.

## Finalité (définition du succès)

**Zéro capture en limbo : à 30 jours, toute capture est digérée — récoltée (synthèse, application, connexion, revoir) ou lâchée consciemment.**

Garde-fous qui rendent le succès vérifiable :

- ≥ 70 % des captures traitées sous 30 jours ; le reste part en « endormi » puis « lâcher » — le système s'auto-purge, jamais de backlog culpabilisant.
- ≥ 1 synthèse de cortex réellement écrite par mois — la preuve qu'on **digère**, pas seulement qu'on trie.
- « Lâcher » est un succès s'il est conscient ; l'échec, c'est le limbo.

## Périmètre (MVP ~1 mois — cadrage « minimal fidèle »)

1. **Capture zéro-friction** : partage iOS (URL ou note brute) → instantané, ne bloque jamais, ne demande rien.
2. **Pipeline d'extraction en arrière-plan** (backend perso) : contenu → détection de la *forme* (idée vs processus) → fabrication d'un **neurone** ou d'un **circuit**, compressé au résidu + proposition de cortex, état « à confirmer ». Sources texte/article d'abord ; architecture prête pour la vidéo (v1.1).
3. **Cortex + récolte** : seuil de maturité fixe (~5 objets) → notification → **synthèse** (cortex d'idées) ou **curation** (cortex de circuits). La confirmation du rangement se fond dans la récolte — aucune inbox séparée.
4. **Grammaire des sorties** : chaque objet reçoit UNE sortie proposée, à valider ou corriger d'un tap — Appliquer / Connecter / Transmettre / Revoir / Lâcher. Jamais de page blanche.
5. **Endormi / lâcher** : un objet dont le cortex ne mûrit jamais s'endort, puis l'app propose de le laisser filer.
6. **Onboarding fil rouge** : « qu'est-ce que tu veux améliorer ? quels sont tes centres d'intérêt ? » → pose le fil rouge + premiers cortex ; met en scène l'image avant/après (cerveau éparpillé → cerveau qui suit sa ligne).
7. **Export Markdown** compatible Obsidian (portabilité des données).

## Non-objectifs (MVP)

- Pas de transcription vidéo au MVP (v1.1 — le backend l'anticipe : captions natives d'abord, Whisper en fallback).
- Pas de multi-utilisateur, pas de comptes, pas d'Android, pas de web app.
- Pas de niveau d'intérêt, pas de seuil de maturité configurable, pas de graphe riche de synapses (v2), pas de RAG/chat avec sa base.
- Pas de « dents » bloquantes à la capture : le challenge fil-rouge vit à la confirmation/récolte, jamais au moment du partage (protège le zéro-friction).
- Ni read-later, ni Obsidian-bis : pas d'exhaustivité, pas d'encyclopédie. **Compresser, pas extraire.**

## Contraintes

- **Plateforme** : iOS natif, SwiftUI, share extension. Stockage local SwiftData/SQLite = **source de vérité** (offline-first) ; export Markdown ; sync iCloud plus tard.
- **Backend** : serveur personnel self-hosted, **stateless** (extrait, fabrique l'objet, renvoie — ne stocke rien durablement). Pipeline : extraction du contenu → LLM « propositionizer » (compression au résidu, détection idée/processus) → objet + cortex proposé. V1.1 : yt-dlp + faster-whisper.
- **Équipe** : le maintainer n'est **pas développeur** — l'équipe d'agents développe de bout en bout. Exigences : ingénieurs SwiftUI expérimentés (≥ 2 rôles), un lead design garant du « vrai natif iOS », QA et code-review systématiques. Tout doit être vérifiable sans développeur humain : tests verts, critères d'acceptation explicites, démos.
- **Timeline** : MVP utilisable au quotidien en ~1 mois, intensif. On coupe plutôt que de déborder.
- **Budget** : API LLM à l'usage (compression/classification) ; extraction self-hosted pour minimiser les coûts récurrents.

## Domaine & vocabulaire (figé)

| Terme | Définition |
|---|---|
| **Neurone** | Une idée : la plus petite unité de sens retenue d'une source, compressée au résidu qui te sert. Contient : l'idée (1-2 phrases, dans tes mots), la thématique, **« pourquoi ça compte pour toi »** (lien au fil rouge), la sortie proposée, les métadonnées (source, date, état). Test : relu dans 6 mois sans rouvrir la source, toute la valeur est là. N'est ni un marque-page, ni un résumé — il est opiniâtre. |
| **Circuit** | Un processus : chaîne d'étapes ordonnées vers une finalité (finalité, prérequis, étapes complètes dégraissées, résultat attendu). Mémoire procédurale : on garde tout, dans l'ordre. Sortie par défaut : Appliquer. |
| **Synapse** | Un lien entre deux neurones. MVP : minimal ; graphe riche en v2. |
| **Cortex** | Un thème vivant, formulé comme une intention ou une question (« Mieux dormir »), qui accumule jusqu'à maturité (~5 objets), se **récolte** (synthèse ou curation), et peut se **clôturer**. Ni un tag, ni un dossier permanent. |
| **Récolte** | LE rituel unique : confirmer le rangement + réfléchir + relier, déclenché par la **maturité d'un cortex** — jamais par l'âge d'un objet. |
| **Fil rouge** | Ce que tu veux améliorer en ce moment ; posé à l'onboarding ; filtre ce qui entre et structure les cortex. |
| **Endormi** | (francise « stale ») Objet ou cortex resté trop longtemps sans récolte ; candidat à Lâcher. |
| **Sorties** | Appliquer · Connecter · Transmettre · Revoir · **Lâcher** (action valorisée, pas un échec). |

**Tempos** : chaud (à la capture : appliquer/connecter tant que c'est frais) · tiède (à la récolte : cortex mûr → notification) · froid (revoir en résurgence espacée ; endormi → lâcher).

**Ton** : direct, tutoiement, ancré cerveau/lucidité. L'app est un coach lucide, pas une bibliothécaire. Lâcher se célèbre.

## Risques

- **Cognitif (produit)** : recréer le collector's fallacy avec de plus jolis objets. Mitigation : finalité mesurée sur la digestion, auto-purge, et le principe **« la machine propose, l'humain confirme »** — jamais d'auto-organisation silencieuse (cf. étude PKM, `ressources/`).
- **Technique** : extraction d'articles hétérogènes (paywalls, JS) ; qualité de la compression LLM (un neurone fade = un résumé = raté) ; fiabilité de la détection idée/processus.
- **Légal (v1.1)** : CGU des plateformes sociales pour l'extraction vidéo — usage personnel et contenu public uniquement ; réexamen avant tout passage produit.
- **Processus** : équipe 100 % agents — risque de « ça a l'air fini » sans l'être. Mitigation : DoD vérifiables, QA indépendante, gate ③ humaine à chaque sprint review.
- **Périmètre** : 1 mois, c'est court — le scope creep est l'ennemi n°1 ; le DG coupe au nom de la finalité.
