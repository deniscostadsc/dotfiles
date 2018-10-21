#!/bin/bash

# shellcheck source=recipes/gnupg2.sh
source recipes/gnupg2.sh

kickstart.package.update

kickstart.package.install curl
kickstart.package.install wget
kickstart.package.install gnupg2

__get_vagrant_latest_version() {
    curl -s https://releases.hashicorp.com/vagrant/ |\
        sed 's/<[^>]*>\|[[:space:]]//g' |\
        grep vagrant |\
        head -1
}

kickstart.package.install_vagrant() {
    if ! kickstart.command_exists vagrant; then
        if kickstart.os.is "Ubuntu"; then
            package=$(__get_vagrant_latest_version)
            version=$(sed 's/[a-z_]*//g' <<< "$package")

            wget -q "https://releases.hashicorp.com/vagrant/$version/${package}_x86_64.deb"
            wget -q "https://releases.hashicorp.com/vagrant/$version/${package}_SHA256SUMS"
            wget -q "https://releases.hashicorp.com/vagrant/$version/${package}_SHA256SUMS.sig"

            kickstart.gpg_verify "${package}_SHA256SUMS.sig" "${package}_SHA256SUMS"
            sha256sum -c <(grep "64.deb" "${package}_SHA256SUMS")

            dpkg -i "./${package}_x86_64.deb"

            rm -rf vagrant*
        fi
    fi
}
