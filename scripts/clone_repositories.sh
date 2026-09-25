#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="${ROOT}/third_party"
mkdir -p "$DEST"

clone() {
  local name="$1"
  local url="$2"
  if [ -d "${DEST}/${name}/.git" ]; then
    echo "Already cloned: ${name}"
  elif [ -e "${DEST}/${name}" ]; then
    echo "Skipping ${name}: destination exists but is not a git checkout" >&2
  else
    git clone --depth 1 "$url" "${DEST}/${name}"
  fi
done

# Core video production and model runners
clone OpenMontage https://github.com/calesthio/OpenMontage.git
clone MoneyPrinterTurbo https://github.com/harry0703/MoneyPrinterTurbo.git
clone LongCat-Video https://github.com/meituan-longcat/LongCat-Video.git
clone Wan2GP https://github.com/deepbeepmeep/Wan2GP.git
clone hyperframes https://github.com/heygen-com/hyperframes.git

# Agent orchestration, memory, and retrieval
clone nanobot https://github.com/HKUDS/nanobot.git
clone OpenViking https://github.com/volcengine/OpenViking.git
clone PageIndex https://github.com/VectifyAI/PageIndex.git
clone agentor https://github.com/CelestoAI/agentor.git
clone superpowers https://github.com/obra/superpowers.git

# Optional model/API and API-discovery resources
clone Open-Generative-AI https://github.com/Anil-matcha/Open-Generative-AI.git
clone public-apis https://github.com/public-apis/public-apis.git

echo
echo "Selected repositories are available under ${DEST}."
echo "Review each upstream README and license before installing or integrating."
