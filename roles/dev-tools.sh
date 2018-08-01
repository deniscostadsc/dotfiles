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

kickstart.mute groupadd docker || true
kickstart.mute sudo usermod -aG docker "$MYUSER" || true

kickstart.file.append_file_once files/dev-tools/bashrc_dev-tools.sh "$MYHOME/.bashrc"
