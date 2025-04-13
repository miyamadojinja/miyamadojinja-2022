#!/bin/bash
set -euo pipefail

# Resolve script's directory regardless of the calling location
this_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
project_root="${this_dir}/.."

set -x

(
  cd "$project_root"
  npx decap-server
)
