# Extraire la parole (speech-to-text) de vidéos multi-plateformes vers du texte/Markdown : les meilleures solutions open source (2025-2026)

## TL;DR
- **Le stack open source recommandé est un pipeline en deux maillons : yt-dlp pour extraire l'audio de n'importe quelle plateforme (YouTube, TikTok, Instagram/Facebook Reels…), puis un moteur Whisper optimisé (faster-whisper sur GPU, whisper.cpp sur CPU/Mac) pour la transcription.** Whisper large-v3 reste le meilleur choix polyvalent et le plus sûr à déployer en français (open source, licence MIT, 99 langues).
- **Pour un outil clé en main open source qui fait déjà les deux étapes**, `transcribe-anything` (CLI, prend une URL) et `Whishper` (interface web self-hosted, entrée URL via yt-dlp) sont les plus pratiques ; `Buzz` est la meilleure application de bureau graphique. Aucun ne produit du Markdown richement structuré nativement, mais tous exportent TXT/SRT/VTT trivialement convertibles.
- **Pour la sortie Markdown directe**, des projets dédiés existent (`AI-Video-Transcriber` qui exporte du Markdown natif, `youtube-playlist-to-markdown`, `yt-video-text-md`), mais ils sont surtout centrés YouTube ; pour le multi-plateforme complet, il faut combiner yt-dlp + Whisper avec un post-traitement Markdown simple.

## Key Findings

1. **yt-dlp est le maillon de téléchargement/extraction audio incontournable.** Il est open source, activement maintenu (mises à jour quasi quotidiennes). Selon la documentation technique du projet (yt-dlp DeepWiki, « Supported Sites and Extractors »), « As of version 2025.11.12, yt-dlp supports over 1800 websites through dedicated extractors », dont YouTube (vidéos, Shorts, playlists, lives), TikTok, Instagram (posts, Reels, stories), Facebook (vidéos, Reels, stories), Twitter/X, Vimeo, etc. Il fonctionne sur Windows, macOS et Linux et nécessite FFmpeg pour l'extraction/conversion audio.

2. **Whisper (OpenAI) et ses variantes dominent la transcription open source.** Le modèle de référence (poids ouverts, licence MIT, 99 langues) a des variantes optimisées : **faster-whisper** (le plus rapide sur GPU NVIDIA), **whisper.cpp** (C/C++, tourne sur CPU et Mac Apple Silicon, aucune dépendance Python), **WhisperX** (ajoute horodatage au mot et diarisation), **distil-whisper** (6× plus rapide, ~1 % de WER en plus, anglais surtout), et **insanely-fast-whisper** (débit maximal sur GPU haut de gamme).

3. **En français, Whisper large-v3 est excellent mais n'est plus le meilleur en WER pur.** Sur le benchmark FLEURS français, le WER de Whisper large-v3 est d'environ 5,55 % (mesuré dans le papier Voxtral) à 6,3 % (mesuré dans le papier NVIDIA). **Voxtral Small (Mistral AI, 24B, Apache 2.0)** atteint 4,03 % et **NVIDIA Parakeet-tdt-0.6b-v3** environ 5,2 % tout en étant beaucoup plus petit/rapide. Ces alternatives européennes récentes sont de sérieux concurrents pour le français.

4. **Plusieurs outils tout-en-un open source combinent déjà téléchargement + transcription.** Les plus notables : `transcribe-anything`, `Whishper`, `Buzz`, `Whisper-WebUI`, `AI-Video-Transcriber`, `yt-whisper`, `youtube-faster-whisper (ytws)`.

5. **La sortie Markdown structurée n'est pas standard mais facile à obtenir.** La plupart des outils exportent TXT/SRT/VTT/JSON ; quelques projets ciblent explicitement le Markdown, mais principalement pour YouTube (via sous-titres natifs).

## Details

### 1. Le pipeline complet (approche recommandée)

La tâche se décompose en deux étapes que l'on peut chaîner :

**Étape A — Extraire l'audio depuis la plateforme sociale : yt-dlp**

yt-dlp est le successeur communautaire de youtube-dl, créé début 2021. C'est l'outil de référence pour télécharger vidéo/audio. Commande type pour extraire l'audio en MP3 :

```
yt-dlp -x --audio-format mp3 "URL"
```

Points de vigilance multi-plateformes signalés par les intégrateurs :
- **TikTok** : nécessite souvent `--impersonate chrome-131` car TikTok bloque activement les requêtes non-navigateur.
- **Instagram** : peut exiger un en-tête `Referer: https://www.instagram.com/` (sinon 403) ou des cookies (`--cookies-from-browser chrome`) pour le contenu privé/limité.
- **Facebook** : Reels et vidéos supportés ; contenu privé nécessite cookies.
- yt-dlp ne contourne pas les DRM (Netflix, Disney+, Prime Video, etc.).

Alternatives à yt-dlp : **cobalt** (cobalt.tools, open source, interface web/self-hostable), et des front-ends graphiques comme **Stacher** ou **YTDLnis** (Android, GPL v3). Mais pour un pipeline, yt-dlp en CLI ou via sa bibliothèque Python reste le standard.

**Étape B — Transcrire l'audio : un moteur Whisper**

Exemple de chaînage minimal (Whisper CLI officiel) :

```
yt-dlp -x --audio-format wav -o "audio.wav" "URL" && whisper audio.wav --model large-v3 --language fr --output_format all
```

### 2. Les moteurs de transcription open source en détail

**OpenAI Whisper (original)** — Le modèle de référence. Encoder-decoder transformer entraîné sur 680 000 heures. Licence MIT, 99 langues. Tailles de tiny (39M) à large (1550M). Avantages : précision de référence, robuste au bruit, multilingue. Inconvénients : lent, gourmand en mémoire, hallucinations possibles sur les silences. Pas d'interface, s'utilise en CLI ou intégré en Python.

**faster-whisper (SYSTRAN)** — Réimplémentation via CTranslate2. Le README officiel du dépôt SYSTRAN/faster-whisper le décrit ainsi : « This implementation is up to 4 times faster than openai/whisper for the same accuracy while using less memory. The efficiency can be further improved with 8-bit quantization on both CPU and GPU. » C'est le meilleur choix par défaut pour les pipelines de production sur GPU NVIDIA. Version stable v1.2.1 (octobre 2025). Intègre le VAD Silero pour filtrer les silences.

**whisper.cpp (ggml-org / Georgi Gerganov)** — Port C/C++ pur, sans dépendance Python, format GGML avec quantification entière. Support matériel très large : Apple Silicon (NEON, Metal, Core ML via l'Apple Neural Engine, >3× plus rapide que le CPU seul), x86 AVX, CUDA, Vulkan, OpenVINO, WebAssembly. Le meilleur choix sans GPU NVIDIA ou sur Mac/edge/mobile. Version v1.8.6 (juin 2026), VAD natif ajouté.

**WhisperX (m-bain, Visual Geometry Group / Université d'Oxford)** — S'appuie sur faster-whisper puis ajoute l'alignement forcé (wav2vec2) pour des horodatages au mot précis (±50 ms) et la diarisation (qui parle quand) via pyannote.audio. Jusqu'à 70× temps réel sur RTX 4090. Le README indique explicitement : « Currently default models provided for {en, fr, de, es, it, ja, zh, nl, uk, pt} » — le français est donc pris en charge nativement pour l'alignement. Le dépôt m-bain/whisperX compte environ 22 800 étoiles et 2 300 forks (GitHub, mi-2026), maintenu par Max Bain. Idéal pour sous-titres, réunions, interviews. Nécessite un token Hugging Face pour la diarisation. Licence BSD-4-Clause.

**distil-whisper (Hugging Face)** — Modèle distillé, 6× plus rapide, ~50 % plus petit, dans la marge de 1 % de WER sur données hors distribution. Compatible faster-whisper (distil-large-v3). Surtout optimisé pour l'anglais.

**insanely-fast-whisper** — Wrapper CLI sur la pipeline Transformers de Hugging Face avec Flash Attention 2, débit maximal sur GPU NVIDIA récents (Ampere+ : RTX 3000+, A100, H100). 2,5 h d'audio en moins de 98 s revendiqué.

**Autres moteurs (hors galaxie Whisper) :**
- **NVIDIA NeMo / Parakeet / Canary** : Parakeet-tdt-0.6b-v3 (600M paramètres) — décrit dans Sekoyan et al., « Canary-1B-v2 & Parakeet-TDT-0.6B-v3 » (arXiv:2509.14128, soumis le 17 sept. 2025) comme offrant « multilingual ASR across the same 25 languages with just 600M parameters », entraîné sur « 1.7M hours of total data samples ». Détection automatique de langue et vitesse extrême (RTFx très élevé). Canary Qwen 2.5B est en tête du classement Open ASR anglais avec 5,63 % de WER. Excellents mais orientés GPU NVIDIA (CUDA).
- **Voxtral (Mistral AI)** : famille open source (Apache 2.0) décrite dans Liu et al., « Voxtral » (arXiv:2507.13264, soumis le 17 juillet 2025), en tailles 24B (Small) et 3B (Mini). Le papier affirme : « Voxtral Small achieves state-of-the-art transcription results on English Short-Form and MCV, beating all open and closed-source models. » Nativement multilingue (dont français), contexte 32k tokens (jusqu'à ~30-40 min d'audio), Q&A et résumé intégrés. Modèle européen, très pertinent pour le français. Nécessite du matériel conséquent (déploiement via vLLM).
- **Vosk** : moteur léger hors ligne basé sur Kaldi, CPU, temps réel, 20+ langues (dont français), modèles jusqu'à 50 Mo. Idéal edge/embarqué/téléphonie, mais moins précis que Whisper.
- **Coqui STT** (successeur de Mozilla DeepSpeech) : projet arrêté fin 2023/début 2024 — à éviter pour un nouveau projet. Mozilla DeepSpeech est archivé depuis novembre 2021.
- **Kaldi** : boîte à outils de recherche très puissante mais complexe ; pas pour la plupart des usages.
- **SpeechBrain**, **wav2vec2 (Hugging Face)** : toolkits/modèles pour usages sur mesure.
- **Moonshine (Useful Sensors)** : modèles très compacts (dès 27M paramètres) pour l'embarqué, surpassent Whisper tiny/small ; anglais surtout.
- **Whisperfile (Mozilla Ocho)** : Whisper packagé en exécutable unique (llamafile), très simple à déployer.

### 3. Comparaison de qualité en français (WER, plus bas = mieux)

Chiffres issus des papiers primaires (à comparer avec prudence entre papiers, car les protocoles de normalisation diffèrent) :

| Modèle | FLEURS-fr | Common Voice-fr | MLS-fr | Source |
|---|---|---|---|---|
| Whisper large-v3 | 5,55 (papier Voxtral) / 6,3 (papier NVIDIA) | 11,33 | 5,09 | arXiv:2507.13264 ; arXiv:2509.14128 |
| Voxtral Small (24B) | 4,03 | 6,18 | 3,73 | arXiv:2507.13264 |
| Voxtral Mini (3B) | 4,87 | 8,92 | 5,28 | arXiv:2507.13264 |
| Voxtral Mini Transcribe | 4,22 | 7,29 | 4,14 | arXiv:2507.13264 |
| Parakeet-tdt-0.6b-v3 | ~5,2 | — | — | arXiv:2509.14128 |

Classement FLEURS français (du meilleur au moins bon) : Voxtral Small (4,03) < Voxtral Mini Transcribe (4,22) < Voxtral Mini (4,87) < Parakeet-tdt-0.6b-v3 (~5,2) < Whisper large-v3 (5,55–6,3). Le classement Hugging Face Open ASR (piloté avec NVIDIA, Mistral AI et l'Université de Cambridge) couvre désormais le français via une piste multilingue (jeux FLEURS + CoVoST-2, cinq langues : allemand, français, italien, espagnol, portugais), mais ses chiffres de tête largement cités sont l'anglais uniquement.

### 4. Les outils tout-en-un / clé en main open source

**transcribe-anything (zackees)** — CLI multi-backend. Prend un fichier local OU une URL et transcrit. Backends : CPU Whisper, `insane` (insanely-fast-whisper), `insane-flash` (Flash Attention 2 avec wheels épinglées), `mlx` (Apple Silicon), WhisperX en add-on pour l'alignement/diarisation. Utilise yt-dlp en interne. Sortie JSON/SRT/VTT, diarisation avec labels SPEAKER_00, etc. Le plus proche du « colle une URL, obtiens le texte » en ligne de commande. Windows/Linux/macOS, installation simple (Mac-arm optimisé).

**Whishper (pluja)** — Suite web self-hosted 100 % locale. Transcrit depuis une URL (toute source yt-dlp) ou un fichier. Backend FasterWhisper. Éditeur de sous-titres intégré, traduction via LibreTranslate, export TXT/JSON/VTT/SRT (ou copie du texte brut). Déploiement Docker. Idéal pour une interface web privée, fonctionne même hors ligne.

**Buzz (chidiwilliams)** — Application de bureau (Windows/macOS/Linux via Flatpak/Snap). Transcrit et traduit hors ligne. Supporte Whisper, whisper.cpp, faster-whisper, modèles Hugging Face, et l'API OpenAI. Import fichiers audio/vidéo, export TXT/SRT/VTT. Support des téléchargements YouTube via cookiefile ajouté. Accélération Vulkan pour whisper.cpp (temps réel même sur laptop). CLI + dossier surveillé + système de plugins. La meilleure option graphique grand public.

**Whisper-WebUI** — Interface Gradio self-hosted, intègre faster-whisper, entrées fichier/YouTube/micro, VAD, séparation musique/voix, diarisation. Facile à lancer (y compris sur Google Colab).

**AI-Video-Transcriber (wendy7756)** — ~2 300 étoiles GitHub. Backend FastAPI + interface web. Prend une URL (YouTube, TikTok, Bilibili, et toute plateforme yt-dlp : Facebook, Instagram, Twitter…) ou un fichier. Architecture « subtitle-first » : extrait les sous-titres natifs quand ils existent, sinon bascule sur Faster-Whisper. **Exporte des fichiers formatés en Markdown (Transcript / Translation / Summary).** Résumé/traduction nécessitent une clé API compatible OpenAI. Le plus intéressant pour l'objectif « vidéo → Markdown » multi-plateforme, mais la partie résumé/traduction n'est pas 100 % locale.

**yt-whisper (m1guelpf)** — Petit package qui transcrit directement depuis une URL YouTube (`yt_whisper "URL" --model medium --language fr`). Simple, centré YouTube.

**youtube-faster-whisper / ytws (faker2048)** — Wrapper CLI combinant yt-dlp + faster-whisper (`ytws dt -u "URL" -m large-v3`). Génère des sous-titres, accélération GPU.

### 5. Sortie Markdown spécifiquement

Aucun des grands moteurs ne produit du Markdown structuré nativement (ils sortent TXT/SRT/VTT/JSON). Options :

- **AI-Video-Transcriber** : export Markdown natif (transcript/traduction/résumé), multi-plateforme via yt-dlp. Le plus direct pour l'objectif « vidéo → Markdown ».
- **youtube-playlist-to-markdown (BayramAnnakov)** : convertit playlists/vidéos YouTube en Markdown propre, sources multiples (sous-titres officiels, Whisper, yt-dlp), traitement par lot, formatage intelligent. Centré YouTube.
- **yt-video-text-md (kothiyarajesh)** : récupère les transcripts YouTube et les sauve en Markdown ; bascule sur téléchargement audio si pas de transcript. Centré YouTube.
- **yt-transcriber (pmarreck)** : CLI qui produit du texte pipeable vers un script `summarize --markdown` (avec `glow` pour l'affichage terminal).
- **Conversion manuelle simple** : Whisper sort du JSON avec segments/horodatages ; un court script (ou une regex sur le SRT) transforme cela en Markdown avec titres et horodatages. C'est trivial à ajouter en fin de pipeline, et c'est l'approche la plus flexible pour du multi-plateforme.

### 6. Considérations pratiques

**Facilité d'installation :**
- Le plus simple sans coder : **Buzz** (installateur bureau) ou **Whishper** (Docker).
- Pipeline CLI : `pip install yt-dlp openai-whisper` (+ FFmpeg) ou `transcribe-anything`.
- Sur Mac sans GPU : whisper.cpp (Metal/Core ML) ou backend `mlx` de transcribe-anything.

**Matériel :**
- GPU NVIDIA : faster-whisper / WhisperX / insanely-fast-whisper. large-v3 demande ~10 Go de VRAM.
- CPU / Mac / edge : whisper.cpp (quantifié), Vosk (temps réel léger).
- Sur CPU, préférez un modèle plus petit (small/medium) ou distil-whisper.

**Plateformes OS :** yt-dlp, Whisper et ses variantes fonctionnent sur Windows, macOS et Linux.

**Aspects légaux / conditions d'utilisation (à signaler sans juger) :**
- yt-dlp est un logiciel légal (comparable à un navigateur + parseur). Le risque juridique porte sur *ce que l'on télécharge*, pas sur l'outil lui-même.
- Les conditions d'utilisation de **YouTube**, **TikTok**, **Instagram** et **Facebook** interdisent généralement le téléchargement de contenu sans autorisation. Les CGU de TikTok stipulent explicitement que le contenu « may not be downloaded, copied, reproduced, distributed, transmitted… without our or, where applicable, our licensors' prior written consent ». La violation de CGU relève du contrat privé (risque : suspension de compte), pas du pénal.
- Le **droit d'auteur** est une couche distincte : télécharger du contenu protégé sans autorisation peut constituer une contrefaçon, quel que soit l'outil. Les usages plus sûrs : vos propres contenus, contenu sous licence Creative Commons, domaine public, ou usage relevant d'exceptions locales (fair use, fair dealing, exceptions de l'UE).
- **Ré-uploader** du contenu téléchargé est un risque supplémentaire (revendications de droits, retraits, sanctions de compte).

**Popularité / maintenance (2025-2026) :** yt-dlp, whisper.cpp, faster-whisper, WhisperX et Buzz sont tous très populaires et activement maintenus. WhisperX compte environ 22 800 étoiles GitHub. Coqui STT et Mozilla DeepSpeech sont abandonnés — à éviter pour un nouveau projet.

## Recommendations

**Étape 1 — Choisir selon votre profil :**

- **Vous voulez le plus simple, sans ligne de commande** → installez **Buzz** (bureau) ou déployez **Whishper** (Docker, interface web, entrée URL). Pour l'audio de plateformes sociales, Buzz gère YouTube ; pour TikTok/Instagram/Facebook, passez par Whishper (yt-dlp intégré) ou téléchargez d'abord avec yt-dlp puis importez.

- **Vous voulez un outil CLI « URL → texte » immédiat** → **transcribe-anything** (`transcribe-anything "URL" --device insane` sur GPU, ou `--device mlx` sur Mac). Il gère le téléchargement (yt-dlp) et la transcription.

- **Vous voulez la sortie Markdown la plus directe, multi-plateforme** → **AI-Video-Transcriber** (export Markdown natif, bascule Faster-Whisper). Pour du 100 % local sans clé API, désactivez le résumé/traduction et gardez la transcription.

- **Vous construisez votre propre pipeline** → **yt-dlp + faster-whisper** (GPU) ou **yt-dlp + whisper.cpp** (CPU/Mac), avec **WhisperX** si vous voulez horodatage au mot + diarisation. Ajoutez un petit script pour formater le JSON/SRT en Markdown (titres, horodatages, sections).

**Étape 2 — Choisir le modèle selon la langue et le matériel :**
- Français, qualité maximale, déploiement sans friction → **Whisper large-v3** via faster-whisper (excellent, MIT, éprouvé, écosystème d'outillage le plus mûr).
- Français, si vous pouvez évaluer des alternatives → testez **Voxtral** (Mistral, Apache 2.0) ou **Parakeet-tdt-0.6b-v3** (NVIDIA) : meilleurs WER français sur FLEURS et plus rapides, mais outillage clé en main moins mature que Whisper.
- Sans GPU → whisper.cpp avec modèle quantifié (medium ou large-v3-q5).

**Étape 3 — Seuils qui changeraient la reco :**
- Si le volume est important (heures d'audio/jour) → passez à faster-whisper batché ou insanely-fast-whisper sur GPU.
- Si vous avez besoin de « qui parle quand » (interviews, réunions) → WhisperX (diarisation).
- Si latence temps réel / edge → Vosk ou whisper.cpp en mode streaming ; ou Voxtral Mini Realtime pour du multilingue temps réel (<500 ms).

## Caveats

- **Chiffres de WER français** : les valeurs proviennent de papiers différents (Voxtral arXiv:2507.13264, NVIDIA arXiv:2509.14128) avec des protocoles de normalisation distincts ; les comparaisons inter-papiers sont indicatives, pas exactes. Whisper large-v3 sert de baseline commune dans les deux.
- **Voxtral et Parakeet** surpassent Whisper sur certains benchmarks, mais leur intégration dans les outils clé en main est moins mature : pour un déploiement immédiat sans friction, Whisper via faster-whisper reste le pari le plus sûr en 2025-2026.
- **Hallucinations** : Whisper peut halluciner du texte sur les silences. Selon Koenecke, Choi, Mei, Schellmann & Sloane, « Careless Whisper: Speech-to-Text Hallucination Harms » (arXiv:2402.08021, ACM FAccT 2024), « roughly 1% of audio transcriptions contained entire hallucinated phrases or sentences which did not exist in any form in the underlying audio », dont 38 % incluaient des contenus explicitement problématiques (violence, etc.). Activer le VAD réduit fortement ce risque.
- **Markdown** : aucun moteur ne produit un Markdown richement structuré nativement ; prévoyez un petit post-traitement, sauf si vous utilisez AI-Video-Transcriber ou un projet YouTube-Markdown dédié.
- **Légal** : télécharger depuis Instagram/Facebook/TikTok/YouTube peut enfreindre leurs CGU et, selon le contenu, le droit d'auteur. Cette note est informative et ne constitue pas un conseil juridique.
- **Fraîcheur des extracteurs** : les extracteurs yt-dlp cassent régulièrement quand les plateformes changent leur structure (surtout TikTok, Instagram) ; gardez yt-dlp à jour (`yt-dlp -U`, voire la build nightly).