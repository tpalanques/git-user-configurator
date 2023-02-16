#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/system.sh"

#==========================================================================
#
#          FILE:  error.sh
#         USAGE:  source error.sh
#   DESCRIPTION:  class contains functions to throw standard output errors
#
#==========================================================================

source "$(system.getRootPath)/font.sh"
source "$(system.getRootPath)/script.sh"

#==========================================================================
#
#   DESCRIPTION:  Throws an invalid argument number error to the standard
#                 output
#       PRIVACY:  PUBLIC
#         USAGE:  error.invalidArgumentNumber "$(system.getOwnFilename)" 3 2
#          ARG1:  Thrower script name. This can be get from "$(system.getOwnFilename)"
#          ARG2:  Expected number of arguments
#      COMMENTS:  Given number of arguments
#
#==========================================================================
error.invalidArgumentNumber() {
  local functionExpectedArguments="3"
  valid=$(script.validateParameters "${functionExpectedArguments}" "$@")
  if [[ "${valid}" == "1" ]]; then
    local scriptName=$1
    shift
    local expectedArguments=$1
    shift
    local givenArguments=$1
    shift
    if [[ "${givenArguments}" -gt "${expectedArguments}" ]]; then
      echo -e "[${scriptName}]$(font.red bold)[ERROR]$(font.none) Too much arguments. Expected ${expectedArguments}, ${givenArguments} given"
    fi
    if [[ "${givenArguments}" -lt "${expectedArguments}" ]]; then
      echo -e "[${scriptName}]$(font.red bold)[ERROR]$(font.none) Some arguments missing. Expected ${expectedArguments}, ${givenArguments} given"
    fi
  else
    echo -e "$(font.red bold)[ERROR][ERROR] Can't throw error message, Invalid arguments. Expected ${functionExpectedArguments}, $# given$(font.none)"
  fi
}
