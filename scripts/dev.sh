#!/usr/bin/env bash
# Dev workflow: build, run, watch for changes and restart
# Supports Linux and macOS. On Windows use WSL or Git Bash.
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="$PROJECT_DIR/build"
SRC_DIR="$PROJECT_DIR/src"
BINARY="$BUILD_DIR/MyCloneTerraria"
GAME_PID=""

# Portable CPU count
NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)

# Portable stat: output "filename mtime" per file
if [[ "$(uname)" == "Darwin" ]]; then
    stat_mtime() { stat -f "%N %m" "$1"; }
else
    stat_mtime() { stat -c "%n %Y" "$1"; }
fi

build() {
    echo "[dev] Building..."
    cmake -B "$BUILD_DIR" -S "$PROJECT_DIR" -DCMAKE_BUILD_TYPE=Debug 2>&1 \
        || { echo "[dev] cmake configure failed"; return 1; }
    cmake --build "$BUILD_DIR" --parallel "$NPROC" 2>&1 \
        || { echo "[dev] build failed"; return 1; }
    echo "[dev] Build complete."
}

start_game() {
    if [ ! -f "$BINARY" ]; then
        echo "[dev] Binary not found: $BINARY"
        return 1
    fi
    echo "[dev] Starting game..."
    cd "$BUILD_DIR"
    "$BINARY" &
    GAME_PID=$!
    cd "$PROJECT_DIR"
    echo "[dev] Game PID: $GAME_PID"
}

stop_game() {
    if [ -n "$GAME_PID" ] && kill -0 "$GAME_PID" 2>/dev/null; then
        echo "[dev] Stopping game (PID $GAME_PID)..."
        kill "$GAME_PID" 2>/dev/null || true
        wait "$GAME_PID" 2>/dev/null || true
        GAME_PID=""
    fi
}

cleanup() {
    echo "[dev] Shutting down..."
    stop_game
    exit 0
}
trap cleanup INT TERM

# Initial build and launch
if build; then
    start_game
fi

echo "[dev] Watching $SRC_DIR for changes..."

get_snapshot() {
    find "$SRC_DIR" -type f \( -name "*.cpp" -o -name "*.h" \) | sort | \
        while IFS= read -r f; do stat_mtime "$f"; done
}

SNAPSHOT=$(get_snapshot)

while true; do
    sleep 1

    # Check if game exited on its own
    if [ -n "$GAME_PID" ] && ! kill -0 "$GAME_PID" 2>/dev/null; then
        echo "[dev] Game exited."
        GAME_PID=""
    fi

    NEW_SNAPSHOT=$(get_snapshot)
    if [ "$NEW_SNAPSHOT" != "$SNAPSHOT" ]; then
        SNAPSHOT="$NEW_SNAPSHOT"
        echo "[dev] Change detected, rebuilding..."
        stop_game
        if build; then
            start_game
        fi
    fi
done
