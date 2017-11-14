#!/bin/bash
#
# This script installs dependencies depending on the base image (Fedora or Ubuntu).
#
# This script is licensed under CC0 1.0 Universal.
# https://creativecommons.org/publicdomain/zero/1.0/

set -euo pipefail

if [ -f "/etc/redhat-release" ]; then
  # Fedora
  dnf update -y
  dnf install -y git cmake ruby scons pkgconfig wget gcc-c++ libX11-devel libXcursor-devel \
                 libXrandr-devel libXinerama-devel mesa-libGL-devel \
                 alsa-lib-devel pulseaudio-libs-devel freetype-devel \
                 openssl-devel libudev-devel mesa-libGLU-devel
else
  # Ubuntu
  apt-get update -y
  apt-get install -y openssh-client git cmake wget ruby build-essential scons \
                     pkg-config libx11-dev libxcursor-dev libxinerama-dev \
                     libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev \
                     libfreetype6-dev libssl-dev libudev-dev libxrandr-dev
fi
