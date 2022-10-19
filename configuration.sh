#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

source system.sh

userConfig=$(getRootDir)/conf/user.cfg
userDefaultConfig=$(getRootDir)/default/user.cfg

read_file() {
  (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=__UNDEFINED__") | head -n 1 | cut -d '=' -f 2-
}

get() {
  local value

  value="$(read_file $userConfig "${1}")"
  if [ "$value" = "__UNDEFINED__" ]; then
    value="$(read_file $userDefaultConfig "${1}")"

  fi
  printf -- "%s" "${value}"
}

get name
get names
get extra

$SHELL
