# Team roster — Lucid Brain

> **Statut :** v1 validée, gate ② (bootstrap du 3 juillet 2026). Source des rôles : `catalog/`. Définitions spécialisées : `.claude/agents/`.

## Directors actifs

- **dev-director** · délivre l'app iOS et le backend d'extraction ; découpe le MVP ~1 mois en stories INVEST vérifiables — critique car le maintainer ne code pas : chaque story doit être testée et démontrable.
- **design-director** · le « lead design » exigé par le maintainer : fixe la direction (coach lucide, natif iOS) et vérifie que designs ET code livrent du vrai natif — garant de l'onboarding avant/après et du test anti-AI-slop.

## Specialists actifs (par director)

**dev-director →**
- **ios-app** (SwiftUI n°1) · les écrans et les flux : récolte, grammaire des sorties, onboarding fil rouge, cortex. Le cœur d'expérience.
- **ios-core** (SwiftUI n°2) · les fondations : modèle SwiftData (source de vérité), share extension (capture zéro-friction), client API backend, export Markdown.
- **extraction-engine** (backend) · le serveur perso stateless : extraction d'article → LLM propositionizer → neurone/circuit + cortex proposé ; architecture prête pour la vidéo (v1.1).
- **qa** · dérive des tests des critères d'acceptation et de la finalité ; indispensable : sans dev humain, la QA est le premier rempart contre « ça a l'air fini ».
- **code-reviewer** · garde correctness + simplicité sur chaque diff ; second rempart, imposé par les contraintes de VISION.md.

**design-director →**
- **ui-ux** · exécute la craft : hiérarchie, rythme, motion, accessibilité — et l'UX copy dans le ton figé (tutoiement, « lâcher se célèbre »).

## Exclus délibérément

- **marketing-director** · outil personnel d'abord : aucun go-to-market au MVP. Réactivable via `/specialize` si Lucid Brain devient un produit (v2+).
- **copywriter** · le ton et le vocabulaire sont figés dans VISION.md ; design-director et ui-ux portent l'UX copy. Un rôle dédié serait de la cérémonie pour un outil mono-utilisateur.

> Équipe : 1 DG + 2 directors + 6 specialists. Chaque rôle a une raison d'exister rattachée à la finalité ; rien de plus (KISS).
