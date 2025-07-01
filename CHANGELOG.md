# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.1.0] - 2025-06-30

### Added

- Support for Ruby versions 3.3 and 3.4
- InsecureRandom.disabled? method
- InsecureRandom.disable method

### Changed

- Refreshed development dependency version requirements

### Fixed

- Bug where InsecureRandom.enable disabled afterward, even when not originally disabled

## [2.0.0] - 2024-04-13

### Added

- Support for Ruby versions 3.0, 3.1, and 3.2
- Ability to enable and disable repeatability
- RuboCop style linting

## [1.0.0] - 2013-05-03

Initial release!

[unreleased]: https://github.com/laserlemon/insecure_random/compare/v2.1.0...HEAD
[2.1.0]: https://github.com/laserlemon/insecure_random/compare/v2.0.0...v2.1.0
[2.0.0]: https://github.com/laserlemon/insecure_random/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/laserlemon/insecure_random/commits/v1.0.0
