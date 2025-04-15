#!/bin/bash
set -euo pipefail
set -x

xdg-open http://localhost:1313 || open http://localhost:1313
