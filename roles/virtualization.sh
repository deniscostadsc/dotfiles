#!/bin/bash

kickstart.context 'Virtualization'

source recipes/virtualization.sh

kickstart.package.install gnupg2

kickstart.apt.add_key_from_url https://www.virtualbox.org/download/oracle_vbox_2016.asc
kickstart.apt.add_key_from_url https://www.virtualbox.org/download/oracle_vbox.asc

kickstart.package.update

kickstart.package.install virtualbox
kickstart.package.install_vagrant
