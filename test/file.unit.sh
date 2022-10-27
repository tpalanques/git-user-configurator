#!/bin/bash

source unit.sh
source ../file.sh

file.unit.create_a_folder(){
  # Arrange
  local path="/tmp/test/file_unit_create_folder/new/folder"
  local basePath="/tmp/test"
  rm -rf ${basePath}

  # Act
  file.createPath "${path}"

  # Assert
  unit.assertEqual "$(file.pathExists ${path})" "1" "${FUNCNAME[0]}" "Folder ${path} is not present but we created it"

  # TearDown
    rm -rf ${basePath}
}

file.unit.path_exists(){
  # Arrange
  local path="/tmp/"

  # Assert
  unit.assertEqual "$(file.pathExists ${path})" "1" "${FUNCNAME[0]}" "Folder ${path} does not exist"
}

file.unit.path_does_not_exist(){
  # Arrange
  local path="/notExisting/"

  # Assert
  unit.assertEqual "$(file.pathExists ${path})" "0" "${FUNCNAME[0]}" "Folder ${path} does exist but it shouldn't"
}

file.unit.create_a_folder
file.unit.path_exists
file.unit.path_does_not_exist
#file.unit.remove_existing_path
