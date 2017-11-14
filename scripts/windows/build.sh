#!/bin/bash
#
# This script compiles Godot for Windows using MinGW.
#
# This script is licensed under CC0 1.0 Universal.
# https://creativecommons.org/publicdomain/zero/1.0/

set -euo pipefail

# Execute commands common to all jobs
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$DIR/common.sh"

# Number of CPU threads to use (automatically detected from system)
THREADS="$(nproc)"

# Directory where Godot binaries are located after compiling
GODOT_BIN_DIR="$CI_PROJECT_DIR/godot/bin"

# Build Godot editor or templates, depending on the first command-line argument

if [ "$1" == "editor" ]; then
  scons platform=windows bits=64 tools=yes target=release_debug use_lto=yes -j$THREADS
  scons platform=windows bits=32 tools=yes target=release_debug use_lto=yes -j$THREADS
  cp "$GODOT_BIN_DIR/godot.windows.opt.tools.64.exe" "$ARTIFACTS_PATH"
  cp "$GODOT_BIN_DIR/godot.windows.opt.tools.32.exe" "$ARTIFACTS_PATH"
fi

if [ "$1" == "templates" ]; then
  scons platform=windows bits=64 tools=no target=release_debug use_lto=yes -j$THREADS
  scons platform=windows bits=32 tools=no target=release_debug use_lto=yes -j$THREADS
  scons platform=windows bits=64 tools=no target=release use_lto=yes -j$THREADS
  scons platform=windows bits=32 tools=no target=release use_lto=yes -j$THREADS
  cp "$GODOT_BIN_DIR/godot.windows.opt.debug.64.exe" "$ARTIFACTS_PATH"
  cp "$GODOT_BIN_DIR/godot.windows.opt.debug.32.exe" "$ARTIFACTS_PATH"
  cp "$GODOT_BIN_DIR/godot.windows.opt.64.exe" "$ARTIFACTS_PATH"
  cp "$GODOT_BIN_DIR/godot.windows.opt.32.exe" "$ARTIFACTS_PATH"
fi
