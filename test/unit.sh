#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source ../font.sh

unit.error() {
  echo -e "$(font.red bold)""[ERROR]""$(font.none)""(unit) $*"
}

unit.warn() {
  echo -e "$(font.yellow bold)""[WARNING]""$(font.none)""(unit) $*"
}
