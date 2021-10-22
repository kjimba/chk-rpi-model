#!/bin/bash
######################################################################
##
## Script name : template.sh (要修正)
## Create      : yyyy.m.d - creator name
## Update      : yyyy.m.d - updater name
## Char code   : UTF-8 (Non BOM)
## Output lang : ja-JP.UTF8
##
######################################################################

### Paramters & Variables settings ###################################

# Common configuration file
. ${0%/*}/conf/common.conf

# Script configuration file
[ -f "${pConfig}" ] && . ${pConfig}

### Functions ########################################################

fnErrEnd() {
  # Script error
  case $1 in
    0 | "" ) fnInfo "Normal end.";;
    *  ) fnErr "Error, unknown error. (${2})";;
  esac
  fnMsg "Script end."
  exit "${pExitStatus}"
}

### Main Script ######################################################

fnLog "sample message."

### End Script #######################################################
fnParam pExitStatus "${pExitStatus}"
fnEnd ${pExitStatus}

######################################################################

