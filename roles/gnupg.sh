#!/bin/bash

kickstart.context 'GnuPG'

# shellcheck source=recipes/os.sh
source recipes/os.sh

kickstart.package.update

kickstart.package.install gnupg2

kickstart.info "Copy GnuPG config files"
kickstart.file.mkdir_and_chown "$MYHOME/.gnupg/"
kickstart.file.copy files/gnupg/* "$MYHOME/.gnupg/"
