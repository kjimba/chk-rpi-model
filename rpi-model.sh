#!/bin/bash
######################################################################
##
## Script name : rpi-model.sh
## Create      : 2021.9.23 - kjimba
## Char code   : UTF-8 (Non BOM)
## Output lang : ja-JP.UTF8
##
######################################################################

### Paramters & Variables settings ###################################

# Database file
pDBFile=rpimodel.dat

# https://elinux.org/RPi_HardwareHistory
pDB="$(/bin/cat ${pDBFile})"

# Exit Status
pExitStatus=0

### Functions ########################################################

fnMsg() {
    /usr/bin/logger -t "${0}" "$*"
}

fnEnd() {
    case $1 in
        0 | "" ) fnMsg "Info, Normal end.";;
        10 ) fnMsg "Error, File not exist. (${2})";;
        11 ) fnMsg "Error, Permission read not exist. (${2})";;
        12 ) fnMsg "Error, Permission write not exist. (${2})";;
        13 ) fnMsg "Error, Permission exec not exist. (${2})";;
        15 ) fnMsg "Error, Directory not exist. (${2})";;
        *  ) fnMsg "Error, unknown error. (${2})";;
    esac
    fnMsg "##### ${0##*/} End. #############"
    exit "${1}"
}

### Main Script ######################################################
fnMsg "Script start."

pRevision=$(grep Revision /proc/cpuinfo | /usr/bin/cut -d ":" -f 2)
tExitStatus=$?

if [ "${tExitStatus}" -eq "0" ]; then
  pDataLine=$(echo "${pDB}" | grep ${pRevision})

  pRevision=$(    echo ${pDataLine} | /usr/bin/cut -d "," -f 1)
  pReleaseDate=$( echo ${pDataLine} | /usr/bin/cut -d "," -f 2)
  pModel=$(       echo ${pDataLine} | /usr/bin/cut -d "," -f 3)
  pPCBRevision=$( echo ${pDataLine} | /usr/bin/cut -d "," -f 4)
  pMemory=$(      echo ${pDataLine} | /usr/bin/cut -d "," -f 5)
  pNotes=$(       echo ${pDataLine} | /usr/bin/cut -d "," -f 6)

  echo "リビジョン     : ${pRevision}"
  echo "リリース日     : ${pReleaseDate}"
  echo "モデル番号     : Raspberry Pi ${pModel}"
  echo "PCB リビジョン : ${pPCBRevision}"
  echo "メモリサイズ   : ${pMemory}"
  echo "備考           : ${pNotes}"
else
  echo "Unknown."
fi

### End Script #######################################################
fnEnd ${pExitStatus}

######################################################################

