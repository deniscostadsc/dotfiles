#!/bin/bash

kickstart.context 'Editors/Atom'

kickstart.package.install wget

kickstart.command_exists atom || {
    kickstart.info "Download Atom deb file"
    kickstart.mute wget https://atom.io/download/deb

    kickstart.info "Install Aton from deb"
    kickstart.mute dpkg -i deb || apt-get -f install && dpkg -i deb
    rm deb
}

kickstart.info "Install Atom plugins"
kickstart.mute apm install --packages-file files/editors/atom/packages.txt
kickstart.mute apm upgrade --no-confirm

kickstart.info "Copy Atom config file"
cp --preserve=mode,ownership files/editors/atom/config.cson $MYHOME/.atom/
