#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────────────────────
# nvim-vscode-setup-jt installer
# One-liner: curl -fsSL https://raw.githubusercontent.com/jtvargas/nvim-vscode-setup-jt/main/install.sh | bash
# ─────────────────────────────────────────────────────────────

REPO="jtvargas/nvim-vscode-setup-jt"
BRANCH="main"
NVIM_CONFIG="$HOME/.config/nvim"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
fail()  { echo -e "${RED}[FAIL]${NC} $1"; exit 1; }

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Neovim + LazyVim VSCode-Style Installer    ║${NC}"
echo -e "${GREEN}║   github.com/${REPO}        ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════╝${NC}"
echo ""

# ── Step 1: Check macOS ──────────────────────────────────────
if [[ "$(uname)" != "Darwin" ]]; then
  fail "This script is designed for macOS only. Detected: $(uname)"
fi
ok "Running on macOS"

# ── Step 2: Install Homebrew ─────────────────────────────────
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for Apple Silicon
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  ok "Homebrew installed"
else
  ok "Homebrew already installed"
fi

# ── Step 3: Install Neovim ──────────────────────────────────
if ! command -v nvim &>/dev/null; then
  info "Installing Neovim..."
  brew install neovim
  ok "Neovim installed"
else
  ok "Neovim already installed ($(nvim --version | head -1))"
fi

# ── Step 4: Install dependencies ─────────────────────────────
DEPS=(ripgrep fd lazygit git)
for dep in "${DEPS[@]}"; do
  if ! command -v "$dep" &>/dev/null; then
    info "Installing $dep..."
    brew install "$dep"
    ok "$dep installed"
  else
    ok "$dep already installed"
  fi
done

# ── Step 5: Install Nerd Font ────────────────────────────────
if ! brew list --cask font-jetbrains-mono-nerd-font &>/dev/null 2>&1; then
  info "Installing JetBrains Mono Nerd Font..."
  brew install --cask font-jetbrains-mono-nerd-font
  ok "JetBrains Mono Nerd Font installed"
else
  ok "JetBrains Mono Nerd Font already installed"
fi

# ── Step 6: Back up existing config ──────────────────────────
if [[ -d "$NVIM_CONFIG" ]]; then
  BACKUP="$NVIM_CONFIG.bak.$TIMESTAMP"
  warn "Existing Neovim config found. Backing up to: $BACKUP"
  mv "$NVIM_CONFIG" "$BACKUP"
  ok "Backup created at $BACKUP"
fi

# ── Step 7: Clean Lazy.nvim cache ────────────────────────────
for dir in "$HOME/.local/share/nvim" "$HOME/.local/state/nvim" "$HOME/.cache/nvim"; do
  if [[ -d "$dir" ]]; then
    CACHE_BACKUP="${dir}.bak.$TIMESTAMP"
    warn "Backing up $dir to $CACHE_BACKUP"
    mv "$dir" "$CACHE_BACKUP"
  fi
done
ok "Lazy.nvim cache cleaned (old caches backed up)"

# ── Step 8: Download and install config ──────────────────────
info "Downloading config from GitHub..."
TMPDIR=$(mktemp -d)
cd "$TMPDIR"
curl -fsSL "https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz" | tar xz
mkdir -p "$HOME/.config"
cp -r "nvim-vscode-setup-jt-$BRANCH/nvim" "$NVIM_CONFIG"
rm -rf "$TMPDIR"
ok "Config installed to $NVIM_CONFIG"

# ── Done ─────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║             Installation complete!            ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Next steps:"
echo -e "  ${BLUE}1.${NC} Set your terminal font to ${YELLOW}JetBrains Mono Nerd Font${NC}"
echo -e "     iTerm2: Preferences > Profiles > Text > Font"
echo -e "     Terminal.app: Preferences > Profiles > Font > Change"
echo -e ""
echo -e "  ${BLUE}2.${NC} Launch Neovim:"
echo -e "     ${GREEN}nvim${NC}"
echo -e "     (Lazy.nvim will auto-install all plugins on first launch)"
echo -e ""
echo -e "  ${BLUE}3.${NC} Wait for plugins to finish installing, then restart Neovim"
echo -e ""
echo -e "  ${BLUE}4.${NC} Press ${YELLOW}Space${NC} to see the which-key menu with all shortcuts"
echo ""
