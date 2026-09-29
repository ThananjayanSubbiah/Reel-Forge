Current verification is in docs/VERIFICATION.md. This file records historical milestones; earlier blockers and test counts may be superseded.

# Progress

## Current status — real pipeline verified

- Continued the existing project; preserved its visual design, script editor, voice/caption controls, and browser-local draft storage.
- Implemented Next.js-to-FastAPI integration, persisted background jobs, actual stage reporting/errors, conservative Pexels HD retrieval with credits/caching, local Kokoro narration, PocketSphinx word alignment, animated Highlight captions, FFmpeg vertical editing, guarded preview/download, local publishing metadata, and START_REELFORGE.bat.
- Installed the speech/alignment dependencies and public model files. Pexels authenticated successfully without exposing its key. Configured the user-provided WinGet paths for FFmpeg/FFprobe.
- Final completed job: `0178a23f-fc37-4a6b-8603-8cd3b0fdd8cc`. Final sample: `backend/data/sample/reelforge-sample.mp4`. Machine-readable validation: `backend/data/sample/report.json`.
- FFprobe result: **1080 × 1920**, **30.000 seconds**, **30.000 FPS**, **H.264**, **AAC audio present at 48 kHz**. Full-file FFmpeg decode also passed, including the separately downloaded MP4.
- Sample uses five distinct real Pexels clips and all 70 script words. Visual review identified and corrected an eye-level/aerial mismatch. An audio-normalization timestamp regression was fixed and covered by an actual FFmpeg test. Earlier attempts remain in history as failed/superseded, not successful exports.
- Validation: **23 backend tests passed** (one upstream Starlette/httpx deprecation warning); production Next.js build and TypeScript checks passed. Launcher cold start and reuse checks passed. Browser preview, playback, draft saving, and the actual MP4 download button were verified in Chrome. HTTP byte-range playback returned 206; publishing JSON returned a download attachment. Credentials were confirmed absent from client JavaScript and application source files.
- The Codex embedded browser crashed when starting H.264 playback; Chrome decoded and played the same video successfully with no media error. Use Chrome for this local studio.
- Current limits: English narration and dictionary-supported words; one export caption style; metadata-based footage matching; center crops; no background music or Pixabay fallback. Publishing suggestions are deterministic local text, not a separate language-model service. See backend/ENGINE.md.

## Earlier milestones

- Implemented responsive studio frontend, script editor, voice and caption preferences, 9:16 illustrative preview, and browser-local project history.
- Generation and MP4 download are clearly marked unavailable and disabled.
- Phase 1 deferred the backend. Phase 2 is now authorized and has reached the credential checkpoint described below.
- Validation: dependencies installed successfully (npm reported zero vulnerabilities); production build passed, including TypeScript validation and static page generation.
- Browser verification: page loaded successfully; example script reported 44 words and an estimated 18 seconds; caption selection updated the sample; a saved draft survived a reload and reopened with its script and caption preference. Generate and download controls were confirmed disabled. Layout was visually inspected in the in-app browser.
- Development server: http://127.0.0.1:3000 (start again with `npm run dev -- --port 3000`).

## Phase 2: setup milestone

- Preserved the existing frontend and browser-local draft implementation without changes.
- Added FastAPI health and setup-check endpoints, backend-only secret settings, root `.env.example`, an ignored blank local `.env`, and setup tests.
- Python 3.13 is installed. FFmpeg and FFprobe were not found on PATH. Pexels credentials are not configured.
- Installed backend dependencies into `backend/.venv`. All 7 setup tests passed (one upstream Starlette/httpx deprecation warning). The preflight command correctly reported missing credentials and video tools. Git ignore checks confirmed `.env` and the virtual environment are excluded.
- Paused at the user-requested credential checkpoint. The pipeline, launcher, frontend generation integration, and real MP4/FFprobe validation remain outstanding. No video has been generated.
