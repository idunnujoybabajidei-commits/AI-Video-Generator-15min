# AI Video Generator — Long Form

A curated workspace for building automated videos up to 15 minutes by composing short generated shots/scenes, narration, assets, and FFmpeg rendering.

> This repository contains a reproducible cloning manifest and integration plan. The source projects remain separate repositories; their licenses and model terms must be reviewed before redistribution.

## Recommended stack

### Core production
- **OpenMontage** — agentic video-production workflows and production skills.
- **MoneyPrinterTurbo** — reference implementation for script, media, voice, subtitles, and FFmpeg assembly.
- **LongCat-Video** — video-generation model to evaluate for longer temporal continuity.
- **Wan2GP** — GPU-efficient model runner supporting several video models.
- **hyperframes** — deterministic HTML/TypeScript scene rendering.

### Orchestration and continuity
- **nanobot** — lightweight Python agent/MCP orchestration.
- **OpenViking** — agent memory, skills, and retrieval context.
- **PageIndex** ��� reasoning-oriented document retrieval for scripts and references.
- **agentor** — alternative agent/MCP deployment framework.
- **superpowers** — alternative agent skill/development methodology.

### Optional integrations
- **Open-Generative-AI** — model/API studio and asset-generation integrations.
- **OpenMontage** — alternative/full production layer; use it as the main production reference rather than duplicating every component.
- **public-apis** — discovery catalog only; it is not a video-generation dependency.

## Clone everything selected

```bash
chmod +x scripts/clone_repositories.sh
./scripts/clone_repositories.sh
```

The script clones into `third_party/` and records the upstream URL. It does not modify upstream projects.

## Deliberately excluded

- `hexstrike-ai`: security testing, not video production.
- `ECC`: unrelated to the production pipeline unless you specifically need cryptography.

## Important architecture note

Do not expect a single inference to produce a complete 15-minute video. Use a shot/scene pipeline:

1. Generate and lock a script and shot list.
2. Store characters, style, locations, and prior-scene summaries in the context layer.
3. Generate short clips or deterministic HTML scenes in parallel.
4. Generate narration, music, captions, and sound effects.
5. Validate duration, codecs, audio sync, and continuity.
6. Assemble and encode the final MP4 with FFmpeg.

A practical first milestone is a 60–90 second video, followed by a 5-minute render, before targeting 15 minutes.

## License warning

This workspace does not relicense upstream code. Check each repository's license, model-weight license, API terms, and third-party media terms before commercial use. In particular, review OpenMontage's AGPL-3.0 terms and Wan2GP's `Other` license carefully.
