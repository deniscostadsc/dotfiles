#!/bin/bash

kickstart.context 'Git'

source recipes/bash.sh

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa

kickstart.package.update

kickstart.package.install git
kickstart.package.install gitg
kickstart.package.install meld

kickstart.info "Copy git config files"
cp --preserve=mode,ownership files/git/globalignore ~/.config/git/ignore
cp --preserve=mode,ownership files/git/gitconfig ~/.gitconfig

kickstart.info "Copy hook to git template folder"
kickstart.mute mkdir -p ~/.git_template/hooks || true
cp --preserve=mode,ownership files/git/hooks/* ~/.git_template/hooks/

kickstart.file.append_once ~/.bashrc ""
kickstart.file.append_once ~/.bashrc "# Git - added by kickstart"

kickstart.info "Add aliases to bashrc"
kickstart.file.append_once ~/.bashrc "alias git-remove-branchs='git branch -D \$(git branch | grep -v \"*\\|master\")'"

kickstart.info "Add functions to bashrc"
# shellcheck disable=SC2016
kickstart.file.append_once ~/.bashrc 'function __git_arrows {
    git rev-parse --abbrev-ref @"{u}" &>/dev/null || return
    local branch_status

    branch_status="$(git rev-list --left-right --count HEAD...@"{u}" 2>/dev/null)"

    [ $? == 0 ] || return
    local left_arrow
    local right_arrow

    left_arrow=$(echo $branch_status | cut -f 1 -d " ")
    right_arrow=$(echo $branch_status | cut -f 2 -d " ")

    local arrows
    [ $left_arrow != 0 ] && arrows="⇡"
    [ $right_arrow != 0 ] && arrows="${arrows}⇣"

    echo $arrows
}'

# shellcheck disable=SC2016
kickstart.file.append_once ~/.bashrc 'function __git_branch {
    echo -n "$(git branch 2>/dev/null | grep "^*" | sed "s/* //g")"
}'
