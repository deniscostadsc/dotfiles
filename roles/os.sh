#!/bin/bash

kickstart.context 'OS'

# shellcheck source=recipes/flatpak.sh
source recipes/flatpak.sh

kickstart.info "Install flatpak"
kickstart.package.install_flatpak

kickstart.info "Update OS"
kickstart.package.update
kickstart.package.upgrade
flatpak update

#kickstart.info "Install find and which for Fedora"
#kickstart.os.is "RHEL" && kickstart.package.install which

kickstart.os.is "Ubuntu" && {
    kickstart.info "Remove cached and unused packages"
    kickstart.mute apt -y autoclean
    kickstart.mute apt -y autoremove
}


kickstart.file.mkdir_and_chown "$MYHOME/projects"
