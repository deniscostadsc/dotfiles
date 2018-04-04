#!/bin/bash

kickstart.context 'Editors/Atom'

kickstart.package.install wget

kickstart.command_exists atom || {
    kickstart.info "Download Atom deb file"
    kickstart.mute wget https://atom.io/download/deb

    kickstart.info "Install Aton from deb"
    kickstart.mute apt install deb
    rm deb
}

kickstart.info "Install Atom plugins"
kickstart.mute apm install --packages-file files/editors/atom/packages.txt
kickstart.mute apm upgrade

kickstart.info "Copy Atom config file"
cp --preserve=mode,ownership files/editors/atom/config.cson ~/.atom/

