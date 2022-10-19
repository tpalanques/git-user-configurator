#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

getRootDir() {
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd
}
