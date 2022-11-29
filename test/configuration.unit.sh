#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/../system.sh"

source "$(system.getTestPath)"/unit.sh
source "$(system.getRootPath)"/file.sh
source "$(system.getRootPath)"/configuration.sh

configuration_unit_basePath='/tmp/test'
configuration_unit_path="$configuration_unit_basePath/configuration_unit_config"

##TODO document this method
configuration.unit.buildFakeConfig() {
  file.create "${configuration_unit_path}"
  echo "name=Jane User" >"${configuration_unit_path}"
}

##TODO document this method
configuration.unit.deleteFakeConfig() {
  rm -rf ${configuration_unit_basePath}
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

configuration.unit.retrieve_a_non_existing_configuration() {
  # Arrange
  # create new config file in tmp path
  # Act (single line)
  # get configuration
  # Assert
  # configuration is "__UNDEFINED__"
  unit.assertEqual "1" "0" "${FUNCNAME[0]}" "Missing test implementation"
  # Tear down
  # remove configuration
}

configuration.unit.retrieve_an_existing_configuration_from_custom_file
configuration.unit.retrieve_an_existing_configuration_from_default_file
#configuration.unit.retrieve_a_non_existing_configuration
