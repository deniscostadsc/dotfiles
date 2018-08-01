#!/bin/bash

kickstart.context 'GnuPG'

kickstart.package.update

kickstart.package.install gnupg2

kickstart.info "Copy GnuPG config files"
cp --preserve=mode,ownership files/gnupg/* "$MYHOME/.gnupg/"
