#!/bin/bash

kickstart.context 'Git'

# shellcheck disable=SC1091
source recipes/bash.sh
# shellcheck disable=SC1091
source recipes/python.sh

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa

kickstart.package.update

kickstart.package.install git
kickstart.package.install gitg
kickstart.package.install meld

kickstart.package.install_pyenv
#export PYENV_ROOT="$MYHOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

#kickstart.mute pip install -U gitlint

kickstart.info "Copy git config files"
cp --preserve=mode,ownership files/git/globalignore $MYHOME/.config/git/ignore
cp --preserve=mode,ownership files/git/gitconfig $MYHOME/.gitconfig

kickstart.info "Copy hook to git template folder"
kickstart.file.mkdir_and_chown $MYHOME/.git_template/hooks
cp --preserve=mode,ownership files/git/hooks/* $MYHOME/.git_template/hooks/

kickstart.file.append_file_once files/git/bashrc_git.sh $MYHOME/.bashrc
