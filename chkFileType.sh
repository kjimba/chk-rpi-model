#/bin/bash
######################################################################
##
## Script name : chkFileType.sh
## Create      : 2021.10.25 -  神場
## Update      : 2021.10.28 -  神場
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

# Output ---------------------------------------------------

# output file

### Functions ########################################################


### Main Script ######################################################

## リスト作成 ----------------------------------------------
for p in ${PATH//:/ }; do
  fnNotice "### ${p}"
  list2="${list2} $(ls ${p}/* 2>/dev/null)"
done
list=$(echo "${list2}" | grep "^/" | grep -v ":$")

## 種別判定 ------------------------------------------------
for str in ${list}; do
  fnInfo "## ${str}"
  filetype=$(file "${str}")
  nCount=$(( ${nCount} + 1))
  case ${filetype##*: } in
    ELF* )
      nELF=$(( ${nELF} + 1))
      ;;
    "POSIX shell script"* )
      nShell=$(( ${nShell} + 1))
      ;;
    "Bourne-Again shell script"* )
      nBShell=$(( ${nBShell} + 1))
      ;;
    "Perl script"* )
      nPerl=$(( ${nPerl} + 1))
      ;;
    "Python script"* )
      nPython=$(( ${nPython} + 1))
      ;;
    "symbolic link"* )
      nSLink=$(( ${nSLink} + 1))
      ;;
    * )
      nOther=$(( ${nOther} + 1))
      fnNotice ${filetype##*: }
      langlist="${langlist}${pRC}${filetype%%,*}"
      ;;
  esac
done

## 結果出力 ------------------------------------------------

fnDebug "Output ${pLangList}"
echo "${langlist}" | sort -u > ${pLangList}

echo "=============================="
echo "Compile type: ${nELF}"
echo "Perl script: ${nPerl}"
echo "Sh script: ${nShell}"
echo "Bash  script: ${nBShell}"
echo "Python: ${nPython}"
echo "Symbolic link: ${nSLink}"
echo "Other: ${nOther}"
echo "=============================="
echo "All: ${nCount}"
echo ""


### End Script #######################################################
exit 0

######################################################################

