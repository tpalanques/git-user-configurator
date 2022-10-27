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

file.createFolder(){
  mkdir -p "$1"
}

#file.create(){
  #split path string by last /
#    file.createFolder
#    touch file
#}

#file.remove(){
  # rm file
#}

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

#file.createFolder /home/Toni/PhpstormProjects/git-user-configurator/new/file/path
#file.pathExists /home/Toni/PhpstormProjects/git-user-configurator/new/file/path
#file.pathExists /home/Toni/PhpstormProjects/git-user-configurator/new/file/paths
#file.removePath /home/Toni/PhpstormProjects/git-user-configurator/new
