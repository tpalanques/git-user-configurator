#!/bin/bash
#==========================================================================
#
#          FILE:  file.sh
#         USAGE:  source file.sh
#   DESCRIPTION:  tools to read and write files and from them
#
#==========================================================================

file.create() {
  local fullPath="${1}"
  local dirName
  dirName=$(file.getDirName "$1")

  if [ "$(file.fileExists "${fullPath}")" -eq "0" ]; then
    if [ "$(file.pathExists "${dirName}")" -eq "0" ]; then
      file.createFolder "${dirName}"
    fi
    touch "${fullPath}"
  fi
}

#==========================================================================
#
#   DESCRIPTION:  Creates a folder
#       PRIVACY:  PUBLIC
#         USAGE:  file.createFolder "${FOLDER_PATH}"
#          ARG1:  path where folder needs to be created
#
#==========================================================================
file.createFolder() {
  mkdir -p "$1"
}

#==========================================================================
#
#   DESCRIPTION:  Checks if a full path file exists and returns binary boolean information
#       PRIVACY:  PUBLIC
#         USAGE:  file.fileExists "${FILE_PATH}"
#          ARG1:  full path file to check
#        RETURN:  1 if full path file exists, 0 if it doesn't
#
#==========================================================================
file.fileExists() {
  if [[ -f "$1" ]]; then
    echo 1
  else
    echo 0
  fi
}

#==========================================================================
#
#   DESCRIPTION:  Gets a path's base name
#       PRIVACY:  PUBLIC
#         USAGE:  file.getBaseName "${FILE_PATH}"
#          ARG1:  path where to get the base name from
#
#==========================================================================
file.getBaseName() {
  basename "$1"
}

#==========================================================================
#
#   DESCRIPTION:  Gets a path's dir name
#       PRIVACY:  PUBLIC
#         USAGE:  file.getDirName "${FOLDER_PATH}"
#          ARG1:  path where to get the dir name from
#
#==========================================================================
file.getDirName() {
  dirname "$1"
}

#==========================================================================
#
#   DESCRIPTION:  Removes recursively a path
#       PRIVACY:  PUBLIC
#         USAGE:  file.removePath "${PATH}"
#          ARG1:  base path that needs to be removed
#
#==========================================================================
file.removePath() {
  rm -rf "$1"
}

#==========================================================================
#
#   DESCRIPTION:  Checks if path exists and returns binary boolean information
#       PRIVACY:  PUBLIC
#         USAGE:  file.pathExists "${DIRECTORY_PATH}"
#          ARG1:  path to check
#        RETURN:  1 if path exists, 0 if it doesn't
#
#==========================================================================
file.pathExists() {
  if [[ -d "$1" ]]; then
    echo 1
  else
    echo 0
  fi
}
