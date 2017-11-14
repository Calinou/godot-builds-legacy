#!/bin/bash
#
# This script packages Godot for Windows using InnoSetup.
#
# This script is licensed under CC0 1.0 Universal.
# https://creativecommons.org/publicdomain/zero/1.0/

# FIXME: Update the script to work with GitLab CI

set -euo pipefail

# Execute commands common to all jobs
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$DIR/common.sh"

# InnoSetup compiler path (requires WINE)
wget "https://media.hugo.pro/innosetup-5.5.9-unicode.zip"
unzip "innosetup-5.5.9-unicode.zip"
ISCC="$HOME/innosetup/ISCC.exe"

# Generate Windows installers
cd "$INSTALLER_PATH"
cp "$GODOT_PATH/bin/godot.windows.opt.tools.64.exe" "godot.exe"
wine "$ISCC" "godot.iss"
cp "$GODOT_PATH/bin/godot.windows.opt.tools.32.exe" "godot.exe"
wine "$ISCC" "godot.iss" /DApp32Bit

# Move installers to the artifacts path
cp "$INSTALLER_PATH/Output/godot-windows-installer-x86_64.exe" "$ARTIFACTS_PATH"
cp "$INSTALLER_PATH/Output/godot-windows-installer-x86.exe" "$ARTIFACTS_PATH"
