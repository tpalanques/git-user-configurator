#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/../system.sh"

source "$(system.getTestPath)"/unit.sh
source "$(system.getRootPath)"/file.sh

file.unit.create_a_folder() {
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

file.unit.file_exists() {
  # Arrange
    local path="/etc/issue"

    # Assert
    unit.assertEqual "$(file.fileExists ${path})" "1" "${FUNCNAME[0]}" "File ${path} does not exist"
}

file.unit.file_does_not_exist() {
  # Arrange
      local path="/etc/issues"

      # Assert
      unit.assertEqual "$(file.fileExists ${path})" "0" "${FUNCNAME[0]}" "File ${path} does exist"
}

file.unit.folder_exists() {
  # Arrange
  local path="/tmp/"

  # Assert
  unit.assertEqual "$(file.pathExists ${path})" "1" "${FUNCNAME[0]}" "Folder ${path} does not exist"
}

file.unit.folder_does_not_exist() {
  # Arrange
  local path="/notExisting/"

  # Assert
  unit.assertEqual "$(file.pathExists ${path})" "0" "${FUNCNAME[0]}" "Folder ${path} does exist but it shouldn't"
}

file.unit.get_base_name_form_path() {
  # Arrange
  local path="/brand/new/path/fileName"
  local expectedFileName="fileName"

  # Assert
  unit.assertEqual "$(file.getBaseName ${path})" "${expectedFileName}" "${FUNCNAME[0]}" "Can't get expected file name ${expectedFileName} from ${path}"
}

file.unit.get_dir_name_form_path() {
  # Arrange
  local path="/brand/new/path/fileName"
  local expectedPath="/brand/new/path"

  # Assert
  unit.assertEqual "$(file.getDirName ${path})" "${expectedPath}" "${FUNCNAME[0]}" "Can't get expected dirname ${expectedPath} from ${path}"
}

file.unit.remove_an_existing_folder() {
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
file.unit.file_exists
file.unit.file_does_not_exist
file.unit.folder_exists
file.unit.folder_does_not_exist
file.unit.get_base_name_form_path
file.unit.get_dir_name_form_path
file.unit.remove_an_existing_folder
