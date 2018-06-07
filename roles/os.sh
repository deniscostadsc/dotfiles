#!/bin/bash

kickstart.context 'OS'

kickstart.info "Update OS"
kickstart.package.update
kickstart.package.upgrade

kickstart.os.is "Ubuntu" && {
    kickstart.info "Remove cached and unused packages"
    kickstart.mute apt -y autoclean
    kickstart.mute apt -y autoremove
}
