#!/bin/bash
set -euo pipefail

# Resolve script's directory regardless of the calling location
this_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
project_root="${this_dir}/.."

set -x

function command_exists {
  if command -v "$1" >/dev/null 2>&1; then
    echo "✓ $1 exists"
  else
    echo "✗ $1 not installed"
    return 1
  fi
}

echo "Checking required tools..."
command_exists hugo && hugo version
command_exists node && node --version
command_exists npm && npm --version
