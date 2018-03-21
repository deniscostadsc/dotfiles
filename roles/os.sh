#!/bin/bash

kickstart.context 'OS'

kickstart.package.update
kickstart.package.upgrade

kickstart.info "Remove cached and unused packages"
kickstart.mute apt -y autoclean
kickstart.mute apt -y autoremove
