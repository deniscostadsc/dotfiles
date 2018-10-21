#!/bin/bash

kickstart.context 'Terminator'

# shellcheck source=recipes/os.sh
source recipes/os.sh

kickstart.package.update

kickstart.package.install terminator

kickstart.info "Copy Terminator config file"
kickstart.file.mkdir_and_chown "$MYHOME/.config/terminator/"
kickstart.file.copy files/terminator/config "$MYHOME/.config/terminator/"
