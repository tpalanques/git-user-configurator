#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/../system.sh"

source "$(system.getTestPath)"/unit.sh
source "$(system.getRootPath)"/file.sh

system.unit.list_existing_folder() {
  # Arrange
  local path="/tmp/test/system_unit_list_folder/"

  local basePath="/tmp/test"
  rm -rf ${basePath}

  local subPath1="${basePath}/system_unit_list_folder/firstFolder"
  local subPath2="${basePath}/system_unit_list_folder/secondFolder"
  local subPath3="${basePath}/system_unit_list_folder/thirdFolder"
  file.createFolder "${subPath1}"
  file.createFolder "${subPath2}"
  file.createFolder "${subPath3}"

  local expectedList
  expectedList=$(echo -e "firstFolder"'\n'"secondFolder"'\n'"thirdFolder")

  # Act
  local folderList
  folderList="$(system.listFolder ${path})"

  # Assert
  unit.assertEqual "${folderList}" "${expectedList}" "${FUNCNAME[0]}" "List folder ${path} returned ${folderList}"

  # TearDown
  rm -rf ${basePath}
}
