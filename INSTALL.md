# Installation & Setup Guide

## Quick Start

### 1. Clone the main repository

```bash
git clone https://github.com/idunnujoybabajidei-commits/AI-Video-Generator-15min.git
cd AI-Video-Generator-15min
```

### 2. Clone all selected repositories

```bash
chmod +x scripts/clone_repositories.sh
./scripts/clone_repositories.sh
```

This clones 12 repositories into `third_party/` with shallow clones (`--depth 1`) to save space.

### 3. Verify the installation

```bash
ls -la third_party/
```

You should see:
- `OpenMontage/`
- `MoneyPrinterTurbo/`
- `LongCat-Video/`
- `Wan2GP/`
- `hyperframes/`
- `nanobot/`
- `OpenViking/`
- `PageIndex/`
- `agentor/`
- `superpowers/`
- `Open-Generative-AI/`
- `public-apis/`

---

## Project Breakdown & Setup by Component

### Core Video Production

#### 1. **OpenMontage** (Main production orchestrator)

**What it does:** Agentic video production system with 12 production pipelines and 700+ agent skills.

```bash
cd third_party/OpenMontage
pip install -r requirements.txt
python -m openmontage --help
```

**Key files:**
- `openmontage/pipelines/` — 12 production workflows
- `openmontage/skills/` — agent skills and production knowledge
- `openmontage/core/` — agent orchestration

**Usage:**
```python
from openmontage.core import VideoProducer
producer = VideoProducer()
# See OpenMontage README for full workflow examples
```

---

#### 2. **MoneyPrinterTurbo** (Reference implementation)

**What it does:** Proven pipeline: LLM script → TTS voiceover → Video generation → FFmpeg assembly.

```bash
cd third_party/MoneyPrinterTurbo
pip install -r requirements.txt
python main.py --topic "your topic here" --duration 60
```

**Key files:**
- `main.py` — entry point
- `utils/llm.py` — script generation with LLMs
- `utils/tts.py` — text-to-speech integration
- `utils/video_generator.py` — video model integration
- `utils/ffmpeg.py` — video assembly and encoding

**Study this for:**
- FFmpeg command patterns
- LLM prompting for video scripts
- Subtitle generation
- Voiceover synchronization

---

#### 3. **LongCat-Video** (Long-form video specialization)

**What it does:** Optimized for generating longer videos with temporal continuity.

```bash
cd third_party/LongCat-Video
pip install -r requirements.txt
python inference.py --config config/default.yaml
```

**Key study points:**
- How it breaks 15-minute videos into manageable segments
- Scene-to-scene context passing
- Frame continuity mechanisms
- Model checkpointing for long generation

---

#### 4. **Wan2GP** (Multi-model video generator)

**What it does:** Fast, GPU-efficient video generation supporting Wan 2.1/2.2, LTX-2, Hunyuan, Flux.

```bash
cd third_party/Wan2GP
pip install -r requirements.txt
python run.py --model wan2.1 --prompt "video description" --output video.mp4
```

**Supported models:**
- Wan 2.1 / 2.2
- LTX-2
- Hunyuan Video
- Flux video

**Use this for:** Model flexibility and GPU-poor environments.

---

#### 5. **hyperframes** (HTML-to-video rendering)

**What it does:** Render scenes from HTML/TypeScript/CSS into video frames.

```bash
cd third_party/hyperframes
npm install
npm run build
node ./cli.js render --input scene.html --output scene.mp4
```

**Key files:**
- `src/renderer/` — Puppeteer-based HTML rendering
- `src/ffmpeg/` — FFmpeg integration
- `examples/` — scene templates

**Use this for:** Deterministic, reproducible scene generation from templates.

---

### Orchestration & Memory

#### 6. **nanobot** (Agent orchestration framework)

**What it does:** Lightweight Python agent framework with MCP support, WebUI, and multi-agent workflows.

```bash
cd third_party/nanobot
pip install -r requirements.txt
python -m nanobot.server --port 8000
# Access WebUI at http://localhost:8000
```

**Use this for:** Orchestrating parallel tasks (script generation, image generation, video generation, assembly).

---

#### 7. **OpenViking** (Memory & context layer)

**What it does:** Self-evolving context database for agent memory, RAG, and skills.

```bash
cd third_party/OpenViking
pip install -r requirements.txt
python -c "from openviking import ContextDB; db = ContextDB(); print('Ready')"
```

**Critical for 15-min videos:**
- Store scene summaries
- Track character consistency
- Maintain narrative thread
- Preserve visual style references

**Usage:**
```python
from openviking import ContextDB
db = ContextDB()
db.store_scene_context(scene_id=1, context={"characters": [...], "setting": "..." })
scene_2_context = db.retrieve_context(scene_id=2, look_back=1)
```

---

#### 8. **PageIndex** (Document retrieval)

**What it does:** Reasoning-oriented document indexing and retrieval for scripts and references.

```bash
cd third_party/PageIndex
pip install -r requirements.txt
python -c "from pageindex import Indexer; idx = Indexer(); print('Ready')"
```

**Use this for:** Retrieving script sections, visual references, and production templates.

---

### Alternative Orchestration & Deployment

#### 9. **agentor** (Alternative agent framework)

**What it does:** Open-source Claude Managed Agents. Fast agent & MCP tool deployment.

```bash
cd third_party/agentor
pip install -r requirements.txt
python -m agentor deploy --config config.yaml
```

**Use instead of nanobot if:** You prefer Claude API integration or lighter overhead.

---

#### 10. **superpowers** (Skill-based framework)

**What it does:** Agentic skills framework for composable development and workflows.

```bash
cd third_party/superpowers
# Review README for integration patterns
```

**Use this for:** Organizing video generation as composable, reusable agent skills.

---

### Asset & Model Hub

#### 11. **Open-Generative-AI** (Optional model hub)

**What it does:** Studio with 600+ generative models, no content filters, MIT licensed.

```bash
cd third_party/Open-Generative-AI
npm install
npm run dev
```

**Use for:**
- Image generation (Flux, Midjourney, etc.)
- Image-to-video conversion
- Fallback models when primary generation fails

---

#### 12. **public-apis** (API discovery - reference only)

**What it does:** Catalog of free public APIs.

```bash
cd third_party/public-apis
cat README.md  # Browse the API catalog
```

**Use for discovering:**
- Free TTS APIs (ElevenLabs, Google Cloud)
- Music generation APIs (Riffusion)
- Stock footage/image APIs (Unsplash, Pexels)
- Video hosting APIs (YouTube, Vimeo)

---

## Integrated Setup Example

Here's a minimal Python orchestration to tie components together:

```python
# orchestrator.py
import sys
sys.path.insert(0, 'third_party/nanobot')
sys.path.insert(0, 'third_party/OpenViking')
sys.path.insert(0, 'third_party/PageIndex')

from nanobot.agent import Agent
from openviking import ContextDB
from pageindex import Indexer

# Initialize components
memory_db = ContextDB()
script_index = Indexer()
agent = Agent(memory=memory_db, retriever=script_index)

# Define workflow
def generate_video_15min(topic):
    # Step 1: Generate script (with context)
    script = agent.generate_script(topic)
    memory_db.store("script", script)
    
    # Step 2: Break into scenes
    scenes = agent.break_into_scenes(script)
    for i, scene in enumerate(scenes):
        memory_db.store_scene_context(i, {"script": scene, "sequence": i})
    
    # Step 3: Generate video for each scene
    # (Use Wan2GP, hyperframes, or Open-Generative-AI)
    scene_videos = []
    for i, scene in enumerate(scenes):
        context = memory_db.retrieve_context(i, look_back=1)
        video = agent.generate_scene_video(scene, context)
        scene_videos.append(video)
    
    # Step 4: Assemble (use FFmpeg patterns from MoneyPrinterTurbo)
    final_video = agent.assemble_video(scene_videos)
    return final_video

if __name__ == "__main__":
    video = generate_video_15min("How AI is changing the world")
    print(f"Video saved: {video}")
```

---

## Dependency Installation (All at once)

To install all dependencies:

```bash
# Python dependencies
for dir in third_party/OpenMontage third_party/MoneyPrinterTurbo third_party/LongCat-Video third_party/Wan2GP third_party/nanobot third_party/OpenViking third_party/PageIndex third_party/agentor third_party/Open-Generative-AI; do
  if [ -f "$dir/requirements.txt" ]; then
    echo "Installing $dir..."
    pip install -r "$dir/requirements.txt"
  fi
done

# Node.js dependencies (for hyperframes and Open-Generative-AI)
for dir in third_party/hyperframes third_party/Open-Generative-AI; do
  if [ -f "$dir/package.json" ]; then
    echo "Installing $dir..."
    cd "$dir"
    npm install
    cd ../..
  fi
done
```

---

## System Requirements

### Minimum (for testing)
- Python 3.8+
- Node.js 16+ (for hyperframes)
- 8 GB RAM
- 50 GB disk space (cloned repos + models)

### Recommended (for 15-min video production)
- Python 3.10+
- Node.js 18+
- 16+ GB RAM
- **GPU: NVIDIA RTX 3090 or better** (for video generation)
- 200+ GB disk space (models + output cache)

### GPU/CUDA Setup

For optimal video generation:

```bash
# Install CUDA (if not already installed)
cuda --version

# Install cuDNN
# https://developer.nvidia.com/cudnn

# Install torch with CUDA support
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Verify GPU detection
python -c "import torch; print(torch.cuda.is_available())"
```

---

## Next Steps

1. **Start with MoneyPrinterTurbo:** Understand the baseline pipeline.
2. **Add nanobot orchestration:** Deploy agents to handle parallel tasks.
3. **Integrate OpenViking:** Build scene-to-scene memory.
4. **Use hyperframes for scenes:** Render deterministic HTML scenes.
5. **Choose video model:** Start with Wan2GP for flexibility.
6. **Assemble with FFmpeg:** Reference MoneyPrinterTurbo's patterns.
7. **Test with 60-90 seconds:** Before targeting 15 minutes.

---

## Troubleshooting

### Clone failed
```bash
# Check internet connection
ping github.com

# Retry cloning
./scripts/clone_repositories.sh
```

### Missing dependencies
```bash
# Activate a fresh venv
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows

# Reinstall
pip install --upgrade pip
pip install -r third_party/MoneyPrinterTurbo/requirements.txt
```

### GPU not detected
```bash
python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}'); print(f'GPU: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else \"None\"}')"
```

### Out of memory during video generation
- Reduce scene length from 60 sec to 30 sec
- Use `Wan2GP` with `--low-vram` flag
- Enable CPU offloading in model config

---

## Documentation Links

- [OpenMontage README](https://github.com/calesthio/OpenMontage#readme)
- [MoneyPrinterTurbo README](https://github.com/harry0703/MoneyPrinterTurbo#readme)
- [LongCat-Video README](https://github.com/meituan-longcat/LongCat-Video#readme)
- [Wan2GP README](https://github.com/deepbeepmeep/Wan2GP#readme)
- [hyperframes README](https://github.com/heygen-com/hyperframes#readme)
- [nanobot Wiki](https://nanobot.wiki)
- [OpenViking Docs](https://openviking.ai/)
- [PageIndex Docs](https://pageindex.ai)

