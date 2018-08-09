#!/bin/bash

kickstart.context 'GnuPG'

kickstart.package.update

kickstart.package.install gnupg2

kickstart.info "Copy GnuPG config files"
kickstart.file.mkdir_and_chown "$MYHOME/.gnupg/"
cp --preserve=mode,ownership files/gnupg/* "$MYHOME/.gnupg/"
