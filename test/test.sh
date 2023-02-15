#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/../system.sh"

#==========================================================================
#
#          FILE:  test.sh
#         USAGE:  . test.sh
#   DESCRIPTION:  script to run bash tests
#

#==========================================================================

source "$(system.getRootPath)"/font.sh

#==========================================================================
#
#   DESCRIPTION:  Gets a list of test files in the test folder
#       PRIVACY:  PRIVATE
#         USAGE:  test.listFiles
#
#==========================================================================
test.listFiles() {
  # FIXME: test.sh shouldn't be hardcoded, we should be able to use the following code
  #system.listFolder "$(system.getTestPath)" | grep -v "$(system.getOwnFilename)"
  system.listFolder "$(system.getTestPath)" | grep -v test.sh

}

#==========================================================================
#
#   DESCRIPTION:  Gets a list of all test in the test folder
#       PRIVACY:  PRIVATE
#         USAGE:  test.getAllTests
#
#==========================================================================
test.getAllTests() {
  files="$(test.listFiles)"
  for file in ${files[*]}; do
    test.getTests "${file}"
  done
}

#==========================================================================
#
#   DESCRIPTION:  Counts all tests in the test folder
#       PRIVACY:  PRIVATE
#         USAGE:  test.countAllTests
#
#==========================================================================
test.countAllTests() {
  echo "$(test.getAllTests)" | wc -l
}

#==========================================================================
#
#   DESCRIPTION:  Gets a list of tests in a unit test file
#       PRIVACY:  PRIVATE
#         USAGE:  test.getTests
#
#==========================================================================
test.getTests() {
  cat "$(system.getTestPath)"/"$1" | grep "() {" | grep "_" | awk {'sub("\() {","");print $1'}
}

## After this there's 2 options. Either you continue with the project or you start a refactor to check minimum required variables
#==========================================================================
#
#   DESCRIPTION:  Echoes test result. Increments passCounter if passString
#                 is found or failCounter if it isn't
#       PRIVACY:  PRIVATE
#         USAGE:  test.processStatus
#          ARG1:  Status message
#          ARG2:  (ref) passCounter
#          ARG3:  (ref) failCounter
#
#==========================================================================
test.processStatus() {
  local status="${1}"
  local -n pass="${2}"
  local -n fail="${3}"
  local passString="Pass"

  if [[ "${status}" == *"${passString}"* ]]; then
    echo -e "[TEST][INFO] ${test} => $(font.green bold) Pass $(font.none)"
    ((pass++))
  else
    echo -e "$(font.red bold underline)\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t$(font.none)"
    echo -e "$(font.red bold)[TEST][INFO] ${test} => Fail $(font.none)"
    echo -e "${status}"
    echo -e "$(font.red bold underline)\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t$(font.none)"
    echo -e ""
    ((fail++))
  fi
}

test.sourceTestFiles() {
  local ownFileName
  ownFileName="$(system.getOwnFilename)"

  for testFile in $(test.listFiles); do
    local fullFileName
    fullFileName=$(system.getTestPath)/${testFile}
    if [[ "${fullFileName}" != *"${ownFileName}"* ]]; then
      source "${fullFileName}"
    fi
  done
}

#==========================================================================
#
#   DESCRIPTION:  Runs all tests in the test folder
#       PRIVACY:  PUBLIC
#         USAGE:  test.getTests
#
#==========================================================================
test.run() {
  local passCount=0
  local failCount=0

  echo -e "[TEST][INFO] Sourcing test files..."
  test.sourceTestFiles
  echo -e "[TEST][INFO] Gathering tests..."
  tests=$(test.getAllTests)
  echo -e "[TEST][INFO] Running $(font.green bold)$(test.countAllTests) tests $(font.none)"
  for test in ${tests[*]}; do
    test.processStatus "$(${test})" passCount failCount
  done
  if [[ "${failCount}" -eq "0" ]]; then
    echo -e "$(font.green bold underline)[TEST][INFO] All ${passCount} tests passed$(font.none)"
  else
    echo -e "$(font.red bold underline)[TEST][INFO]${failCount} tests failed $(font.none)"
  fi
}

test.run
