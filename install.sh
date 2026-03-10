#!/usr/bin/env bash
set -euo pipefail

DOTENV_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotenv-backup/$(date +%Y%m%d_%H%M%S)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# --- Detect OS & package manager ---
detect_os() {
  case "$(uname -s)" in
    Darwin) OS="macos" ;;
    Linux)  OS="linux" ;;
    *)      error "Unsupported OS: $(uname -s)"; exit 1 ;;
  esac
  info "Detected OS: $OS"
}

install_package() {
  local pkg="$1"
  if command -v "$pkg" &>/dev/null; then
    info "$pkg already installed"
    return
  fi

  info "Installing $pkg..."
  if [[ "$OS" == "macos" ]]; then
    brew install "$pkg"
  elif command -v apt-get &>/dev/null; then
    sudo apt-get install -y "$pkg"
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y "$pkg"
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm "$pkg"
  else
    warn "Cannot auto-install $pkg. Please install it manually."
  fi
}

# --- Backup & symlink helper ---
backup_and_link() {
  local src="$1"
  local dest="$2"

  # If dest is already a symlink pointing to src, skip
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    info "Already linked: $dest -> $src"
    return
  fi

  # Backup existing file/dir
  if [[ -e "$dest" || -L "$dest" ]]; then
    mkdir -p "$BACKUP_DIR"
    warn "Backing up $dest -> $BACKUP_DIR/"
    mv "$dest" "$BACKUP_DIR/"
  fi

  # Ensure parent directory exists
  mkdir -p "$(dirname "$dest")"

  ln -s "$src" "$dest"
  info "Linked: $dest -> $src"
}

# --- Install dependencies ---
install_deps() {
  info "=== Installing dependencies ==="

  # Homebrew (macOS)
  if [[ "$OS" == "macos" ]] && ! command -v brew &>/dev/null; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Zsh
  if ! command -v zsh &>/dev/null; then
    info "Installing Zsh..."
    if [[ "$OS" == "macos" ]]; then
      brew install zsh
    elif command -v apt-get &>/dev/null; then
      sudo apt-get install -y zsh
    elif command -v dnf &>/dev/null; then
      sudo dnf install -y zsh
    elif command -v pacman &>/dev/null; then
      sudo pacman -S --noconfirm zsh
    else
      warn "Cannot auto-install zsh. Please install it manually."
    fi

    # Set zsh as default shell
    if command -v zsh &>/dev/null; then
      local zsh_path
      zsh_path="$(command -v zsh)"
      if ! grep -q "$zsh_path" /etc/shells; then
        info "Adding $zsh_path to /etc/shells..."
        echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
      fi
      info "Setting zsh as default shell..."
      chsh -s "$zsh_path"
    fi
  else
    info "Zsh already installed"
  fi

  # Oh My Zsh
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    info "Oh My Zsh already installed"
  fi

  # Starship prompt
  if ! command -v starship &>/dev/null; then
    info "Installing Starship..."
    if [[ "$OS" == "macos" ]]; then
      brew install starship
    else
      curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
  else
    info "Starship already installed"
  fi

  # NVM
  if [[ ! -d "$HOME/.nvm" ]]; then
    info "Installing NVM..."
    if [[ "$OS" == "macos" ]]; then
      brew install nvm
      mkdir -p "$HOME/.nvm"
    else
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    fi
  else
    info "NVM already installed"
  fi

  # tmux
  install_package tmux

  # Neovim
  if ! command -v nvim &>/dev/null; then
    info "Installing Neovim..."
    if [[ "$OS" == "macos" ]]; then
      brew install neovim
    elif command -v apt-get &>/dev/null; then
      sudo apt-get install -y neovim
    else
      warn "Please install Neovim manually: https://github.com/neovim/neovim/releases"
    fi
  else
    info "Neovim already installed"
  fi

  # TPM (Tmux Plugin Manager)
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    info "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  else
    info "TPM already installed"
  fi
}

# --- Fix machine-specific paths in .zshrc ---
patch_zshrc() {
  local zshrc="$DOTENV_DIR/.zshrc"

  # Replace hardcoded Python path with dynamic $HOME-based path
  if grep -q "/Users/trinv/Library/Python" "$zshrc"; then
    info "Patching hardcoded Python path in .zshrc..."
    if [[ "$OS" == "macos" ]]; then
      sed -i '' 's|/Users/trinv/Library/Python/3.9/bin|$HOME/Library/Python/3.9/bin|g' "$zshrc"
    else
      sed -i 's|/Users/trinv/Library/Python/3.9/bin|$HOME/Library/Python/3.9/bin|g' "$zshrc"
    fi
  fi
}

# --- Create symlinks ---
create_symlinks() {
  info "=== Creating symlinks ==="

  backup_and_link "$DOTENV_DIR/.zshrc"    "$HOME/.zshrc"
  backup_and_link "$DOTENV_DIR/.tmux.conf" "$HOME/.tmux.conf"
  backup_and_link "$DOTENV_DIR/.config/nvim" "$HOME/.config/nvim"
}

# --- Main ---
main() {
  echo ""
  echo "========================================="
  echo "  my-dotenv installer"
  echo "========================================="
  echo ""
  info "Dotenv directory: $DOTENV_DIR"

  detect_os
  install_deps
  patch_zshrc
  create_symlinks

  echo ""
  info "=== Installation complete! ==="
  echo ""
  echo "Next steps:"
  echo "  1. Restart your terminal or run: source ~/.zshrc"
  echo "  2. In tmux, press prefix + I to install tmux plugins"
  echo "  3. Open nvim to let LazyVim install plugins automatically"
  if [[ -d "$BACKUP_DIR" ]]; then
    echo ""
    warn "Backups saved to: $BACKUP_DIR"
  fi
  echo ""
}

main "$@"
