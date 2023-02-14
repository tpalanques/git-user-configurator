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
source "$(system.getTestPath)"/*

#==========================================================================
#
#   DESCRIPTION:  Gets a list of test files in the test folder
#       PRIVACY:  PRIVATE
#         USAGE:  test.listFiles
#
#==========================================================================
test.listFiles() {
  system.listFolder "$(system.getTestPath)" | grep -v test.sh
  ## todo test.sh shouldn't be hardcoded
  #system.listFolder "$(system.getTestPath)" | grep -v "$(system.getOwnFilename)"
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
#         USAGE:  test.getTests
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

## todo document method
test.processStatus() {
  local status="${1}"
  local -n pass="${2}"
  local -n fail="${3}"
  local passString="Pass"

  if [[ "${status}" == *"${passString}"* ]]; then
    echo -e "[TEST][INFO] ${test} => $(font.green bold) Pass $(font.none)"
    ((pass++))
  else
    echo -e "$(font.red bold)[TEST][INFO] ${test} => Fail $(font.none)"
    ((fail++))
  fi
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

  echo -e "[TEST][INFO] Gathering tests..."
  tests=$(test.getAllTests)
  echo -e "[TEST][INFO] Running $(font.green bold)$(test.countAllTests) tests $(font.none)"
  for test in ${tests[*]}; do
    test.processStatus "$(${test})" passCount failCount
  done
  if [[ "${failCount}" -eq "0" ]]; then
    echo -e "[TEST][INFO] $(font.green bold) All ${passCount} tests passed $(font.none)"
  else
    echo -e "[TEST][INFO] $(font.red bold) ${failCount} tests failed $(font.none)"
  fi
}

test.run
