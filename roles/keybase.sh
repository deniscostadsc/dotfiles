#!/bin/bash

# shellcheck source=recipes/gnupg2.sh
source recipes/gnupg2.sh

kickstart.context 'Keybase'

kickstart.package.install wget
kickstart.package.install gnupg2

! kickstart.command_exists run_keybase && kickstart.os.is "Ubuntu" && {
    kickstart.info "Download Keybase deb file and signature"
    kickstart.mute wget https://prerelease.keybase.io/keybase_amd64.deb
    kickstart.mute wget https://prerelease.keybase.io/keybase_amd64.deb.sig

    kickstart.info "Verify deb file signature"
    kickstart.gpg_verify keybase_amd64.deb.sig keybase_amd64.deb

    kickstart.info "Install keybase"
    kickstart.mute dpkg -i keybase_amd64.deb
    kickstart.mute apt-get install -f

    kickstart.info "Remove keybase files"
    rm keybase_amd64.deb*
}
