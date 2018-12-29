#!/bin/bash

kickstart.context 'Dropbox'

# shellcheck source=recipes/flatpak.sh
source recipes/flatpak.sh

kickstart.info "Install flatpak"
kickstart.package.install_flatpak

kickstart.info "Install dropbox"
flatpak install -y flathub com.dropbox.Client
