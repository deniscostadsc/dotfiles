#!/bin/bash

kickstart.context 'Editors/Atom'

# shellcheck source=recipes/flatpak.sh
source recipes/flatpak.sh

kickstart.info "Install flatpak"
kickstart.package.install_flatpak

kickstart.info "Install atom"
flatpak install -y flathub io.atom.Atom
