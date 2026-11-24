# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [6.0.5] - Unreleased

### Added

- `docker-compose.yml` - the Quickstart example as a file you can copy.

### Changed

- FreshRSS updated to 1.31.0 - see the
  [FreshRSS changelog](https://github.com/FreshRSS/FreshRSS/blob/1.31.0/CHANGELOG.md). It fixes a number of
  security issues, and changes how the login password is checked.

### Fixed

- README: the Quickstart is now numbered steps, and its example now includes the MariaDB database it connects to.
- README: the Quickstart keeps its passwords in `.env`, and FreshRSS and MariaDB read the same `DB_PASSWORD`, so
  the two can't differ.

## [6.0.4] - 2026-11-20

### Changed

- Base image updated to `bfren/nginx-php` 10.0.4, which updates PHP to 8.5.13 - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).

## [6.0.3] - 2026-11-18

### Changed

- Base image updated to `bfren/nginx-php` 10.0.3, which moves to `bfren/nginx` 9.0.3 and nginx 1.30.7 - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).

## [6.0.2] - 2026-11-10

### Changed

- Base image updated to `bfren/nginx-php` 10.0.2, which moves to `bfren/nginx` 9.0.2 and Nushell 0.117.0 - your own
  Nushell scripts may need changes - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).

## [6.0.1] - 2026-11-06

### Changed

- Base image updated to `bfren/nginx-php` 10.0.1, which moves to Alpine 3.24.4 (with security fixes) and
  rebuilds BusyBox, figlet and Nushell - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).

## [6.0.0] - 2026-11-05

### Changed

- **Breaking:** base image updated to `bfren/nginx-php` 10.0.0 - see the
  [Nginx + PHP changelog](https://github.com/bfren/docker-nginx-php/blob/main/CHANGELOG.md).
  `bf env set` must now run as root.
- Images are built and published by the shared `bfren/docker` build workflow (`build.yml`), replacing the separate
  `dev.yml` and `publish.yml` workflows.

[6.0.5]: https://github.com/bfren/docker-freshrss/compare/v6.0.4...v6.0.5
[6.0.4]: https://github.com/bfren/docker-freshrss/compare/v6.0.3...v6.0.4
[6.0.3]: https://github.com/bfren/docker-freshrss/compare/v6.0.2...v6.0.3
[6.0.2]: https://github.com/bfren/docker-freshrss/compare/v6.0.1...v6.0.2
[6.0.1]: https://github.com/bfren/docker-freshrss/compare/v6.0.0...v6.0.1
[6.0.0]: https://github.com/bfren/docker-freshrss/compare/v5.2.6...v6.0.0
