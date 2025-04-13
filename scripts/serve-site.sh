#!/bin/bash
set -euo pipefail

# Resolve script's directory regardless of the calling location
this_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
project_root="${this_dir}/.."

set -x

# Start Hugo server from the site directory
hugo server -s "$project_root/site"
