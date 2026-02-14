FROM lscr.io/linuxserver/code-server:4.109.2

USER root

# ----------------------------
# System Dependencies
# ----------------------------
RUN apt-get update && apt-get install -y \
    bash \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    pipx \
    git \
    curl \
    wget \
    unzip \
    zip \
    openssh-client \
    ca-certificates \
    jq \
    ripgrep \
    fd-find \
    tree \
    htop \
    docker.io \
    make \
    cmake \
    pkg-config \
    zsh \
    tmux \
    neovim \
    && rm -rf /var/lib/apt/lists/*

# Make fd available as `fd`
RUN ln -s $(which fdfind) /usr/local/bin/fd

# Ensure python alias exists
RUN ln -sf /usr/bin/python3 /usr/bin/python

# ----------------------------
# Install Node LTS (container-friendly way)
# ----------------------------
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install global node tooling
RUN npm install -g \
    pnpm \
    yarn \
    typescript \
    ts-node \
    eslint \
    prettier \
    nodemon \
    serve \
    turbo \
    vite

# ----------------------------
# Python CLI tooling via pipx
# ----------------------------
ENV PIPX_HOME=/opt/pipx
ENV PIPX_BIN_DIR=/usr/local/bin

RUN pipx install uv && \
    pipx install poetry && \
    pipx install black && \
    pipx install ruff && \
    pipx install mypy
