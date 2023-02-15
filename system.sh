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
#   DESCRIPTION:  Gets the filename of the calling script
#       PRIVACY:  PUBLIC
#         USAGE:  system.getOwnFilename
#
#==========================================================================
system.getOwnFilename() {
  caller | awk {'print $2'}
}

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
#   DESCRIPTION:  Lists files in a folder
#       PRIVACY:  PUBLIC
#         USAGE:  system.listFolder "/folder/to/list"
#          ARG1:  Folder to list
#
#==========================================================================
system.listFolder() {
  ls "$1"
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

#==========================================================================
#
#   DESCRIPTION:  Source multiple given files
#       PRIVACY:  PUBLIC
#         USAGE:  system.source "/my/first/script.sh" "/my/second/script"
#         ARG N:  script list
#
#==========================================================================
system.source(){
  for testFile in $(test.listFiles); do
      source "${testFile}"
  done
}
