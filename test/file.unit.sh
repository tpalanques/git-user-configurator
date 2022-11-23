#!/bin/bash
THIS_PATH=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
DIR_PATH=`dirname "${THIS_PATH}"`
source "${DIR_PATH}/../system.sh"

source "$(system.getTestPath)"/unit.sh
source "$(system.getRootPath)"/file.sh

file.unit.create_a_folder(){
  # Arrange
  local path="/tmp/test/file_unit_create_folder/new/folder"
  local basePath="/tmp/test"
  rm -rf ${basePath}

  # Act
  file.createFolder "${path}"

  # Assert
  unit.assertEqual "$(file.pathExists ${path})" "1" "${FUNCNAME[0]}" "Folder ${path} is not present but we created it"

  # TearDown
    rm -rf ${basePath}
}

file.unit.folder_exists(){
  # Arrange
  local path="/tmp/"

  # Assert
  unit.assertEqual "$(file.pathExists ${path})" "1" "${FUNCNAME[0]}" "Folder ${path} does not exist"
}

file.unit.folder_does_not_exist(){
  # Arrange
  local path="/notExisting/"

  # Assert
  unit.assertEqual "$(file.pathExists ${path})" "0" "${FUNCNAME[0]}" "Folder ${path} does exist but it shouldn't"
}

file.unit.remove_an_existing_folder(){
  # Arrange
  local path="/tmp/test/file_unit_create_folder/new/folder"
  local basePath="/tmp/test"
  mkdir -p ${basePath}

  # Act
  file.removePath "${path}"

  # Assert
  unit.assertEqual "$(file.pathExists ${path})" "0" "${FUNCNAME[0]}" "Folder ${path} is present but we removed it"

  # TearDown
    rm -rf ${basePath}
}

file.unit.create_a_folder
file.unit.folder_exists
file.unit.folder_does_not_exist
file.unit.remove_an_existing_folder
