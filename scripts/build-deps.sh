#!/usr/bin/env bash
# Build and install SFML once into .deps/sfml-install/
# After this, cmake will use the pre-built version instead of compiling from source.
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SFML_SRC="${PROJECT_DIR}/.deps/sfml-src"
SFML_BUILD="${PROJECT_DIR}/.deps/sfml-build"
SFML_INSTALL="${PROJECT_DIR}/.deps/sfml-install"
SFML_TAG="3.0.2"
NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)

if [ -d "$SFML_INSTALL" ]; then
    echo "SFML already installed at $SFML_INSTALL"
    echo "Delete that folder to rebuild."
    exit 0
fi

if [ ! -d "$SFML_SRC" ]; then
    echo "Cloning SFML $SFML_TAG..."
    git clone --depth=1 --branch "$SFML_TAG" https://github.com/SFML/SFML.git "$SFML_SRC"
fi

echo "Building SFML (this happens once)..."
cmake -B "$SFML_BUILD" -S "$SFML_SRC" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$SFML_INSTALL" \
    -DSFML_BUILD_SHARED_LIBS=OFF \
    -DSFML_BUILD_EXAMPLES=OFF \
    -DSFML_BUILD_TEST_SUITE=OFF

cmake --build "$SFML_BUILD" --parallel "$NPROC"
cmake --install "$SFML_BUILD"

echo ""
echo "Done. Run 'make build' to build the game."
