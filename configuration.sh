#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/system.sh"

#==========================================================================
#
#          FILE:  configuration.sh
#         USAGE:  source configuration.sh
#   DESCRIPTION:  tools to read and write configuration files
#
#==========================================================================

userConfigPath=$(system.getRootPath)/conf/user.cfg
defaultConfigPath=$(system.getRootPath)/default/user.cfg

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
  script.validateParameters "$(system.getOwnFilename)" 2 "$@"
  (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=__UNDEFINED__") | head -n 1 | cut -d '=' -f 2-
}

#==========================================================================
#
#   DESCRIPTION:  Reads configuration from the user configuration or from
#                 the default file if it couldn't be found
#       PRIVACY:  PUBLIC
#         USAGE:  configuration.get "${CONFIGURATION_NAME}"
#          ARG1:  Configuration name to get
#        [ARG2]:  Configuration file where to get config from
#
#==========================================================================
configuration.get() {
  # FIXME: no parameter check is done in here
  local configPath="${2:-$userConfigPath}"
  local configName="${1}"
  local configValue

  configValue="$(configuration.readFile "$configPath" "${configName}")"
  if [ "$configValue" = "__UNDEFINED__" ]; then
    configValue="$(configuration.readFile "$defaultConfigPath" "${configName}")"
  fi
  echo "${configValue}"
}
