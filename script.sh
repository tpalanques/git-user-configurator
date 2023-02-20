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
#   DESCRIPTION:  Gets formatted stack trace from given stack
#       PRIVACY:  PRIVATE
#         USAGE:  trace=$(script.getStackTrace "$(caller)")
#          ARG1:  Trace, tipically $(caller)
#
#==========================================================================
script.getStackTrace() {
  local givenParameters=$#
  local expectedParameters=1
  if [[ "${givenParameters}" == "${expectedParameters}" ]]; then
    echo -e "$(echo -e "${1}" | awk {'print $2":"$1'})"
    return 0
  else
    return 1
  fi
}

#==========================================================================
#
#   DESCRIPTION:  Checks number of arguments for a script. Throws error
#                 message to error bus if needed
#       PRIVACY:  PUBLIC
#         USAGE:  script.validateParameters 3 "$@"
#          ARG1:  Expected number of arguments
#          ARG2:  Should be fixed to "$@" to pass all received arguments
#      COMMENTS:  After calling this function you might want to check
#                 its results with:
#                     if [ $? -eq 0 ]; then
#
#==========================================================================
script.validateParameters() {
  local givenParameters=$#
  local expectedParameters=1
  local trace
  trace=$(script.getStackTrace "$(caller)")
  if [[ "${givenParameters}" -gt "${expectedParameters}" ]]; then
    local expectedParameters="${1}"
    shift 1
    givenParameters=$#
    if [[ "${givenParameters}" -eq "${expectedParameters}" ]]; then
      return 0
    fi
    error.invalidArgumentNumber "${trace}" "${expectedParameters}" "${givenParameters}"
    return 1
  else
    error.invalidArgumentNumber "${trace}" "unknown" "${givenParameters}"
    return 1
  fi
}
