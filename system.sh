#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

system.getRootDir() {
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd
}
