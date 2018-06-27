#!/bin/bash

download() {
  if which curl; then
    curl -sLO "$1"
  elif which wget; then
    wget -q "$1"
  else
    echo you dont have a tool to donwload files
    apt update
    apt install -y curl wget sudo
    download "$*"
    #exit 1
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
