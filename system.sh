#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

getRootDir() {
  echo "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
}
