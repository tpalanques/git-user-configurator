#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

system.getRootPath() {
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd
}

system.getTestPath() {
  echo "$(system.getRootPath)/test"
}
