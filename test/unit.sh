#!/bin/bash
#==========================================================================
#
#          FILE:  unit.sh
#         USAGE:  source unit.sh
#   DESCRIPTION:  tools to write unit tests
#
#==========================================================================
set -euo pipefail
IFS=$'\n\t'

source ../font.sh

#==========================================================================
#
#   DESCRIPTION:  Echos an error message
#       PRIVACY:  PUBLIC
#         USAGE:  unit.error "${ERROR_MESSAGE}"
#          ARG1:  Error message to be echoed
#
#==========================================================================
unit.error() {
  echo -e "$(font.red bold)""[ERROR]""$(font.none)""(unit) $*"
}

#==========================================================================
#
#   DESCRIPTION:  Echos a warning message
#       PRIVACY:  PUBLIC
#         USAGE:  unit.warn "${WARNING_MESSAGE}"
#          ARG1:  Warning message to be echoed
#
#==========================================================================
unit.warn() {
  echo -e "$(font.yellow bold)""[WARNING]""$(font.none)""(unit) $*"
}

unit.warn "Some warning in here"
unit.error "Some error in here"
