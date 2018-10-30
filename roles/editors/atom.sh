#!/bin/bash

kickstart.context 'Editors/Atom'

# shellcheck source=recipes/os.sh
source recipes/os.sh

kickstart.package.install wget

! kickstart.command_exists atom && kickstart.os.is "Ubuntu" && {
    kickstart.info "Download Atom deb file"
    kickstart.mute wget https://atom.io/download/deb

    kickstart.info "Install Aton from deb"
    kickstart.mute dpkg -i deb || \
        kickstart.mute apt-get -f install -y && \
        kickstart.mute dpkg -i deb

    kickstart.info "Remove Atom file"
    rm deb

    kickstart.info "Install Atom plugins"
    kickstart.mute apm install --packages-file files/editors/atom/packages.txt
    kickstart.mute apm upgrade --no-confirm
}

kickstart.info "Copy Atom config file"
kickstart.file.mkdir_and_chown "$MYHOME/.atom/"
kickstart.file.copy files/editors/atom/config.cson "$MYHOME/.atom/"
