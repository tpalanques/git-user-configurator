#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/../system.sh"

source "$(system.getTestPath)"/unit.sh
source "$(system.getRootPath)"/script.sh

script.unit.dont_validate_invalid_call() {
  # Arrange
  local expectedParameters="3"
  local parameters="first second"

  # Act
  script.validateParameters "$(system.getOwnFilename)" "${expectedParameters}" ${parameters} 2>/dev/null

  # Assert
  unit.assertEqual "$?" "1" "${FUNCNAME[0]}" "Script validates '${parameters}' when ${expectedParameters} parameters are expected"
}

script.unit.validate_valid_call() {
  # Arrange
  local expectedParameters="3"
  local parameters="first second third"

  # Act
  script.validateParameters "$(system.getOwnFilename)" "${expectedParameters}" ${parameters} 2>/dev/null

  # Assert
  unit.assertEqual "$?" "0" "${FUNCNAME[0]}" "Script validates '${parameters}' when ${expectedParameters} parameters are expected"
}
