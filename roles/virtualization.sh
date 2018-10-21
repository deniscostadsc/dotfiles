#!/bin/bash

kickstart.context 'Virtualization'

# shellcheck source=recipes/virtualization.sh
source recipes/virtualization.sh

kickstart.package.update

kickstart.package.install virtualbox
kickstart.package.install_vagrant
