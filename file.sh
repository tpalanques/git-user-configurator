#!/bin/bash
#==========================================================================
#
#          FILE:  file.sh
#         USAGE:  source file.sh
#   DESCRIPTION:  tools to read and write files and from them
#
#==========================================================================

#file.append(){
  # echo string >> filePath
#}

#==========================================================================
#
#   DESCRIPTION:  Creates a folder
#       PRIVACY:  PUBLIC
#         USAGE:  file.createFolder "${FOLDER_PATH}"
#          ARG1:  path where folder needs to be created
#
#==========================================================================
file.createFolder(){
  mkdir -p "$1"
}

#file.create(){
  #split path string by last /
  # check folder existance
      # if not file.createFolder
      # else do nothing
  # touch file
#}

#==========================================================================
#
#   DESCRIPTION:  Removes recursively a path
#       PRIVACY:  PUBLIC
#         USAGE:  file.removePath "${PATH}"
#          ARG1:  base path that needs to be removed
#
#==========================================================================
file.removePath(){
   rm -rf "$1"
}

#==========================================================================
#
#   DESCRIPTION:  Checks if path exists and returns binary boolean information
#       PRIVACY:  PUBLIC
#         USAGE:  file.pathExists "${FILE_PATH}"
#          ARG1:  path to check
#        RETURN:  1 if path extists, 0 if it doesn't
#
#==========================================================================
file.pathExists(){
  if [[ -d "$1" ]]
  then
    echo 1
  else
    echo 0
  fi
}
#file.write(){
#   echo string > filePath
#}
