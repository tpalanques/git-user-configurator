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
  unit.assertEqual "$(file.pathExists ${path})" "1" "${FUNCNAME[0]}" "Folder ${path} is not present"

  # TearDown
    rm -rf ${basePath}
}

file.unit.create_a_folder
#file.unit.path_exists
#file.unit.remove_existing_path
