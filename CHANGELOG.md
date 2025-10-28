# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

## [3.5.2]

### Added

- SysDen64
  - Support for lab container

## [3.4.2]

### Added

- Modules
  - Custom
  - VSCode

## [3.3.5]

### Added

- Env
  - Local bin search path
  - Backup of current .env.d
- Module
  - NVM
- SysDen64
  - Allow customization of module list (SYSDEN64_MODULES_SHARED, SYSDEN64_MODULES_DEDICATED)

### Changed

- All
  - Normalized env file names
- Starship
  - Loaded migrated to .env.d

### Fixed

- Git
  - Remove hardcoded GHCLI paths

## [3.2.1]

### Added

- Module
  - Rancher Desktop

### Changed

- SysDen64
  - Skip already created user-wide repository (-s)

## [3.1.0]

### Added

- Module
  - Python

## [3.0.3]

### Fixed

- SysDen64
  - Missing devbin64 check
  - GitIgnore parser

### Added

- Module
  - Nodejs

### Changed

- All
  - Renamed aliases: zCOMMAND -> qCOMMAND
- Env
  - No longer setting timezone and locale by default. This is managed by the target OS
  - Migrated paths and pager to provider module
- ZSH
  - Migrated .zshrc to .zshenv

## [2.1.0]

### Added

- Modules
  - Homebrew

### Changed

- Bash
  - RC and Profile moved to Bash shared module

## [2.0.2]

### Added

- SysDen
  - System vs User wide configuration profiles

### Removed

- SysDen
  - **breaking-change** Option: `-d`. Now managed by system vs user wide feature
  - **breaking-change** Option: `-c`. Now managed by system vs user wide feature

### Fixed

- SysDen
  - DevBin64 path, sed expression

## [1.9.2]

### Added

- SysDen
  - Upgrade shared module configuration feature

## [1.8.0]

### Added

- Modules
  - LSD

## [1.7.1]

### Added

- SysDen64
  - Dedicated directory for external git repos (repos/)
  - Git ignore profile homes
  - Backup previous home cfg

## [1.6.0]

### Added

- SysDen64
  - Deploy profiles

## [1.5.1]

### Added

- Modules
  - EZA
  - DUF
  - FD
  - HWatch
  - RipGrep
  - Terraform
  - Zellij

- Shell Aliases
  - Bat: zcat
  - Docker: xd
  - GCloud: xg
  - KubeCTL: xk
  - NVIM: zvi

### Changed

- all
  - do not run if the tool is not present
- devbin64
  - use shared string messages
- bash
  - Use BL64 to generate profiles
- env
  - added nodejs npm path

### Fixed

- Bash
  - Added missing env snippet

## [1.4.0]

### Added

- Added option to create a SysDen64 repository

## [1.3.0]

### Added

- Modules
  - Delta
  - Bat

## [1.2.0]

### Changed

- Git
  - Changed pager to delta

### Fixed

- Kubectl
  - Fixed setup function

## [1.1.0]

### Added

- Module
  - Tilix

### Changed

- Git
  - Do not replace existing config

## [1.0.2]

### Added

- bin/sysden64: standalone deployment tool
- lib/*: application configuration modules

### Changed

- etc/den: relocated application configuration files to src/etc
