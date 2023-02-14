#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/../system.sh"

source "$(system.getTestPath)"/unit.sh
source "$(system.getRootPath)"/file.sh
source "$(system.getRootPath)"/configuration.sh

configuration_unit_basePath="/tmp/test"
configuration_unit_path="$configuration_unit_basePath/configuration_unit_config"

#==========================================================================
#
#   DESCRIPTION:  Builds a fake config file
#       PRIVACY:  PRIVATE
#         USAGE:  configuration.unit.buildFakeConfig
#
#==========================================================================
configuration.unit.buildFakeConfig() {
  file.create "${configuration_unit_path}"
  echo "name=Jane User" >"${configuration_unit_path}"
}

#==========================================================================
#
#   DESCRIPTION:  Deletes a fake config file
#       PRIVACY:  PRIVATE
#         USAGE:  configuration.unit.deleteFakeConfig
#
#==========================================================================
configuration.unit.deleteFakeConfig() {
  file.removePath ${configuration_unit_basePath}
}

configuration.unit.retrieve_a_non_existing_configuration() {
  local configName="undefined"
  local expectedValue="__UNDEFINED__"
  # Arrange
  configuration.unit.buildFakeConfig

  # Act (single line)
  configurationValue="$(configuration.get $configName $configuration_unit_path)"

  # Assert
  unit.assertEqual "${configurationValue}" "${expectedValue}" "${FUNCNAME[0]}" "Retrieved configuration ${configName} from ${configuration_unit_path} is wrong. We
  got '${configurationValue}' but '${expectedValue}' is expected."

  # TearDown
  configuration.unit.deleteFakeConfig
}

configuration.unit.retrieve_an_existing_configuration_from_custom_file() {
  local configName="name"
  local expectedValue="Jane User"
  # Arrange
  configuration.unit.buildFakeConfig

  # Act (single line)
  configurationValue="$(configuration.get $configName $configuration_unit_path)"

  # Assert
  unit.assertEqual "${configurationValue}" "${expectedValue}" "${FUNCNAME[0]}" "Retrieved configuration ${configName} from ${configuration_unit_path} is wrong. We
  got '${configurationValue}' but '${expectedValue}' is expected."

  # TearDown
  configuration.unit.deleteFakeConfig
}

configuration.unit.retrieve_an_existing_configuration_from_default_file() {
  local configName="email"
  local expectedValue="john@doe.com"
  # Arrange
  configuration.unit.buildFakeConfig

  # Act (single line)
  configurationValue="$(configuration.get $configName $configuration_unit_path)"

  # Assert
  unit.assertEqual "${configurationValue}" "${expectedValue}" "${FUNCNAME[0]}" "Retrieved configuration ${configName} from ${configuration_unit_path} is wrong. We
  got '${configurationValue}' but '${expectedValue}' is expected."

  # TearDown
  configuration.unit.deleteFakeConfig
}

configuration.unit.retrieve_a_non_existing_configuration
configuration.unit.retrieve_an_existing_configuration_from_custom_file
configuration.unit.retrieve_an_existing_configuration_from_default_file
