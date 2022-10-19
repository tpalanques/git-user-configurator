#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source system.sh

userConfig=$(system.getRootDir)/conf/user.cfg
userDefaultConfig=$(system.getRootDir)/default/user.cfg

configuration.read_file() {
  (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=__UNDEFINED__") | head -n 1 | cut -d '=' -f 2-
}

configuration.get() {
  local value

  value="$(configuration.read_file "$userConfig" "${1}")"
  if [ "$value" = "__UNDEFINED__" ]; then
    value="$(configuration.read_file "$userDefaultConfig" "${1}")"
  fi
  printf -- "%s" "${value}"
}

configuration.get name
configuration.get names
configuration.get extra

$SHELL
