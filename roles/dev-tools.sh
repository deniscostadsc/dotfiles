#!/bin/bash

kickstart.context 'Dev Tools'

# shellcheck source=recipes/bash.sh
source recipes/bash.sh
# shellcheck source=recipes/os.sh
source recipes/os.sh
# shellcheck source=recipes/flatpak.sh
source recipes/flatpak.sh

kickstart.info "Install flatpak"
kickstart.package.install_flatpak


kickstart.package.update

kickstart.package.install curl
kickstart.package.install htop
kickstart.package.install jq
kickstart.package.install meld
kickstart.package.install shellcheck
kickstart.package.install tree
kickstart.package.install wget
kickstart.package.install whois
kickstart.package.install zeal
flatpak install -y flathub io.dbeaver.DBeaverCommunity

! kickstart.os.is "Arch" && kickstart.package.install caffeine

! kickstart.os.is "Arch" && kickstart.package.install exuberant-ctags
kickstart.os.is "Arch" && kickstart.package.install ctags

kickstart.info "Copy caffeine config file"
kickstart.file.mkdir_and_chown "$MYHOME/.config/autostart/"
kickstart.file.copy files/dev-tools/caffeine-indicator.desktop "$MYHOME/.config/autostart/"

kickstart.info "Copy dev-tools rc file"
kickstart.file.append_file_once files/dev-tools/bashrc_dev-tools.sh "$MYHOME/.bashrc"

kickstart.info "Copy zeal config file"
kickstart.file.mkdir_and_chown "$MYHOME/.config/Zeal/"
kickstart.file.copy files/dev-tools/zeal/* "$MYHOME/.config/Zeal/"
