# NVIDIA PyTorch Container für CUDA-optimierte Umgebung (RTX 4060 Ti, 16GB)
FROM nvcr.io/nvidia/pytorch:25.02-py3

LABEL maintainer="Boson AI Deployment Engineer"
LABEL description="Higgs Audio V2 (Boson AI) - Reproduzierbare, persistente ML-Installation für NVIDIA RTX 4060 Ti"

# Systempakete aktualisieren und essentielle Tools installieren
RUN apt-get update && \
    apt-get install -y git ffmpeg libsndfile1 && \
    rm -rf /var/lib/apt/lists/*

# Arbeitsverzeichnis setzen
WORKDIR /workspace

# Higgs Audio V2 Repository klonen
RUN git clone https://github.com/boson-ai/higgs-audio.git

# Python-Abhängigkeiten installieren
RUN pip install --upgrade pip && \
    pip install -r /workspace/higgs-audio/requirements.txt && \
    pip install -e /workspace/higgs-audio

# Optional: Umgebungsvariablen für CUDA und Torch optimieren (speziell für 16GB VRAM)
ENV CUDA_VISIBLE_DEVICES=0
ENV PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512

# Beispiel für persistente Datenablage (optional)
VOLUME ["/workspace/output"]

# Startbefehl (kann angepasst werden)
CMD ["/bin/bash"]

# Hinweise:
# - Das Image ist für GPU-Betrieb optimiert (CUDA, PyTorch, RTX 4060 Ti).
# - Für eigene Modelle/Checkpoints: Mount-Optionen oder COPY-Anweisungen ergänzen.
# - Für Produktion: Nutzer, Security und weitere Best Practices ergänzen.