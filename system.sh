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
  if [[ ! -v ROOT_PATH ]]; then
    local ROOT_PATH=''
  fi
  ( cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd ; echo "${ROOT_PATH}"; ) | tr -d '\n'
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

#==========================================================================
#
#   DESCRIPTION:  Sets the root path to be appended to the root execution
#                 directory to find the root path
#       PRIVACY:  PUBLIC
#         USAGE:  system.setRootPath "/my/root/path"
#          ARG1:  New root path
#
#==========================================================================
system.setRootPath() {
  export ROOT_PATH=$1
}
