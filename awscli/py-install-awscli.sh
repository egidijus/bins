#!/usr/bin/env bash

set -eE
# trace ERR through pipes
set -o pipefail errexit errtrace functrace

export VIRTUALENV_DIR=~/.virtualenv
export awscli_BIN_DIR=${VIRTUALENV_DIR}/awscli/bin
export LOCAL_BIN_DIR=~/.local/bin

SCRIPTPATH_ALTF="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

install_awscli(){
  cd ${VIRTUALENV_DIR}
  virtualenv -p python3 awscli
  ~/.virtualenv/awscli/bin/pip install -r ${SCRIPTPATH_ALTF}/requirements.txt
}

set -x

## WORKS
# [[ ! -d ${LOCAL_BIN_DIR} ]] && mkdir -p ${LOCAL_BIN_DIR}

find_awscli(){
  find ${awscli_BIN_DIR}/awscli* -type f -exec bash -c 'make_symlinks "$@"' bash {} \;
}

make_symlinks(){
  # ln -s 
  # 'myFunction "$@"'
  # ls -alsht $1
  # echo "locla bin ${LOCAL_BIN_DIR}"
  # echo "from $1 to ${LOCAL_BIN_DIR}/$( basename $1 )"
  ##
  if [[ ! -f ${LOCAL_BIN_DIR}/$(basename $1) ]]
  then
    ln -s $1 ${LOCAL_BIN_DIR}/$( basename $1 )
  fi
}

export -f find_awscli
export -f make_symlinks

install_awscli
find_awscli

set +x
