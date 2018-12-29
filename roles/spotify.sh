#!/bin/bash

kickstart.context 'Spotify'

# shellcheck source=recipes/flatpak.sh
source recipes/flatpak.sh

kickstart.info "Install flatpak"
kickstart.package.install_flatpak

kickstart.info "Install spotify"
flatpak install -y flathub com.spotify.Client

kickstart.info "Install spotify desktop file"
kickstart.file.copy files/spotify/spotify.desktop "/usr/share/applications/"
