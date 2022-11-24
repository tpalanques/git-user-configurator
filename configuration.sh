#!/bin/bash
#==========================================================================
#
#          FILE:  configuration.sh
#         USAGE:  source configuration.sh
#   DESCRIPTION:  tools to read and write configuration files
#
#==========================================================================

source system.sh

userConfig=$(system.getRootPath)/conf/user.cfg
userDefaultConfig=$(system.getRootPath)/default/user.cfg

#==========================================================================
#
#   DESCRIPTION:  Reads configuration in a given file. If not found string
#                 "__UNDEFINED__" is echoed
#       PRIVACY:  PRIVATE
#         USAGE:  configuration.readFile "${CONFIGURATION_FILE}" "${CONFIGURATION_NAME}"
#          ARG1:  File where to get configuration from
#          ARG2:  Configuration name to get
#
#==========================================================================
configuration.readFile() {
  (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=__UNDEFINED__") | head -n 1 | cut -d '=' -f 2-
}

#==========================================================================
#
#   DESCRIPTION:  Reads configuration from the user configuration or from
#                 the default file if it couldn't be found
#       PRIVACY:  PUBLIC
#         USAGE:  configuration.get "${CONFIGURATION_NAME}"
#          ARG2:  Configuration name to get
#
#==========================================================================
configuration.get() {
  local configName
  local configValue
  configName="${1}"

  configValue="$(configuration.readFile "$userConfig" "${configName}")"
  if [ "$configValue" = "__UNDEFINED__" ]; then
    configValue="$(configuration.readFile "$userDefaultConfig" "${configName}")"
  fi
  echo "${configValue}"
}
