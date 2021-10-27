#!/bin/bash
######################################################################
##
## Script name : getApach2backup.sh
## Create      : 2021.10.21 - 神場
## Update      : 2021.10.21 - 神場
## Char code   : UTF-8 (Non BOM)
## Output lang : ja-JP.UTF8
##
######################################################################

### Paramters & Variables settings ###################################

# Common configuration file
pCommonConf="${0%/*}/conf/common.conf"

if [ -f ${pCommonConf} ]; then
  . ${pCommonConf}
else
  echo "File not exist. (${pCommonConf})"
  exit 1
fi

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

# 実行ユーザ権限確認

if [ "${EUID:-${UID}}" != "${pCheckID}" ]; then
  echo "This script must be run as ${pCheckUser}"
  fnEnd 9 "${pCheckID} (${pCheckUser})"
fi

# 取得コマンドの実行
${cTAR} ${pTarOpt} -f ${pOutputZip} ${pGet}

### End Script #######################################################
fnParam pExitStatus "${pExitStatus}"
fnEnd ${pExitStatus}

######################################################################

