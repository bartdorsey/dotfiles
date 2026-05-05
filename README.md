# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each directory is a stow package that gets symlinked into `$HOME`.

## Usage

```bash
# Install everything
./install

# Install a specific package
stow -v -R <package> -t "$HOME"

# Remove a package's symlinks
stow -v -D <package> -t "$HOME"

# Dry run
stow -v -n -R <package> -t "$HOME"
```

## Platform Notes

The install script detects the current platform and skips packages that don't apply:

| Platform | Skipped packages |
|----------|-----------------|
| Linux / NixOS | `aerospace/`, `sketchybar/`, `borders/` (macOS only) |
| Linux / macOS | `yasb/` (Windows only) |
| All | `firefox/`, `nix/`, `syncthing/`, `wsl/`, `systemd/`, `resticprofile/`, `goxlr-utility/`, `metadata/` |

---

## Stow Packages

### Shell & Terminal

| Package | Description |
|---------|-------------|
| `zsh/` | Zsh config — modular setup with plugins, completions, vi mode, tool integrations (mise, direnv, zoxide) |
| `bash/` | Bash config — `.bash_profile` and shared config |
| `common/` | Shared shell scripts sourced by multiple shells — aliases, env vars, path setup, fzf, fetch, utils |
| `tmux/` | tmux config with TPM (Tmux Plugin Manager) and plugins |
| `zellij/` | Zellij terminal workspace manager config |
| `starship/` | Starship cross-shell prompt config |
| `oh-my-posh/` | Oh My Posh prompt theme engine config |
| `terminfo/` | Terminal capability database entries for custom terminals |
| `direnv/` | direnv `.envrc` hook config |

### Text Editors & IDEs

| Package | Description |
|---------|-------------|
| `nvim/` | Neovim config — Lua-based with lazy.nvim, LSP for 23+ languages, 100+ plugins |
| `vim/` | Traditional Vim config with vim-plug |
| `helix/` | Helix modal editor config |
| `vscode/` | VS Code settings, keybindings, and extensions list |
| `zed/` | Zed code editor settings and keymap |
| `prettierd/` | Prettier code formatter config (`prettierrc.json`) |

### Terminal Emulators

| Package | Description |
|---------|-------------|
| `alacritty/` | Alacritty GPU-accelerated terminal config |
| `kitty/` | Kitty GPU-accelerated terminal config |
| `wezterm/` | WezTerm terminal config — appearance, keybindings, domains, tabs |
| `ghostty/` | Ghostty terminal emulator config |

### Window Managers & Desktop

| Package | Description |
|---------|-------------|
| `hypr/` | Hyprland Wayland compositor — keybinds, rules, animations, monitors |
| `cosmic/` | COSMIC desktop environment config — 214 config files |
| `waybar/` | Waybar status bar config — layout, modules, themes (gruvbox/catppuccin) |
| `awesome/` | AwesomeWM config (kept for potential X11 use) |
| `i3/` | i3 tiling window manager config (kept for potential X11 use) |
| `polybar/` | Polybar status bar for i3/X11 (kept for potential X11 use) |
| `wofi/` | Wofi Wayland app launcher config |
| `rofi/` | Rofi app launcher/switcher config |
| `walker/` | Walker application launcher config |
| `dunst/` | Dunst notification daemon config |
| `dmux/` | dmux tmux session layout manager config |
| `sesh/` | sesh tmux session manager config |

### macOS Only

| Package | Description |
|---------|-------------|
| `aerospace/` | AeroSpace tiling window manager for macOS |
| `sketchybar/` | SketchyBar macOS status bar replacement |
| `borders/` | JankyBorders window border highlight for macOS |

### Windows Only

| Package | Description |
|---------|-------------|
| `yasb/` | YASB (Yet Another Status Bar) for Windows 11 |
| `glzr/` | Glazewm tiling window manager for Windows (also Zebar status bar) |

### File Managers

| Package | Description |
|---------|-------------|
| `yazi/` | Yazi terminal file manager config |
| `lf/` | lf terminal file manager config |
| `superfile/` | superfile terminal file manager config |

### Development Tools

| Package | Description |
|---------|-------------|
| `git/` | Git config and global ignore rules |
| `lazygit/` | Lazygit TUI git client config |
| `mise/` | mise-en-place runtime version manager config |
| `direnv/` | direnv environment variable manager config |
| `pgcli/` | pgcli PostgreSQL CLI config |

### Email & Calendar

| Package | Description |
|---------|-------------|
| `aerc/` | aerc terminal email client config |
| `khal/` | khal terminal calendar config |
| `vdirsyncer/` | vdirsyncer CalDAV/CardDAV sync tool config |

### System Utilities

| Package | Description |
|---------|-------------|
| `btop/` | btop++ system resource monitor config |
| `htop/` | htop interactive process viewer config |
| `bat/` | bat (cat replacement) config and themes |
| `lsd/` | lsd (ls replacement) config |
| `fastfetch/` | fastfetch system info display config |
| `macchina/` | macchina system info display config |
| `flameshot/` | Flameshot screenshot tool config |
| `ssh/` | SSH keys and config (encrypted via git-crypt) |
| `gnupg/` | GnuPG config |

### Music & Media

| Package | Description |
|---------|-------------|
| `rmpc/` | rmpc MPD music player TUI config |
| `ncmpcpp/` | ncmpcpp MPD music player TUI config |

### Hardware

| Package | Description |
|---------|-------------|
| `goxlr-utility/` | GoXLR audio mixer daemon config (ignored by install, manual stow) |

### Appearance

| Package | Description |
|---------|-------------|
| `art/` | ASCII art themes — nyancat, pusheen, gruvbox, supermario, etc. |
| `fonts/` | Custom font files installed to `~/.local/share/fonts` |
| `wallpaper/` | Wallpaper images |
| `logos/` | Logo/icon assets |

### Applications

| Package | Description |
|---------|-------------|
| `vesktop/` | Vesktop Discord client config and themes |
| `zen/` | Zen browser user chrome and config |
| `claude/` | Claude Code settings |
| `doom/` | Doom Emacs config (`~/.doom.d`) |

### Platform-Specific (Not Stowed)

| Package | Description |
|---------|-------------|
| `nix/` | NixOS flake configs for all hosts — nzxt, nzxt-wsl, nixos-dev |
| `wsl/` | Windows Subsystem for Linux specific scripts and config |
| `windows/` | Windows-specific scripts and utilities |
| `firefox/` | Firefox profile and user chrome (manual setup — complex profile paths) |
| `systemd/` | User systemd service files (managed separately) |
| `syncthing/` | Syncthing config (contains certs, managed separately) |
| `resticprofile/` | Restic backup profiles (managed separately) |
| `omarchy/` | Omarchy desktop environment config (not currently active) |

---

## Scripts

| Script | Description |
|--------|-------------|
| `install` | Main setup script — stows all packages, installs zsh plugins, fixes SSH permissions |
| `install-fonts` | Installs fonts from the `fonts/` package to `~/.local/share/fonts` |
| `install-tools` | Installs additional CLI tools not managed by Nix |
| `start.sh` | Quick start script |

## Non-Stow Directories

| Directory | Description |
|-----------|-------------|
| `metadata/` | Repository metadata (not stowed) |
| `binaries/` | Compiled/downloaded binaries stowed to `~/.local/bin` |
| `streamcontroller/` | StreamDeck StreamController config |

---

## Encryption

SSH keys and other sensitive files are encrypted with [git-crypt](https://github.com/AGWA/git-crypt). Run `git-crypt unlock` after cloning (requires the key).

## Development

Test changes in Docker without affecting your real system:

```bash
docker compose up --build -d homedir
docker compose exec homedir zsh
docker compose down
```
