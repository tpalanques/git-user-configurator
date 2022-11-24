#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/../system.sh"

source "$(system.getTestPath)"/unit.sh
source "$(system.getRootPath)"/file.sh
source "$(system.getRootPath)"/configuration.sh

configuration.unit.retrieve_an_existing_configuration() {
  # Arrange
  local configPath="/tmp/test/configuration_unit_config"
  local configName="configName"
  local configValue="config value"
  local basePath='/tmp/test'
  file.create "${configPath}"
  echo "${configName}=${configValue}" >"${configPath}"

  # Act (single line)
  configuration="$(configuration.get $configName)"

  # Assert
  unit.assertEqual "${configuration}" "${configValue}" "${FUNCNAME[0]}" "Retrieved configuration ${configName} from ${configPath} is wrong. We
  got '${configuration}' but '${configValue}' is expected.
  expected"

  # TearDown
  rm -rf ${basePath}
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

configuration.unit.retrieve_an_existing_configuration
#configuration.unit.retrieve_a_non_existing_configuration
