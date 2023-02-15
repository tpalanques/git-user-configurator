#!/bin/bash
THIS_PATH=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0)
DIR_PATH=$(dirname "${THIS_PATH}")
source "${DIR_PATH}/system.sh"

#==========================================================================
#
#          FILE:  font.sh
#         USAGE:  source font.sh
#   DESCRIPTION:  tools prettify terminal output
#
#==========================================================================

FONT_ESCAPE='\033['

#==========================================================================
#
#   DESCRIPTION:  Echos a message with the desired color and style
#       PRIVACY:  PRIVATE
#         USAGE:  font.bold ${COLOR} "${MESSAGE}"
#
#==========================================================================
font.print() {
  echo "${FONT_ESCAPE}$(font.bold "$@")"';'"${1}"''"$(font.underline "$@")"'m'
}

#==========================================================================
#
#   DESCRIPTION:  Echos a formatted message
#       PRIVACY:  PUBLIC
#         USAGE:  font.color bold "This is a cool bold message"
#          ARG1:  Style, may contain bold and/or underline
#          ARG2:  Message to be echoed
#
#==========================================================================
font.cyan() { font.print 36 "$@"; }
font.none() { font.print 39 "$@"; }
font.green() { font.print 32 "$@"; }
font.red() { font.print 31 "$@"; }
font.yellow() { font.print 33 "$@"; }

#==========================================================================
#
#   DESCRIPTION:  Echos 1 if option bold is enabled
#       PRIVACY:  PRIVATE
#         USAGE:  font.bold "$@"
#
#==========================================================================
font.bold() {
  while test $# -gt 0; do
    case "$1" in
    bold)
      echo "1" && exit
      ;;
    esac
    shift
  done
  echo "0"
}

#==========================================================================
#
#   DESCRIPTION:  Echos 1 if option underline is enabled
#       PRIVACY:  PRIVATE
#         USAGE:  font.bold "$@"
#
#==========================================================================
font.underline() {
  while test $# -gt 0; do
    case "$1" in
    underline)
      echo ";4" && exit
      ;;
    esac
    shift
  done
}
