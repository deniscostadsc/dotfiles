#!/bin/bash

download() {
  if which curl > /dev/null 2>&1; then
    curl -sLO "$1"
  elif which wget > /dev/null 2>&1; then
    wget -q "$1"
  else
    echo "You dont have a tool to donwload files"
    echo "Installing wget and curl"
    generic_update
    generic_install curl wget
    download "$*"
  fi
}

install_temporarily_kickstart() {
    cd "$(mktemp -d)" || exit 1
    download https://github.com/bltavares/kickstart/archive/master.zip
    generic_install unzip
    unzip master.zip
    export PATH=${PWD}/kickstart-master/bin:$PATH
    cd - || exit 1
}
