#!/bin/bash
THIS_PATH=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
DIR_PATH=`dirname "${THIS_PATH}"`
source "${DIR_PATH}/../system.sh"

#==========================================================================
#
#          FILE:  unit.sh
#         USAGE:  source unit.sh
#   DESCRIPTION:  tools to write unit tests
#
#==========================================================================

source "$(system.getRootPath)"/font.sh
source "$(system.getRootPath)"/file.sh

#==========================================================================
#
#   DESCRIPTION:  Assert equality between 2 values
#       PRIVACY:  PUBLIC
#         USAGE:  unit.assetEqual "${VALUE_1}" "${VALUE_2}" "
#                 ${METHOD_NAME}" "${ERROR_MESSAGE}"
#          ARG1:  First value to check
#          ARG2:  Second value to check
#          ARG3:  Method that's calling the unit, this should default to
#                 ${FUNCNAME[0]}
#          ARG4:  Error message to be displayed if assertion fails
#
#==========================================================================
unit.assertEqual(){
  if [ "${1}" = "${2}" ]; then
    unit.info "${3}: Pass"
  else
    unit.error "in ${3}: ${4}"
  fi
}

#==========================================================================
#
#   DESCRIPTION:  Echos an error message
#       PRIVACY:  PRIVATE
#         USAGE:  unit.error "${ERROR_MESSAGE}"
#          ARG1:  Error message to be echoed
#
#==========================================================================
unit.error() {
  echo -e "[UNIT]$(font.red bold)""[ERROR]""$(font.none)"" $*"
}

#==========================================================================
#
#   DESCRIPTION:  Echos an error message
#       PRIVACY:  PRIVATE
#         USAGE:  unit.info "${INFO_MESSAGE}"
#          ARG1:  Info message to be echoed
#
#==========================================================================
unit.info() {
  echo -e "[UNIT]$(font.green bold)""[INFO]""$(font.none)"" $*"
}

#==========================================================================
#
#   DESCRIPTION:  Echos a warning message
#       PRIVACY:  PRIVATE
#         USAGE:  unit.warn "${WARNING_MESSAGE}"
#          ARG1:  Warning message to be echoed
#
#==========================================================================
unit.warn() {
  echo -e "[UNIT]$(font.yellow bold)""[WARNING]""$(font.none)"" $*"
}
