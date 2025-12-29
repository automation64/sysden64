# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [4.8.1]

### Added

- SysDen64
  - Compatibility check (BashLib64)
- RipGrep
  - Default configuration
- Modules
  - Go
  - Gemini CLI
  - VSCodium
  - SuperFile
  - Atuin
  - FZF

### Changed

- SysDen64
  - Default verbosity format
- OMZ
  - Default plugins: demoted to optional non-core plugins
  - **breaking-change** Removed: installer. Module now detects if OMZ is installed

### Fixed

- OMZ
  - Plugin load order

## [4.7.0]

### Added

- SysDen64
  - Show version information

### Changed

- SysDen64
  - Show warning instead of failing when a new configuration module is missing in the user repository
  - Changed verbose format to show task name only
  - Skip shell reload if the module does not modify the shell environment

## [4.6.1]

### Added

- Modules
  - Auth0
- SysDen64
  - Profile remove

### Fixed

- SysDen64
  - Symlink update after profile switch

## [4.5.0]

### Changed

- Zellij
  - Updated config to include default keyboard layout
- Alacritty
  - Migrated config to TOML format

## [4.4.0]

### Added

- SysDen64
  - Show current profile, show modules
- Modules
  - K9S

### Changed

- SysDen64
  - Directory shortcut creation is now optional
- Alacritty
  - Shell set to zellij

## [4.3.0]

### Added

- Modules
  - Kitty
  - OCI
- SysDen64
  - Profile list command

### Changed

- Zellij
  - Update default config

## [4.2.1]

### Added

- SysDen64
  - Allow single module upgrade and sync

## [4.1.1]

### Added

- Module
  - Cursor

## [4.0.2]

### Added

- Module
  - Fish
  - Profile
  - Java
  - LibPQ
  - OpenSSL
  - Helix
  - Zoxide
- Bash
  - Load shell specific functions and settings from .env.d/*.bash
- ZSH
  - Load shell specific functions and settings from .env.d/*.zsh
- VSCode
  - Default config
- Zellij
  - Default config
- Rancher Desktop
  - Default config
- LSD
  - Color Theme
- SysDen64
  - Shell reload after config update
  - Lock/Unlock module for upgrade
- Env
  - TERM normalization

### Changed

- SysDen64
  - Use system-wide (/opt/) or user-wide (at64/) automation64 instead of repository-wide (sd64/lib/)
- Custom
  - **breaking-change** Changed .env.d/* file names to ensure custom module is the last one to be loaded
- P10K
  - **breaking-change** Migrated shell snippet to .env.d loaders
- OMZ
  - **breaking-change** Migrated shell snippet to .env.d loaders
- Starship
  - **breaking-change** Upgraded .env.d file format to new model

### Fixed

- AWSCLI
  - Profile switch will not overwrite previous config
- Docker
  - Profile switch will not overwrite previous config
- GCloud
  - Profile switch will not overwrite previous config
- KubeCTL
  - Profile switch will not overwrite previous config
- SSH
  - Profile switch will not overwrite previous config
