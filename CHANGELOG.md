# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0]

### Added

- Modules
  - EZA
  - DUF
  - FD: zgrep
  - HWatch
  - RipGrep
  - Zellij

- Shell Aliases
  - Bat: zcat
  - KubeCTL: zk
  - Bat: zcat

### Changed

- all
  - do not run if the tool is not present
- devbin64
  - use shared string messages
- bash
  - Use BL64 to generate profiles
- env
  - added nodejs npm path

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
