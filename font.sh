#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

FONT_ESCAPE='\033['

font.print() {
  echo "${FONT_ESCAPE}$(font.bold "$@")"';'"${1}"''"$(font.underline "$@")"'m'
}

font.cyan() { font.print 36 "$@"; }
font.none() { font.print 39 "$@"; }
font.green() { font.print 32 "$@"; }
font.red() { font.print 31 "$@"; }
font.yellow() { font.print 33 "$@"; }

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
