#!/bin/bash
#
# This script executes commands common to all jobs.
#
# This script is licensed under CC0 1.0 Universal.
# https://creativecommons.org/publicdomain/zero/1.0/

set -euo pipefail

patch --forward methods.py "$CI_PROJECT_DIR/patches/always_tty.patch"
