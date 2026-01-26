# Contributing to MyCloneTerraria

## Setting Up Development Environment

### Linux (Debian/Ubuntu)
```bash
sudo apt update
sudo apt install -y build-essential cmake qtbase5-dev libqt5widgets5 libsfml-dev
```

### Building
```bash
mkdir build && cd build
cmake ..
make
./MyCloneTerraria
```

## Code Style

- **File naming**: PascalCase for classes (e.g., `Player.h`, `Player.cpp`)
- **Method naming**: camelCase (e.g., `init()`, `update()`)
- **Variables**: camelCase
- **Constants**: SCREAMING_SNAKE_CASE
- **Indentation**: 4 spaces (no tabs)
- **Header guards**: Use `#pragma once`

## Cross-Platform Requirements

- Use relative paths for assets (e.g., `../assets/textures/`)
- Be aware of case-sensitive filenames on Linux
- Test on both Windows and Linux if possible
- Use CMake conditionals for platform-specific code:
  ```cmake
  if(WIN32)
      # Windows-specific
  endif()
  ```

## Commit Guidelines

- Write clear, descriptive commit messages
- One logical change per commit
- Follow conventional commits format when possible:
  - `feat: Add new feature`
  - `fix: Fix bug description`
  - `refactor: Improve code structure`
  - `docs: Update documentation`

## Pull Request Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Make your changes following code style guidelines
4. Test on both Windows and Linux if possible
5. Commit with clear messages
6. Push to your fork
7. Open a pull request with description of changes

## Areas Open for Contribution

- Physics system implementation (currently stubbed)
- Collision detection
- Jump mechanics (input exists but not implemented)
- World generation/terrain
- More player actions
- Menu system
- Game states (pause, game over, etc.)
- Sound effects and music
- Improved error handling

## Release Process

This project uses automated releases via GitHub Actions.

### How It Works

1. **Continuous Integration**: Every push to `main` triggers builds on Linux and Windows
2. **Automated Releases**: Creating a version tag triggers release builds and packages binaries

### Creating a Release

Only maintainers can create releases. To create a new release:

```bash
# Make sure you're on main branch and up to date
git checkout main
git pull

# Create and push a version tag
git tag v1.0.0
git push origin v1.0.0
```

The GitHub Actions workflow will:
1. Build the project on Linux and Windows
2. Package executables with assets
3. Create a GitHub Release
4. Upload `.tar.gz` (Linux) and `.zip` (Windows) files

### Version Numbering

Follow [Semantic Versioning](https://semver.org/):
- `v1.0.0` - Major release (breaking changes)
- `v1.1.0` - Minor release (new features, backwards compatible)
- `v1.1.1` - Patch release (bug fixes)

### CI/CD Workflows

- **`.github/workflows/build.yml`** - Runs on every push/PR to validate builds
- **`.github/workflows/release.yml`** - Runs on version tags to create releases
