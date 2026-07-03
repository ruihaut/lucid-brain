# Lucid Brain — Vision v1

> **Statut :** v1, issue du brainstorm. Application iOS. Outil personnel d'abord.
> **Date :** 2 juillet 2026

## En une phrase

Lucid Brain transforme ce que tu enregistres au fil du web en connaissance digérée et actionnable — pas un presse-papier de plus, mais un second cerveau qui te pousse à assimiler et à agir.

## Ce qu'on combat

Le vrai ennemi n'est pas « je n'ai pas d'endroit où sauver mes liens » — c'est « je sauve et je n'y reviens jamais ». Les read-later (Pocket, mort depuis juillet 2025, en tête) meurent tous au même endroit : excellents pour capturer, nuls pour faire *quelque chose* de ce qui est capturé. Les connaissances restent éparpillées entre vidéos, articles et notes, et rien ne pousse à les assimiler ni à les actionner.

Le cœur de Lucid Brain n'est donc pas la capture — tout le monde sait faire — mais l'après : le **« et maintenant ? »**.

Image directrice (onboarding) :
- **Avant** : un cerveau éparpillé, submergé par le flux h24, incapable d'assimiler ou d'agir.
- **Après** : un cerveau qui suit son fil rouge, qui digère ce qu'il enregistre et agit quand il le faut.

## Principe fondateur

Deux partis pris commandent tout le reste :

1. **Compresser, pas extraire.** L'antidote à l'éparpillement n'est pas d'extraire *toute* l'information d'une source — ça en crée davantage. C'est de compresser jusqu'au résidu qui te sert. Une source bien traitée tient sur une carte que tu pourras relire dans 6 mois sans jamais rouvrir l'original.
2. **Le fil rouge a des dents.** Il ne se contente pas d'organiser : il filtre. L'app peut te décourager de sauver un contenu hors-sujet (« marrant, mais ça ne sert pas ce que tu cherches à améliorer — tu sauves quand même, ou tu lâches ? »). Ce « non » est exactement l'image du cerveau qui cesse de s'éparpiller.

## Le fil rouge

Défini à l'onboarding (« qu'est-ce que tu veux améliorer en ce moment ? quels sont tes centres d'intérêt ? »). Il sert à deux choses : **filtrer** ce qui entre, et **structurer** les cortex, qui sont autant de facettes de ce que tu veux devenir. Il garde l'app centrée sur toi, pas encyclopédique.

## Modèle d'objets

### Neurone — une idée
La plus petite unité de sens retenue d'une source, compressée à ce qui te sert. Pas une copie, pas un résumé : le résidu.

*Test :* si tu le relis dans 6 mois sans rouvrir la source, tu dois en avoir toute la valeur.

Contient (MVP) :
- **L'idée** — la seule chose à retenir, 1-2 phrases, dans tes mots.
- **La thématique générale** — sert à proposer le cortex.
- **Pourquoi ça compte pour toi** — le lien au fil rouge. Le champ qui nous sépare d'un simple résumeur.
- **La sortie proposée** — une action de la grammaire (voir plus bas).
- **Métadonnées** — source, date, état (à confirmer / rangé / stale).

*N'est pas :* un marque-page, un highlight, ni un résumé complet. Un neurone est opiniâtre — c'est « ce que toi tu dois en tirer ».

### Circuit — un processus
Une chaîne d'étapes ordonnées qui produit une finalité (typiquement un reel « X étapes pour obtenir Y »). Mémoire **procédurale**, pas déclarative : ici la valeur est dans la *complétude ordonnée*, pas dans la compression. On garde toutes les étapes, dégraissées du blabla.

Contient (MVP) :
- **La finalité** — le résultat visé.
- **Les prérequis / le matériel** — ce qu'il faut avant de commencer.
- **Les étapes ordonnées** — le cœur, gardé en entier.
- **Le résultat attendu** — éventuellement durée / difficulté.
- **Source + lien au fil rouge.**

*Sortie par défaut :* Appliquer (le faire).

### Synapse — un lien
Une connexion entre deux neurones (les liens façon Obsidian). Ce qui fait passer d'une collection à un réseau.

### Cortex — un thème vivant
Pas un dossier : un thème qui accumule neurones et circuits jusqu'à être **mûr** pour dire quelque chose. Unité de synthèse, pas de stockage.

- **Une maturité** — un seuil (~4-5 objets) déclenche la récolte.
- **Une synthèse vivante** — ton propre point de vue, que *tu* écris et qui grandit à mesure que tu digères. C'est la récompense.
- **Un ancrage dans le fil rouge** — un cortex est souvent une facette de ce que tu veux améliorer.

Se formule comme une **intention ou une question** (« Mieux dormir », « Comment récupérer plus vite ? ») plutôt qu'un nom-tiroir (« Sommeil ») — une question appelle une synthèse, un nom ne fait qu'accumuler.

**Peut se clôturer :** quand sa question est digérée, on le ferme. Une fin satisfaisante, pas un dossier qui gonfle à l'infini.

*N'est pas :* un tag, ni un dossier permanent.

> **Vocabulaire cohérent de bout en bout :** neurone (nœud / idée) → synapse (lien) → circuit (chaîne ordonnée) → cortex (thème). *Termes provisoires, à figer.*

## La grammaire des sorties

« Actionner » ≠ « faire une tâche ». Chaque neurone ou circuit se voit proposer **une** sortie, pré-calculée par l'app : l'utilisateur valide ou corrige d'un tap, il ne part jamais d'une page blanche.

- **Appliquer** — en faire une habitude ou une expérience concrète.
- **Connecter** — le relier à ce que tu sais déjà, ou écrire ta synthèse.
- **Transmettre** — l'expliquer à quelqu'un (la meilleure rétention qui existe).
- **Revoir** — le faire remonter plus tard, au bon moment.
- **Lâcher** — archiver / supprimer, comme une action valorisée et non un échec.

Faire de « lâcher » une sortie de premier plan est au cœur de la mission anti-éparpillement.

## Le flux de capture

**Promesse : aussi simple que partager. La capture ne demande *rien*.**

1. Tu partages un lien (ou une note brute) via le bouton Partager. Instantané ; la capture ne bloque jamais.
2. En arrière-plan : extraction du contenu (pour une vidéo : audio → texte), puis détection de la *forme* — idée ou processus — et fabrication du bon objet (neurone ou circuit).
3. L'app *propose* un cortex — elle a lu, elle est la mieux placée — et y range l'objet en « à confirmer ».
4. La confirmation n'est pas une corvée séparée : elle se fond dans la récolte.

*Caveat :* transcrire une vidéo peut prendre quelques minutes → l'app prévient quand l'objet est prêt, la capture reste immédiate.

## Le moteur : la récolte

C'est le cœur du produit, et ce qui nous sépare d'un read-later.

On ne traite pas un objet parce qu'il *vieillit* — ça recrée un backlog culpabilisant. On traite un cortex parce qu'il est **mûr**. Quand un thème atteint sa masse critique (~4-5 objets), l'app propose de récolter :

- **Cortex d'idées** → tu écris ta **synthèse** (« voilà ce que je retiens »). Reformuler avec tes mots, c'est *ça*, digérer.
- **Cortex de circuits** → **curation** (« tu as 5 recettes — lesquelles t'as testées ? on garde les gagnantes, on lâche le reste »). Le cortex devient un playbook.

La récolte étant le seul rituel, elle absorbe trois boulots d'un coup : confirmer le rangement, réfléchir, relier. Aucune inbox à traiter en plus.

### Trois tempos / déclencheurs
- **Chaud — à la capture.** Appliquer / Connecter tant que c'est frais (l'app peut montrer 1-2 neurones voisins à relier).
- **Tiède — à la récolte.** Un cortex mûrit → notification → synthèse ou curation.
- **Froid.** *Revoir* (résurgence espacée, uniquement pour les objets que *tu* as marqués) et *Lâcher* (un neurone ou cortex **stale**, endormi trop longtemps, que l'app propose de laisser filer).

Un neurone dont le cortex ne mûrit jamais finit stale, puis lâché : le système s'auto-purge.

## Onboarding

- « Qu'est-ce que tu veux améliorer ? Quels sont tes centres d'intérêt ? » → pose le fil rouge et les premiers cortex.
- Met en scène l'intention de focus : l'image avant / après (cerveau éparpillé → cerveau qui suit sa ligne).

## Périmètre

**MVP**
- Un objet par source (un neurone *ou* un circuit), une thématique générale par source.
- Les deux types dès le départ : neurone **et** circuit (les reels-process sont une grosse part des captures).
- Capture zéro-friction + pipeline d'extraction en arrière-plan.
- Cortex avec récolte (synthèse / curation), grammaire des sorties, mécanique de stale / lâcher.
- Priorité aux sources texte / article (extraction fiable) ; transcription vidéo ensuite.

**v2 et au-delà**
- Plusieurs neurones atomiques par source ; un circuit devient alors des step-neurones reliés en séquence.
- Synapses riches / graphe de connaissances.
- Éventuel passage de l'outil perso à un produit.

## Positionnement

Ni un read-later (Pocket est mort en 2025), ni un Obsidian de plus. Lucid Brain se concentre sur le contenu web et les notes personnelles, et met toute sa valeur *après* la capture : la digestion et l'action.

## Questions ouvertes (à trancher)

- **Stockage** : vrais fichiers Markdown + tags, local-first et ouvrables dans Obsidian, ou base de données classique ? (impacte toute l'architecture)
- **Niveau d'intérêt** : posé par toi ou déduit par l'app ? sert-il à prioriser la récolte / la résurgence ?
- **Seuil de maturité** d'un cortex : fixe (~5) ou configurable ?
- **Vocabulaire définitif** (neurone / synapse / circuit / cortex) — actuellement provisoire.
