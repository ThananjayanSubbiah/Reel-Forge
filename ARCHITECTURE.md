# Architecture

Next.js App Router renders a metadata/layout shell and an interactive client studio. TypeScript models drafts. Tailwind CSS 4 is installed through PostCSS; custom CSS defines the studio design system and responsive layouts. Lucide provides icons. No remote font or image is required.

React state holds the script, voice preference, caption preference, and selected draft. User-triggered saves persist to browser localStorage under `reelforge-drafts-v1`; stored values are checked before use. Storage errors are reported. Draft switching and destructive operations request confirmation when needed.

The existing layout and draft components now integrate through `app/use-video-engine.ts` and a same-origin Next.js rewrite to FastAPI on 127.0.0.1:8000. No stock credentials are passed to the client. The backend reads them from root `.env` through secret-aware settings.

POST /api/jobs validates the script and submits to one local worker. Atomic JSON records preserve scripts, stages, results, and errors; interrupted jobs become failed on restart. The pipeline uses conservative scene planning, Pexels search and HD downloads, CPU Kokoro narration, PocketSphinx forced alignment against final audio, ASS animated captions, and FFmpeg crop/cut/mix/encode. FFprobe metadata checks and full-file decode gate the finished file. FileResponse supports byte-range playback and attachment downloads only for completed jobs. Publishing metadata is derived deterministically from script and source credits.

Search responses and downloaded footage are cached locally. Model weights, media, jobs, and logs are ignored by Git. The Windows launcher validates setup, checks port ownership through health identity, starts hidden local processes, waits for readiness, and avoids terminating unrelated existing processes. See backend/ENGINE.md for limits and model licensing.
