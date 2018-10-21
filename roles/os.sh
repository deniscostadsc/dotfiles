#!/bin/bash

kickstart.context 'OS'

kickstart.info "Update OS"
kickstart.package.update
echo "DEBUG"
kickstart.package.upgrade

#kickstart.info "Install find and which for Fedora"
#kickstart.os.is "RHEL" && kickstart.package.install which

kickstart.os.is "Ubuntu" && {
    kickstart.info "Remove cached and unused packages"
    kickstart.mute apt -y autoclean
    kickstart.mute apt -y autoremove
}
