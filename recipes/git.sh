#!/bin/bash

kickstart.package.install_git() {
    kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:git-core/ppa
    kickstart.package.update
    kickstart.package.install git
}
kickstart.git.cloneandpull() {
    [[ ! -d $2 ]] && {
        kickstart.info "Cloning $1"
        kickstart.mute git clone "$1" "$2"
        if kickstart.os.is "Mac"; then
            kickstart.mute chown "$MYUSER" -R "$2"
        else
            kickstart.mute chown "$MYUSER:$MYUSER" -R "$2"
        fi
    }

    kickstart.mute cd "$2" || exit 1
    kickstart.info "Fetching $1"
    kickstart.mute git fetch --tags --all
    kickstart.mute git reset --hard origin/master
    kickstart.mute cd - || exit 1
}
