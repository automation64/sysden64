# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0]

### Changed

- Env
  - No longer setting timezone and locale by default. This is managed by the target OS
- ZSH
  - Cloned .zshrc to .zshenv
  - Emptied .zshrc

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
