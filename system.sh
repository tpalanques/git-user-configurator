#!/bin/bash
#==========================================================================
#
#          FILE:  system.sh
#         USAGE:  source system.sh
#   DESCRIPTION:  tools to get system parameters
#
#==========================================================================

#==========================================================================
#
#   DESCRIPTION:  Gets root path for this project
#       PRIVACY:  PUBLIC
#         USAGE:  system.getRootPath
#
#==========================================================================
system.getRootPath() {
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd
}

#==========================================================================
#
#   DESCRIPTION:  Gets test path for this project
#       PRIVACY:  PUBLIC
#         USAGE:  system.getTestPath
#
#==========================================================================
system.getTestPath() {
  echo "$(system.getRootPath)/test"
}
