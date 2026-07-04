# Product backlog — Lucid Brain

> Priorisé de haut en bas. Propriété du DG (fonction Product Owner). Seedé au bootstrap (3 juillet 2026) depuis `VISION.md` ; raffiné à chaque `/sprint-plan`. QA et code-review ne sont pas des items : ils font partie de la DoD de chaque story.

| # | Item | Priorité | Statut | Notes |
|---|------|----------|--------|-------|
| 1 | Fondations : projet Xcode SwiftUI + modèle SwiftData (`Neurone`, `Circuit`, `Cortex`, `Synapse`, `FilRouge`, états, seuil de maturité ~5) + tests | P1 | à faire | ios-core · préalable à tout |
| 2 | Capture zéro-friction : share extension (URL / note brute), enregistrement local instantané, file d'attente offline | P1 | à faire | ios-core · la promesse d'entrée — ne bloque jamais, ne demande rien |
| 3 | Backend extraction v0 : API stateless, extraction article, propositionizer LLM → neurone/circuit + cortex proposé + sortie proposée | P1 | à faire | extraction-engine · fixtures réelles ; architecture prête pour la vidéo v1.1 |
| 4 | Direction design : registre produit, ton coach lucide, moments signature (onboarding avant/après, récolte, célébration du lâcher) | P1 | à faire | design-director · gate les écrans |
| 5 | Écrans cortex & objets : liste/détail cortex (question + jauge de maturité), fiche neurone/circuit, état « à confirmer » | P2 | à faire | ios-app + ui-ux |
| 6 | Rituel de récolte : maturité ~5 → notification → synthèse (cortex d'idées) / curation (cortex de circuits), confirmation du rangement fondue dedans | P2 | à faire | ios-app · **LE cœur produit — la finalité se joue ici** |
| 7 | Grammaire des sorties : une sortie proposée par objet (Appliquer / Connecter / Transmettre / Revoir / Lâcher), validable ou corrigeable d'un tap | P2 | à faire | ios-app + extraction-engine |
| 8 | Onboarding fil rouge : « qu'est-ce que tu veux améliorer ? » + image avant/après + création des premiers cortex | P2 | à faire | ios-app + ui-ux |
| 9 | Endormi → lâcher : auto-purge sur horodatages, flux de lâcher célébré | P3 | à faire | ios-app + ios-core |
| 10 | Export Markdown compatible Obsidian (frontmatter + liens `[[...]]`) | P3 | à faire | ios-core · portabilité des données |
| 11 | Transcription vidéo : captions natives d'abord, yt-dlp + faster-whisper en fallback | v1.1 | gelé | extraction-engine · hors MVP — après la gate ③ du MVP |
