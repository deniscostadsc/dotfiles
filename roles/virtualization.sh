#!/bin/bash

kickstart.context 'Virtualization'

source recipes/virtualization.sh

kickstart.command_exists gpg || {
    echo "This role depends on GnuPG role"
    exit 1
}

kickstart.apt.add_key_from_url https://www.virtualbox.org/download/oracle_vbox_2016.asc
kickstart.apt.add_key_from_url https://www.virtualbox.org/download/oracle_vbox.asc

kickstart.package.update

kickstart.package.install virtualbox
kickstart.command_exists vagrant || kickstart.package.install_vagrant
