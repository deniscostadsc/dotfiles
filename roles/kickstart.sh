#!/bin/bash

kickstart.context 'Kickstart'

source recipes/bash.sh
source recipes/git.sh


kickstart.info "Install git"
kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa
kickstart.package.update
kickstart.package.install git

kickstart.git.cloneandpull https://github.com/bltavares/kickstart.git ~/.kickstart

kickstart.file.append_once ~/.bashrc ""
kickstart.file.append_once ~/.bashrc "# Kickstart - added by kickstart"

kickstart.info "Add code complete to bash"
# shellcheck disable=SC2016
kickstart.file.append_once ~/.bashrc 'eval "$(kickstart autocomplete)"'

kickstart.info "Create kickstart bin link"
kickstart.file.link ~/.kickstart/bin/kickstart ~/.bin/kickstart
