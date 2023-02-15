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

source "$(system.getRootPath)/font.sh"

#==========================================================================
#
#   DESCRIPTION:  Checks number of arguments for a script. After calling
#                 this function you should probably check the returned
#                 value in order to throw an error if it's not 1.
#       PRIVACY:  PUBLIC
#         USAGE:  script.validateParameters 3 "$@"
#          ARG1:  Expected number of arguments
#          ARG2:  Should be fixed to "$@" to pass all received arguments
#      COMMENTS:  After calling this function
#
#==========================================================================
script.validateParameters() {
  local totalParameters=$#
  if [[ "${totalParameters}" -gt "0" ]]; then
    local expectedParameters="${1}"
    shift
    totalParameters=$#
    if [[ "${totalParameters}" -eq "${expectedParameters}" ]]; then
      echo 1
    else
      echo 0
    fi
  else
    echo -e "$(font.red bold underline)[SCRIPT][ERROR] Some missing parameters $(font.none)"
  fi
}
