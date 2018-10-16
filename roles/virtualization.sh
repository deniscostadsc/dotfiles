#!/bin/bash

kickstart.context 'Virtualization'

# shellcheck disable=SC1091
source recipes/virtualization.sh

kickstart.package.update

kickstart.package.install virtualbox
kickstart.package.install_vagrant
