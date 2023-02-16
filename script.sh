#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/system.sh"

#==========================================================================
#
#          FILE:  script.sh
#         USAGE:  source script.sh
#   DESCRIPTION:  class contains some script helpers
#
#==========================================================================

#==========================================================================
#
#   DESCRIPTION:  Checks number of arguments for a script. Throws error
#                 message to error bus if needed
#       PRIVACY:  PUBLIC
#         USAGE:  script.validateParameters "$(system.getOwnFilename)" 3 "$@"
#          ARG1:  Checking script name. This can be get from "$(system.getOwnFilename)"
#          ARG2:  Expected number of arguments
#          ARG2:  Should be fixed to "$@" to pass all received arguments
#      COMMENTS:  After calling this function
#
#==========================================================================
script.validateParameters() {
  local givenParameters=$#
  local expectedParameters=2
  if [[ "${givenParameters}" -gt "${expectedParameters}" ]]; then
    local scriptName="${1}"
    local expectedParameters="${2}"
    shift 2
    givenParameters=$#
    if [[ "${givenParameters}" -eq "${expectedParameters}" ]]; then
      return 0
    fi
    error.invalidArgumentNumber "${scriptName}" "${expectedParameters}" "${givenParameters}"
    return 1
  else
    error.invalidArgumentNumber "$(system.getOwnFilename)" "unknown" "${givenParameters}"
    return 1
  fi
}
