# ReelForge Studio

A responsive dark video studio with a Next.js/TypeScript frontend and a local FastAPI, Kokoro, PocketSphinx, Pexels, and FFmpeg generation engine.

ReelForge orchestrates existing models and video tools; it does not train foundation models.
The existing dark interface and drafts are preserved. The authoritative project is on D:.
See [current verification evidence](docs/VERIFICATION.md), [complete setup](docs/SETUP.md),
[portfolio walkthrough](docs/PORTFOLIO.md), and [safe GitHub publishing](docs/GITHUB_PUBLISHING.md).
Historical audit notes describe earlier stages and are not current readiness evidence.

## Generation modes

| Mode | What it actually produces | Dependencies |
|---|---|---|
| Classic | Real stock footage, local voice and captions; 30 seconds | Pexels key, Kokoro, FFmpeg |
| Director / stock only | Semantic metadata ranking of stock footage | Ollama + Pexels |
| Director / AI-generated images with motion | Stable Diffusion still images, animated by FFmpeg | Ollama + local ComfyUI |
| Director / diagrams | LLM-planned programmatic graphics; factual review required | Ollama + Pillow |
| Reviewed airplane example | Explicit source-reviewed schematic preset | Kokoro + FFmpeg; no stock or image model |
| Hybrid | Preferred and alternative sources from the scene plan | Services required by selected sources |

Strict image and stock modes never silently substitute another source. There is no
verified native AI video model. Animated still images are not native text-to-video.
The original AI-planned airplane export failed editorial review and is not the demo.

## First video

1. Double-click `START_REELFORGE.bat`; open **http://127.0.0.1:3000/**.
2. Select AI Director and a visual source. For the reviewed example, select
   **Reviewed airplane example**, then **Load reviewed airplane script**.
3. For your own topic, select Topic, enter it in the editor and click **Draft script
   for review**. Wait for the local model, edit its script, and check factual claims.
4. Choose voice, style, duration and resolution. Select Highlight captions.
5. Click Generate. Progress reports actual stages. Scene previews appear as encoded.
6. Play and review the result, then Download MP4. Completed projects reopen from
   Recent projects. Browser drafts and server render history are stored separately.

Background music is optional: set `MUSIC_PATH` to a licensed local track and enable
the checkbox. The mix reduces music under narration; no music is bundled or downloaded.

## Run locally

For the complete studio, follow [backend setup](backend/README.md), then double-click `START_REELFORGE.bat`. Open http://127.0.0.1:3000. The launcher starts both loopback-only services and reuses healthy existing instances. Backend logs are in `backend/logs/`.

To run only the frontend during development:

Requires Node.js 20.9 or newer and npm.

```sh
npm install
npm run dev -- --port 3000
```

Open http://127.0.0.1:3000. To verify a production build, run `npm run build`. Run `npm run typecheck` for TypeScript validation.

## Current scope

Script editing, word count, estimated narration duration, voice selection, and browser-local drafts remain intact. Clearing browser site data removes those drafts. Render jobs and completed videos are separately persisted under `backend/data/jobs/` on this machine.

Generate submits a real background job when setup is ready. The job selects relevant HD Pexels clips, synthesizes local narration, aligns captions to the audio, edits vertical footage, and validates the finished export. Only validated results unlock the real video player and MP4 download. The idle illustration remains explicitly labeled as a style sample. Highlight is the implemented animated export style; other caption styles are still visual previews. Local publishing suggestions and Pexels credits are available with each completed job.

Classic supports English scripts of 45–95 words; Director scales the allowed length
with the selected duration (15–90 seconds). Measured narration must fit within a
bounded tempo adjustment. Unsupported words or unsuitable timing cause an explicit
error, never silent script truncation. PocketSphinx alignment is approximate and
requires review. Only Highlight captions are exported; other styles are previews.

Stock relevance uses metadata, not visual inspection. No multimodal validator is
configured. LLM diagrams and generated imagery can contain errors; technical claims
need trusted references and human review. See [current limitations](docs/VERIFICATION.md).

## Architecture

Next.js client → loopback FastAPI → durable single-worker render queue → structured
scene plan → Kokoro narration → forced word alignment → selected visual providers →
FFmpeg framing / motion / captions / audio → FFprobe plus complete decode → MP4.
Topic drafting uses a separate background task so slow model startup cannot exhaust
the browser proxy timeout. Scene/audio checkpoints permit Director retries. Cancellation
is cooperative at processing boundaries, not immediate termination of a model call.

`backend/data` holds jobs, models and caches; `.env` holds server-side configuration.
Both are ignored. Render history survives browser reloads. Drafts remain in browser
local storage; clearing site data removes those drafts. One backend process is supported.

## Verification and publication

```powershell
backend\.venv\Scripts\python.exe -m pytest backend/tests -q
npm run typecheck
npm run build
backend\.venv\Scripts\python.exe -m backend.publication_check
```

The publication audit reports redacted findings and does not stage, commit or push.
Choose destination and visibility before publishing. See [Desktop instructions](docs/GITHUB_PUBLISHING.md).

## Licensing

Review upstream licenses before distributing models or assets. Kokoro's model card
lists Apache-2.0; Stable Diffusion 1.5 uses CreativeML Open RAIL-M with use restrictions.
Pexels footage remains subject to its own license, including restrictions on endorsement
and redistribution. Music must be owned or licensed by you. Generated images can still
raise rights issues; no blanket rights guarantee is made. Models are not included in Git.
Sources: [Kokoro](https://huggingface.co/hexgrad/Kokoro-82M),
[SD 1.5 archive](https://huggingface.co/Comfy-Org/stable-diffusion-v1-5-archive),
[Pexels license](https://www.pexels.com/license/).

## Files

- `app/page.tsx`: studio and local draft interactions
- `app/globals.css`: Tailwind import and responsive styling
- `ARCHITECTURE.md`: frontend architecture
- `PROGRESS.md`: implementation status
- `backend/app/`: real generation engine and API
- `backend/sample.py`: full API-to-download sample verification
- `START_REELFORGE.bat`: Windows launcher
