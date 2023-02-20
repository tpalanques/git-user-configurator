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
#   DESCRIPTION:  Throws an invalid argument number error to standard
#                 output
#       PRIVACY:  PUBLIC
#         USAGE:  error.invalidArgumentNumber 3 2
#          ARG1:  Thrower script name. This can be get from "$(system.getOwnFilename)"
#          ARG2:  Expected number of arguments
#
#==========================================================================
error.invalidArgumentNumber() {
  local functionGivenArguments=$#
  local functionExpectedArguments="3"
  if [[ "${functionGivenArguments}" == "${functionExpectedArguments}" ]]; then
    local trace=$1
    local expectedArguments=$2
    local givenArguments=$3
    if [[ "${expectedArguments}" == "unknown" ]]; then
      echo -e "[${trace}]$(font.red bold)[ERROR]$(font.none) Wrong arguments. Expected unknown, but ${givenArguments} given" >&2
      return 1
    fi
    if [[ "${givenArguments}" -gt "${expectedArguments}" ]]; then
      echo -e "[${trace}]$(font.red bold)[ERROR]$(font.none) Too much arguments. Expected ${expectedArguments}, but ${givenArguments} given" >&2
      return 1
    fi
    if [[ "${givenArguments}" -lt "${expectedArguments}" ]]; then
      echo -e "[${trace}]$(font.red bold)[ERROR]$(font.none) Some arguments missing. Expected ${expectedArguments}, but ${givenArguments} given" >&2
      return 1
    fi
    return 0
  else
    echo -e "$(font.red bold)[ERROR][ERROR] Can't throw invalidArgumentNumber error message, Invalid arguments. Expected ${functionExpectedArguments}, but $#
    given$(font.none)" >&2
    return 1
  fi
}

#==========================================================================
#
#   DESCRIPTION:  Throws an invalid argument number error to standard
#                 output
#       PRIVACY:  PUBLIC
#         USAGE:  error.pathDoesNotExist "/path/to/file"
#          ARG1:  Path that does not exist
#
#==========================================================================
error.pathDoesNotExist() {
  script.validateParameters "1" "$@"
  if [ $? == "0" ]; then
    local path=$1
    echo -e "[$(caller)]$(font.red bold)[ERROR]$(font.none) Path '${path}' does not exist" >&2
  fi
}

#==========================================================================
#
#   DESCRIPTION:  Throws a "no git project" error to standard output
#       PRIVACY:  PUBLIC
#         USAGE:  error.pathIsNotAGitProject "/path/to/file"
#          ARG1:  Path that is not a git project
#
#==========================================================================
error.pathIsNotAGitProject() {
  script.validateParameters "1" "$@"
  if [ $? == "0" ]; then
    local path=$1
    echo -e "[$(caller)]$(font.red bold)[ERROR]$(font.none) Path '${path}' is not a git project" >&2
  fi
}
