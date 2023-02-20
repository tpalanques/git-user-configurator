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
  (
    cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd
    echo "${ROOT_PATH}"
  ) | tr -d '\n'
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
  script.validateParameters "$(system.getOwnFilename)" 1 "$@"
  ls "$1" 2>/dev/null
  return $?
}

#==========================================================================
#
#   DESCRIPTION:  Source multiple given files
#       PRIVACY:  PUBLIC
#         USAGE:  system.source "/my/first/script.sh" "/my/second/script"
#         ARG N:  script list
#
#==========================================================================
system.source() {
  # FIXME: add parameter check
  for testFile in $(test.listFiles); do
    source "${testFile}"
  done
}
