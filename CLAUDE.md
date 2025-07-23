# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive dotfiles repository using GNU Stow for symlink management. It contains configurations for development tools, editors, terminal environments, and desktop applications across Linux, WSL, and macOS.

## Common Commands

### Setup and Installation
```bash
# Install/reinstall all configurations
./install

# Update git submodules (zsh plugins)
./update

# Run in Docker development environment
docker compose up --build -d homedir
docker compose exec homedir zsh
```

### Stow Operations
```bash
# Install specific package
stow -v -R <package-name> -t "$HOME"

# Remove package symlinks  
stow -v -D <package-name> -t "$HOME"

# Dry run to check what would be linked
stow -v -n -R <package-name> -t "$HOME"
```

### Development Environment
```bash
# Format Lua code (used for Neovim configs)
stylua .

# Lint Lua code (uses selene.toml config)
selene .

# Format shell scripts
shfmt -w -i 4 <file>

# Enable development mode (affects Neovim plugin loading)
touch ~/.config/devmode
export DEVMODE=1

# Test Docker environment
docker compose up --build -d homedir
docker compose exec homedir zsh
docker compose down
```

## Architecture

### Package Structure
Each directory represents a "stow package" that gets symlinked to `$HOME`:
- **nvim/**: Neovim configuration with lazy.nvim plugin management (101 plugins)
- **zsh/**: Modular zsh configuration with custom plugin system
- **tmux/**: Terminal multiplexer with plugin management via tpm
- **git/**: Git configuration and aliases
- **vim/**: Traditional Vim configuration
- **alacritty/**, **kitty/**, **wezterm/**: Terminal emulator configs
- **firefox/**: Firefox profile and customizations
- **vscode/**: VS Code settings and extensions

### Key Technologies
- **Stow**: Symlink farm manager for dotfile deployment
- **Git Submodules**: Used for zsh plugins and some Neovim plugins
- **Docker**: Containerized development environment for testing
- **XDG Base Directory**: Follows XDG spec for config file locations

### Environment Detection
The install script detects and adapts to:
- **NixOS**: Skips packages managed by home-manager (zshenv, git)
- **WSL**: Enables Windows integration features
- **DEVMODE**: Development mode for additional tooling

### Ignored Packages
The install script automatically skips:
- `metadata/`: Repository metadata
- `firefox/`: Browser profiles (manual setup)
- `windows/`: Windows-specific scripts
- `nix/`: NixOS configurations
- `glzr/`: Window manager configs
- `syncthing/`: Sync service configs

### Cross-Platform Support
- **Linux**: Primary target with full feature set
- **WSL**: Windows subsystem integration with clipboard, GUI apps
- **macOS**: Aerospace, SketchyBar, and other macOS-specific tools
- **NixOS**: Home Manager integration for declarative config

### Plugin Management Systems
- **Neovim**: lazy.nvim with 101 plugins, LSP for 23+ languages
- **Zsh**: Custom plugin system with fzf-tab, autosuggestions, syntax highlighting  
- **Tmux**: TPM (Tmux Plugin Manager)
- **Vim**: vim-plug

### Configuration Highlights
- **Neovim**: Modern Lua config with LSP, AI integration (Copilot), comprehensive development tools
- **Zsh**: Vi mode, Starship prompt, extensive tool integration (mise, direnv, zoxide)
- **Git**: Comprehensive aliases and modern workflow tools
- **Development**: Multi-language LSP support, formatters, linters, debuggers

## Code Quality Tools

### Lua Configuration
- **Stylua**: Code formatter with configuration in `.stylua.toml` (80 columns, 4 spaces)
- **Selene**: Lua linter configured for Vim/Neovim with `selene.toml`
- **Lazy.nvim**: Plugin manager bootstraps automatically, imports from `plugins/` directory

### Shell Scripts
- **shfmt**: Shell script formatter with 4-space indentation
- Scripts use `#!/usr/bin/env zsh` for maximum compatibility

### Development Workflow
- DEVMODE environment variable affects plugin loading behavior
- Git submodules used for external plugin dependencies
- XDG Base Directory compliance throughout configuration