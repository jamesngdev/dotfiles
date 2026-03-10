# my-dotenv

Personal dotfiles for macOS and Linux, including Zsh, tmux, Neovim, and Starship prompt configurations.

## Quick Install

```bash
# SSH
git clone git@github.com:jamesngdev/dotfiles.git ~/my-dotenv

# or HTTPS
git clone https://github.com/jamesngdev/dotfiles.git ~/my-dotenv

cd ~/my-dotenv
chmod +x install.sh
./install.sh
```

The installer will:

1. Detect your OS (macOS or Linux)
2. Install all dependencies automatically
3. Back up existing config files to `~/.dotenv-backup/<timestamp>/`
4. Create symlinks from this repo to your home directory

## What Gets Installed

| Tool | Description |
|------|-------------|
| [Oh My Zsh](https://ohmyz.sh/) | Zsh framework with plugins and themes |
| [Starship](https://starship.rs/) | Cross-shell prompt |
| [NVM](https://github.com/nvm-sh/nvm) | Node.js version manager |
| [tmux](https://github.com/tmux/tmux) | Terminal multiplexer |
| [Neovim](https://neovim.io/) | Hyperextensible text editor |
| [TPM](https://github.com/tmux-plugins/tpm) | Tmux Plugin Manager |
| [Homebrew](https://brew.sh/) | Package manager (macOS only) |

## Symlinked Files

```
my-dotenv/.zshrc        -> ~/.zshrc
my-dotenv/.tmux.conf    -> ~/.tmux.conf
my-dotenv/.config/nvim  -> ~/.config/nvim
```

## Post-Install Steps

1. Restart your terminal or run `source ~/.zshrc`
2. In tmux, press `prefix + I` to install tmux plugins
3. Open `nvim` to let plugins install automatically

---

## Tmux Configuration

### Plugins

- **tpm** - Tmux Plugin Manager
- **tmux-sensible** - Sensible default settings
- **tmux-resurrect** - Persist tmux sessions across restarts
- **tmux-nova** - Status bar theme (Dracula-inspired colors)

### Key Bindings

All bindings use the default tmux prefix (`Ctrl + b`).

| Key | Action |
|-----|--------|
| `prefix + h` | Select pane left |
| `prefix + j` | Select pane down |
| `prefix + k` | Select pane up |
| `prefix + l` | Select pane right |
| `prefix + I` | Install plugins (TPM) |

### Features

- **Mouse support** enabled (`set -g mouse on`)
- **Vim-style pane navigation** with `h/j/k/l`
- **Heavy pane borders** with active pane highlighted in pink (`#ff79c6`)
- **Top status bar** with Nova theme showing current mode and `user@host`
- **Pane labels** displayed at top showing index and running command

### Theme (tmux-nova)

The status bar uses the Nova theme with Nerd Fonts icons:

- **Left segment**: Mode indicator (`Ω` when prefix is active, `ω` otherwise)
- **Right segment**: `username@hostname`
- **Colors**: Green (`#50fa7b`) on dark background (`#282a36`)

---

## Zsh Configuration

### Framework

[Oh My Zsh](https://ohmyz.sh/) with the `robbyrussell` theme, overridden by [Starship](https://starship.rs/) prompt.

### Plugins

| Plugin | Description |
|--------|-------------|
| `git` | Git aliases and functions (e.g., `gst`, `gco`, `gp`) |
| `z` | Jump to frequently used directories (e.g., `z myproject`) |

### Custom Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `active_personal` | `cp ~/.ssh/id_rsa_personal ~/.ssh/active_profile` | Switch to personal SSH key |
| `active_work` | `cp ~/.ssh/id_rsa_work ~/.ssh/active_profile` | Switch to work SSH key |
| `claudex` | `claude --dangerously-skip-permissions` | Run Claude Code without permission prompts |

### Auto NVM Version Switching

The `.zshrc` includes an automatic NVM hook that:

- Detects `.nvmrc` files when you `cd` into a directory
- Automatically runs `nvm use` or `nvm install` to match the required Node.js version
- Reverts to your default Node version when leaving a project

### Environment Variables

| Variable | Value |
|----------|-------|
| `NVM_DIR` | `$HOME/.nvm` |
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` | `1` |

### PATH Additions

- `$HOME/.local/bin`
- `/opt/homebrew/opt/libpq/bin` (PostgreSQL client tools)
- `$HOME/Library/Python/3.9/bin`

---

## Neovim

Neovim config lives in `.config/nvim/` and is symlinked to `~/.config/nvim`. Open `nvim` after install to let plugins bootstrap automatically.

## Backups

The installer automatically backs up any existing configs before creating symlinks. Backups are saved to:

```
~/.dotenv-backup/<timestamp>/
```
