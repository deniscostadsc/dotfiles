#!/bin/bash

kickstart.context 'Terminator'

kickstart.package.update

kickstart.package.install terminator

kickstart.info "Copy Terminator config file"
kickstart.file.mkdir_and_chown "$MYHOME/.config/terminator/"
cp --preserve=mode,ownership files/terminator/config "$MYHOME/.config/terminator/"
