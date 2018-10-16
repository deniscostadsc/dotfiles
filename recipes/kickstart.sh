#!/bin/bash

# shellcheck disable=SC1091
source recipes/os.sh

download() {
  generic_update
  if ! command -v curl > /dev/null 2>&2 && ! command -v wget > /dev/null 2>&1; then
    echo "You dont have a tool to donwload files"
    echo "Installing wget and curl"
    generic_install curl
    generic_install wget
  fi
  if command -v curl > /dev/null 2>&1; then
    curl -sLO "$1"
  elif command -v wget > /dev/null 2>&1; then
    wget -q "$1"
  else
    download "$1"
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
