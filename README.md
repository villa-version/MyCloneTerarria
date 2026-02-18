# MyCloneTerraria

A Terraria-inspired 2D game built with C++ and SFML 3.

> SFML 3.0.2 is downloaded and compiled automatically on the first build — no manual installation needed.

## Windows

**Requirements:** [Visual Studio 2017+](https://visualstudio.microsoft.com/) (with *Desktop development with C++* workload) or [MinGW-w64 7+](https://www.mingw-w64.org/), [CMake 3.11+](https://cmake.org/download/), [Git 2.0+](https://git-scm.com/)

```cmd
git clone https://github.com/villa-version/MyCloneTerarria.git
cd MyCloneTerarria
cmake -B build
cmake --build build --config Release
build\Release\MyCloneTerraria.exe
```

## Linux

**Requirements:** GCC 7+ or Clang 5+, CMake 3.11+, Git 2.0+

```bash
# Arch
pacman -S cmake base-devel git

# Ubuntu / Debian
apt install cmake build-essential git
```

```bash
git clone https://github.com/villa-version/MyCloneTerarria.git
cd MyCloneTerarria
cmake -B build
cmake --build build
./build/MyCloneTerraria
```

## macOS

**Requirements:** Xcode Command Line Tools (Clang 5+), CMake 3.11+, Git 2.0+

```bash
xcode-select --install
brew install cmake git
```

```bash
git clone https://github.com/villa-version/MyCloneTerarria.git
cd MyCloneTerarria
cmake -B build
cmake --build build
./build/MyCloneTerraria
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
├── src/           # Source and header files (.cpp / .h)
├── assets/        # Textures and sounds
└── CMakeLists.txt # Build configuration
```

## License

[MIT](LICENSE)
