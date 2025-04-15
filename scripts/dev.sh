#!/bin/bash
set -euo pipefail

# scripts/dev.sh
# Launches full local development environment for both public site and admin (Decap CMS).
# - Starts Hugo server on port 1313
# - Starts Decap CMS proxy on port 8081
# - Opens admin and site UIs in the browser

# References:
# - Hugo: https://gohugo.io/commands/hugo_server/
# - Decap CMS local backend: https://decapcms.org/docs/beta-features/#working-with-a-local-git-repository

# Resolve script's directory regardless of the calling location
this_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
project_root="${this_dir}/.."

# Show all executed commands
set -x

cd "$project_root"

echo "Checking required tools..."
./scripts/check-dependencies.sh

echo "Installing Node.js dependencies..."
./scripts/setup.sh

# Automatically clean up port 8081 (Decap CMS proxy) if in use
PORT=8081
if lsof -i :"$PORT" &>/dev/null; then
  echo "⚠️ Port $PORT is already in use. Killing existing process..."
  kill -9 "$(lsof -t -i :"$PORT")" || true
fi

# Start Hugo dev server
echo "Starting Hugo server (localhost:1313)..."
./scripts/serve-site.sh &

# Start Decap CMS local backend proxy
echo "Starting Decap CMS proxy (localhost:8081)..."
./scripts/serve-admin.sh &

# Open both in browser
./scripts/open-site.sh
./scripts/open-admin.sh

# Wait for background jobs
wait
