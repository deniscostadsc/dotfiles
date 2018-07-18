#!/bin/bash

kickstart.context 'Dev Tools'

kickstart.package.update

kickstart.package.install curl
kickstart.package.install docker.io
kickstart.package.install htop
kickstart.package.install jq
kickstart.package.install shellcheck
kickstart.package.install tree
kickstart.package.install wget

kickstart.file.append_file_once files/tmux/bashrc_dev-tools.sh $HOME/.bashrc
