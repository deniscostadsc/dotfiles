#!/bin/bash

kickstart.context 'Kickstart'

source recipes/bash.sh
source recipes/git.sh


kickstart.info "Install git"
kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa
kickstart.package.update
kickstart.package.install git

kickstart.git.cloneandpull https://github.com/bltavares/kickstart.git $HOME/.kickstart

kickstart.file.append_file_once files/kickstart/bashrc_kickstart.sh $HOME/.bashrc

kickstart.info "Create kickstart bin link"
kickstart.file.link $HOME/.kickstart/bin/kickstart $HOME/.bin/kickstart
