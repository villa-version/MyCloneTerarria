# MyCloneTerraria

A Terraria-inspired 2D game built with C++ and SFML 3.

## Getting Started

### Prerequisites

| Platform | Requirements |
|----------|-------------|
| **Windows** | [Git 2.0+](https://git-scm.com/) — everything else is installed automatically by `setup.ps1` |
| **Linux (Arch)** | `sudo pacman -S cmake base-devel git` |
| **Linux (Ubuntu/Debian)** | `sudo apt install cmake build-essential git libx11-dev libxrandr-dev libxcursor-dev libxi-dev libudev-dev libgl-dev libfreetype-dev libopenal-dev libflac-dev libvorbis-dev` |
| **macOS** | `xcode-select --install && brew install cmake git` |

### Build

**1. Clone the repo**
```bash
git clone https://github.com/villa-version/MyCloneTerarria.git
cd MyCloneTerarria
```

**2. Build SFML once** (takes a few minutes, only needed once per machine)

```bash
# Linux / macOS
make deps

# Windows (PowerShell) — installs CMake, VS Build Tools, builds SFML and the game
pwsh scripts/setup.ps1
```

**3. Build and run the game**

```bash
# Linux / macOS
make run

# Windows (PowerShell) — after setup.ps1 has been run once
cmake -B build -S . -G "Visual Studio 17 2022" -A x64
cmake --build build --config Release
build\Release\MyCloneTerraria.exe
```

> After the first `make deps` / `setup.ps1`, only your game sources are recompiled on each build — SFML is reused from `.deps/sfml-install/`.

## Development Workflow

### Auto-rebuild on save (Linux / macOS)

```bash
make dev
```

Watches `src/` for changes, rebuilds, and restarts the game automatically.

### Windows tip — faster builds with Ninja

```powershell
cmake -B build -S . -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel
build\MyCloneTerraria.exe
```

## Controls

| Key | Action |
|-----|--------|
| A | Move left |
| D | Move right |
| W | Jump |

## Project Structure

```
MyCloneTerraria/
├── src/            # Source and header files (.cpp / .h)
├── assets/         # Textures and sounds
├── scripts/        # setup.ps1 / build-deps.sh / build-deps.ps1 / dev.sh
└── CMakeLists.txt  # Build configuration
```

## License

[MIT](LICENSE)
