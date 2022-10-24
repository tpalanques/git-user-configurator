#!/bin/bash
#==========================================================================
#
#          FILE:  configuration.sh
#         USAGE:  source test.sh
#   DESCRIPTION:  tools to read and write configuration files
#
#==========================================================================
set -euo pipefail
IFS=$'\n\t'

source system.sh

userConfig=$(system.getRootPath)/conf/user.cfg
userDefaultConfig=$(system.getRootPath)/default/user.cfg

#==========================================================================
#
#   DESCRIPTION:  Reads configuration in a given file
#       PRIVACY:  PRIVATE
#         USAGE:  system.getRootPath "${CONFIGURATION_NAME}"
#          ARG1:  File where to get configuration from
#          ARG2:  Configuration name to get
#
#==========================================================================
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
  echo "${configValue}"
}

configuration.get name
configuration.get names
configuration.get extra

$SHELL
