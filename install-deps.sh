#!/usr/bin/env bash

set -e # Exit on error

echo "🚀 Installing full development environment for Kali Linux..."
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_step() { echo -e "${BLUE}==>${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }

# Update system
print_step "Updating system packages..."
sudo apt update && sudo apt upgrade -y
print_success "System updated"

# ═══════════════════════════════════════════════════════════
# CORE UTILITIES
# ═══════════════════════════════════════════════════════════
print_step "Installing core utilities..."
sudo apt install -y \
  build-essential \
  git \
  curl \
  wget \
  tree \
  htop \
  btop \
  neofetch \
  net-tools \
  ethtool \
  pciutils \
  lshw \
  hardinfo \
  p7zip-full \
  p7zip-rar \
  unzip \
  unrar \
  zip \
  tar \
  gzip \
  bash-completion \
  flatpak \
  gnome-software-plugin-flatpak
print_success "Core utilities installed"

# ═══════════════════════════════════════════════════════════
# DEVELOPMENT TOOLS
# ═══════════════════════════════════════════════════════════
print_step "Installing development tools..."
sudo apt install -y \
  gcc \
  g++ \
  make \
  cmake \
  ninja-build \
  gettext \
  pkg-config \
  autoconf \
  automake \
  libtool
print_success "Development tools installed"

# ═══════════════════════════════════════════════════════════
# PROGRAMMING LANGUAGES
# ═══════════════════════════════════════════════════════════

# Python
print_step "Installing Python ecosystem..."
sudo apt install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev \
  pipx
print_success "Python installed"

# Node.js via NVM
print_step "Installing Node.js v22 via NVM..."
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install 22
  nvm use 22
  nvm alias default 22
  print_success "Node.js v22 installed"
else
  print_success "NVM already installed"
fi

# Rust
print_step "Installing Rust..."
if ! command -v cargo &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
  print_success "Rust installed"
else
  print_success "Rust already installed"
fi

# Java
print_step "Installing Java (OpenJDK 21)..."
sudo apt install -y openjdk-21-jdk openjdk-21-jre
print_success "Java 21 installed"

# ═══════════════════════════════════════════════════════════
# NEOVIM DEPENDENCIES
# ═══════════════════════════════════════════════════════════
print_step "Installing Neovim dependencies..."

# Clipboard support
sudo apt install -y wl-clipboard xclip xsel

# Fuzzy finders and search tools
sudo apt install -y ripgrep fd-find fzf
sudo ln -sf "$(which fdfind)" /usr/local/bin/fd 2>/dev/null || true

# LSP/Formatters that are in apt
sudo apt install -y \
  lua5.4 \
  luarocks \
  shellcheck \
  shfmt

# Install formatters via npm (needs Node installed first)
if command -v npm &>/dev/null; then
  npm install -g \
    prettier \
    vscode-langservers-extracted \
    typescript-language-server \
    typescript \
    bash-language-server \
    yaml-language-server
fi

# Install Python tools via pipx
pipx install pyright
pipx install ruff

# Install Lua tools
sudo luarocks install luacheck
sudo luarocks install lua-lsp

print_success "Neovim dependencies installed"

# ═══════════════════════════════════════════════════════════
# NEOVIM
# ═══════════════════════════════════════════════════════════
print_step "Installing Neovim v0.10.2..."
if ! command -v nvim &>/dev/null || [ "$(nvim --version | head -1 | grep -oP '\d+\.\d+' | head -1)" != "0.10" ]; then
  cd /tmp
  wget -q https://github.com/neovim/neovim/releases/download/v0.10.2/nvim-linux64.tar.gz
  sudo rm -rf /opt/nvim-linux64
  sudo tar -C /opt -xzf nvim-linux64.tar.gz

  # Add to PATH
  if ! grep -q "/opt/nvim-linux64/bin" ~/.bashrc 2>/dev/null; then
    echo "export PATH=\"\$PATH:/opt/nvim-linux64/bin\"" >>~/.bashrc
  fi
  if [ -f ~/.zshrc ] && ! grep -q "/opt/nvim-linux64/bin" ~/.zshrc; then
    echo "export PATH=\"\$PATH:/opt/nvim-linux64/bin\"" >>~/.zshrc
  fi

  export PATH="$PATH:/opt/nvim-linux64/bin"
  print_success "Neovim v0.10.2 installed"
else
  print_success "Neovim already installed"
fi

# ═══════════════════════════════════════════════════════════
# NERD FONTS
# ═══════════════════════════════════════════════════════════
print_step "Installing Nerd Fonts..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# JetBrainsMono
if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
  cd "$FONT_DIR"
  wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
  unzip -q -o JetBrainsMono.zip
  rm JetBrainsMono.zip
  fc-cache -fv >/dev/null 2>&1
  print_success "JetBrainsMono Nerd Font installed"
fi

# FiraCode (optional, comment if you don't want)
if [ ! -f "$FONT_DIR/FiraCodeNerdFont-Regular.ttf" ]; then
  cd "$FONT_DIR"
  wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
  unzip -q -o FiraCode.zip
  rm FiraCode.zip
  fc-cache -fv >/dev/null 2>&1
  print_success "FiraCode Nerd Font installed"
fi

print_success "Fonts installed"

# ═══════════════════════════════════════════════════════════
# MULTIMEDIA
# ═══════════════════════════════════════════════════════════
print_step "Installing multimedia tools..."
sudo apt install -y \
  ffmpeg \
  mpv \
  vlc
print_success "Multimedia tools installed"

# ═══════════════════════════════════════════════════════════
# BROWSERS
# ═══════════════════════════════════════════════════════════
print_step "Installing browsers..."
sudo apt install -y firefox-esr

# Brave
if ! command -v brave-browser &>/dev/null; then
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
    https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" |
    sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install -y brave-browser
  print_success "Brave installed"
fi

# Google Chrome
if ! command -v google-chrome &>/dev/null; then
  cd /tmp
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt --fix-broken install -y
  print_success "Chrome installed"
fi

# ═══════════════════════════════════════════════════════════
# COMMUNICATION
# ═══════════════════════════════════════════════════════════
print_step "Installing communication apps..."
sudo apt install -y thunderbird

# Ferdium via Flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.ferdium.Ferdium
print_success "Communication apps installed"

# ═══════════════════════════════════════════════════════════
# TORRENTS
# ═══════════════════════════════════════════════════════════
print_step "Installing torrent clients..."
sudo apt install -y qbittorrent

# Stremio via Flatpak
flatpak install -y flathub com.stremio.Stremio
print_success "Torrent clients installed"

# ═══════════════════════════════════════════════════════════
# DEV TOOLS & EXTRAS
# ═══════════════════════════════════════════════════════════
print_step "Installing additional dev tools..."

# LazyGit
if ! command -v lazygit &>/dev/null; then
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  cd /tmp
  wget -q "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf "lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  sudo install lazygit /usr/local/bin
  print_success "LazyGit installed"
fi

# Tree-sitter CLI
if ! command -v tree-sitter &>/dev/null && command -v npm &>/dev/null; then
  npm install -g tree-sitter-cli
  print_success "Tree-sitter CLI installed"
fi

# ═══════════════════════════════════════════════════════════
# VIRTUALIZATION (optional - comment if not needed)
# ═══════════════════════════════════════════════════════════
print_step "Installing VirtualBox..."
sudo apt install -y virtualbox virtualbox-ext-pack
print_success "VirtualBox installed"

# ═══════════════════════════════════════════════════════════
# TERMINAL
# ═══════════════════════════════════════════════════════════
print_step "Installing Terminator terminal..."
sudo apt install -y terminator
print_success "Terminator installed"

# ═══════════════════════════════════════════════════════════
# FINAL SETUP
# ═══════════════════════════════════════════════════════════
print_step "Setting up environment..."

# Add cargo to PATH if not already there
if [ -f "$HOME/.cargo/env" ]; then
  if ! grep -q ".cargo/env" ~/.bashrc 2>/dev/null; then
    echo 'source "$HOME/.cargo/env"' >>~/.bashrc
  fi
  if [ -f ~/.zshrc ] && ! grep -q ".cargo/env" ~/.zshrc; then
    echo 'source "$HOME/.cargo/env"' >>~/.zshrc
  fi
fi

# Add pipx to PATH
if ! grep -q "pipx ensurepath" ~/.bashrc 2>/dev/null; then
  echo "export PATH=\"\$HOME/.local/bin:$PATH\"" >>~/.bashrc
fi

print_success "Environment configured"

echo ""
echo "════════════════════════════════════════════════════════════"
echo -e "${GREEN}✓ Installation complete!${NC}"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "📦 Installed:"
echo "  • Core utilities (git, curl, wget, htop, etc.)"
echo "  • Programming languages (Python, Node.js v22, Rust, Java 21)"
echo "  • Neovim v0.10.2 + all dependencies"
echo "  • LSP servers (Pyright, Ruff, Bash-LS, TS-Server, etc.)"
echo "  • Formatters (Prettier, Stylua, Shfmt, etc.)"
echo "  • Nerd Fonts (JetBrainsMono, FiraCode)"
echo "  • Browsers (Firefox, Brave, Chrome)"
echo "  • Apps (Thunderbird, Ferdium, QBittorrent, Stremio, VLC)"
echo "  • Dev tools (LazyGit, Tree-sitter CLI)"
echo "  • VirtualBox"
echo ""
echo "🚀 Next steps:"
echo "  1. ${BLUE}Restart your terminal${NC} (or run: source ~/.bashrc)"
echo "  2. Clone nvim config:"
echo "     ${YELLOW}git clone https://github.com/marcoperinidev/nvim ~/.config/nvim${NC}"
echo "  3. Launch: ${YELLOW}nvim${NC}"
echo "  4. Wait for lazy.nvim to install plugins"
echo "  5. Mason will auto-install remaining LSP servers"
echo ""
echo "💡 Tips:"
echo "  • Set terminal font to 'JetBrainsMono Nerd Font' in Terminator preferences"
echo "  • Run 'nvim' and execute: :checkhealth"
echo "  • Flatpak apps: run with 'flatpak run <app-id>'"
echo ""
