# Contributing to flutter_widget_kit

Thank you for your interest in contributing! We follow a strict monorepo structure and branching strategy to maintain high quality.

## Repository Structure

- `packages/flutter_widget_kit`: The runtime Flutter plugin.
- `packages/flutter_widget_kit_generator`: The `build_runner` code generator.
- `packages/flutter_widget_kit_cli`: Standalone CLI tool.
- `apps/example`: Example application for testing and demonstration.

## Branching Strategy

- `main`: Always mirrors the latest published version on pub.dev.
- `develop`: Integration branch. All features merge here first.
- `feature/*`: Individual features, branch from `develop`.
- `fix/*`: Bug fixes, branch from `develop`.
- `release/v*`: Stabilization branches cut from `develop`.
- `hotfix/*`: Branches from `main` for critical production issues.

## Conventional Commits

We enforce [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:`: A new feature
- `fix:`: A bug fix
- `docs:`: Documentation changes
- `chore:`: Maintenance tasks
- `refactor:`: Code changes that neither fix a bug nor add a feature
- `test:`: Adding or correcting tests
- `perf:`: Performance improvements
- `ci:`: CI/CD configuration changes

Breaking changes must be marked with a `!` or `BREAKING CHANGE:` in the footer.

## Development Setup

1. Install FVM: `dart pub global activate fvm`
2. Install the Flutter version: `fvm install`
3. Install Melos: `fvm dart pub global activate melos`
4. Bootstrap the workspace: `fvm melos bootstrap`
5. Run code generation: `fvm melos run build`
6. Run tests: `fvm melos run test`

**Important**: Locally, always prefix `melos` with `fvm` (e.g., `fvm melos analyze`) to ensure you are using the version of Dart/Flutter specified in `.fvmrc`. The CI environment handles this automatically.
