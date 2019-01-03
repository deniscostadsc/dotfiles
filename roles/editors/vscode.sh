#!/bin/bash

kickstart.context 'Editors/VSCode'

# shellcheck source=recipes/flatpak.sh
source recipes/flatpak.sh

kickstart.info "Install flatpak"
kickstart.package.install_flatpak

kickstart.info "Install vscode"
flatpak install -y flathub com.visualstudio.code
