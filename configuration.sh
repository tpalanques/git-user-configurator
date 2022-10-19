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
  local configName
  local configValue
  configName="${1}"

  configValue="$(configuration.read_file "$userConfig" "${configName}")"
  if [ "$configValue" = "__UNDEFINED__" ]; then
    configValue="$(configuration.read_file "$userDefaultConfig" "${configName}")"
  fi
  printf -- "%s" "${configValue}"
}

configuration.get name
configuration.get names
configuration.get extra

$SHELL
