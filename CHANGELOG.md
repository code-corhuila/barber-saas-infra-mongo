# Changelog

All notable changes to `barber-saas-infra-mongo` are recorded here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-10-08

MVP 2 (corte 2): first release of this repository to `main`, promoted from `develop` through `qa`
with `git cherry-pick -x` (norm 10–11).

User stories: code-corhuila/barber-saas-docs#5.

### Added

- **mongo:** define the single MongoDB instance and its domain users

### Fixed

- **mongo:** run mongo-init only on demand, in the tooling profile
- keep the container scripts with LF line endings

[2.0.0]: https://github.com/code-corhuila/barber-saas-infra-mongo/releases/tag/v2.0.0
