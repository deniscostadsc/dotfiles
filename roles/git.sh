#!/bin/bash

kickstart.context 'Git'

source recipes/bash.sh
source recipes/python.sh

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa

kickstart.package.update

kickstart.package.install git
kickstart.package.install gitg
kickstart.package.install meld

kickstart.package.install_pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

kickstart.mute pip install -U gitlint

kickstart.info "Copy git config files"
cp --preserve=mode,ownership files/git/globalignore $HOME/.config/git/ignore
cp --preserve=mode,ownership files/git/gitconfig $HOME/.gitconfig

kickstart.info "Copy hook to git template folder"
kickstart.file.mkdir_and_chown $HOME/.git_template/hooks
cp --preserve=mode,ownership files/git/hooks/* $HOME/.git_template/hooks/

kickstart.file.append_file_once files/git/bashrc_git.sh $HOME/.bashrc
