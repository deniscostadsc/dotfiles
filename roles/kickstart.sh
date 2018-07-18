#!/bin/bash

kickstart.context 'Kickstart'

# shellcheck disable=SC1091
source recipes/bash.sh
# shellcheck disable=SC1091
source recipes/git.sh


kickstart.info "Install git"
kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa
kickstart.package.update
kickstart.package.install git

kickstart.git.cloneandpull https://github.com/bltavares/kickstart.git $MYHOME/.kickstart

kickstart.file.append_file_once files/kickstart/bashrc_kickstart.sh $MYHOME/.bashrc

kickstart.info "Create kickstart bin link"
kickstart.file.link $MYHOME/.kickstart/bin/kickstart $MYHOME/.bin/kickstart
