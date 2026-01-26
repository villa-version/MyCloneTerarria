# MyCloneTerraria

A Terraria-inspired 2D sandbox game built with C++, SFML, and Qt.

![Build Status](https://github.com/villa-version/MyCloneTerarria/workflows/Build/badge.svg)

## Features

- 2D sprite-based rendering
- Player movement controls
- Camera system that follows the player
- Texture management system
- Cross-platform support (Windows, Linux)

## Installation

### Pre-built Binaries

Download the latest release for your platform from the [Releases page](https://github.com/villa-version/MyCloneTerarria/releases).

**Linux:**
```bash
tar -xzf MyCloneTerraria-linux-x64.tar.gz
cd MyCloneTerraria
./MyCloneTerraria
```

**Windows:**
1. Extract `MyCloneTerraria-windows-x64.zip`
2. Run `MyCloneTerraria.exe`

### Building from Source

#### Linux (Debian/Ubuntu)

```bash
# Install dependencies
sudo apt-get update
sudo apt-get install -y build-essential cmake qtbase5-dev libqt5widgets5 libsfml-dev

# Build
mkdir build && cd build
cmake ..
make

# Run
./MyCloneTerraria
```

#### Windows

1. Install [Qt 5.15+](https://www.qt.io/download)
2. Install [SFML 2.5+](https://www.sfml-dev.org/download.php)
3. Build with CMake:
```cmd
mkdir build
cd build
cmake .. -G "MinGW Makefiles"
cmake --build .
MyCloneTerraria.exe
```

## Controls

- **A** - Move left
- **D** - Move right
- **Space** - Jump (planned)

## Project Structure

```
MyCloneTerraria/
├── src/              # Source files
├── headers/          # Header files
├── assets/           # Game assets (textures, sounds)
├── build/            # Build output (gitignored)
└── CMakeLists.txt    # CMake configuration
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on how to contribute to this project.

## Development Roadmap

- [ ] Physics system implementation
- [ ] Collision detection
- [ ] Jump mechanics
- [ ] World generation and terrain
- [ ] Block placement/destruction
- [ ] Inventory system
- [ ] Menu and UI
- [ ] Multiplayer support

## License

[Add your license here]

## Credits

Developed by the MyCloneTerraria team.
