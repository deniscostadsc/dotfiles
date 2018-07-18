#!/bin/bash

download() {
  if which curl; then
    curl -sLO "$1"
  elif which wget; then
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
    apt install -y unzip
    unzip master.zip
    export PATH=${PWD}/kickstart-master/bin:$PATH
    cd - || exit 1
}
