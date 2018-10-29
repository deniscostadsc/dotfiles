#!/bin/bash

kickstart.context 'Dev Tools'

# shellcheck source=recipes/bash.sh
source recipes/bash.sh
# shellcheck source=recipes/os.sh
source recipes/os.sh

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

! kickstart.os.is "Arch" && kickstart.package.install exuberant-ctags
kickstart.os.is "Arch" && kickstart.package.install ctags

kickstart.info "Copy dev-tools rc file"
kickstart.file.append_file_once files/dev-tools/bashrc_dev-tools.sh "$MYHOME/.bashrc"

kickstart.info "Copy zeal config file"
kickstart.file.mkdir_and_chown "$MYHOME/.config/Zeal/"
kickstart.file.copy files/dev-tools/zeal/* "$MYHOME/.config/Zeal/"
