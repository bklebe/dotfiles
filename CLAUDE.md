# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Home Manager configuration for macOS (aarch64-darwin) using Nix flakes. It manages user environments for multiple users (ada, beatrix) with declarative package management and dotfile configuration.

## Key Commands

### Building and Activating Configuration
```bash
# Build and activate home-manager configuration for current user
home-manager switch

# Build and activate home-manager configuration for specific user
home-manager switch --flake .#ada
home-manager switch --flake .#beatrix

# Build for current user without activating
home-manager build

# Build for a specific user without activating
home-manager build --flake .#ada

# Update flake inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs
```

### Version Control
This repository uses Jujutsu (jj), not git. See jj documentation: https://jj-vcs.github.io/jj/latest/cli-reference/

## Architecture

### Flake Structure
- `flake.nix`: Defines two homeConfigurations (ada, beatrix) with shared base configuration but different user-specific packages and settings
- `home.nix`: Main Home Manager module that accepts user-specific parameters via `extraSpecialArgs`
- `flake.nix` passes different `userPackages` and `extraNushellConfig` to each user configuration

### Key Inputs
- `nixpkgs`: nixos-unstable channel
- `home-manager`: Home Manager framework
- `mac-app-util`: Better macOS application integration (enables Spotlight search, pinning Nix apps to dock across updates)
- `packageset` (nix-idris2-packages): Provides Idris2 tooling (idris2, idris2Lsp, idris2Packages, buildIdris)
- `claude-code`: Overlay providing the latest Claude Code

### Configuration Patterns
- **User parameterization**: `user`, `userPackages`, `extraNushellConfig` are passed via `extraSpecialArgs` to support multiple users
- **Unfree packages**: Explicitly whitelisted via `allowUnfreePredicate` (currently: 1password-cli, claude-code)
- **XDG compliance**: Environment variables configured to respect XDG Base Directory Specification
- **Custom packages**: `packages/` directory contains custom Nix derivations (e.g., jdk-mission-control.nix)
- **Shell config**: Dotfiles in `xdg-config/` are symlinked via `xdg.configFile`

### Shell Configuration
- Primary shell: Nushell (with mise, zoxide, carapace integrations)
- Nushell config sources: `xdg-config/nushell/config.nu`, `xdg-config/nushell/nix.nu`
- Additional shells: Zsh (ZDOTDIR redirected to XDG), Fish, Bash

### Gradle Setup
- Two Gradle versions available: gradle\_8 (via custom wrapper script) and gradle\_9 (primary)
- Gradle installations symlinked to XDG data locations for IDE integration
- Gradle home configured to XDG data directory

### macOS Integration
- `launchctl-setenv` agent: Propagates session variables to macOS launchd for GUI applications
- `mac-app-util` module handles macOS-specific application management