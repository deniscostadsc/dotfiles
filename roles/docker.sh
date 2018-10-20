#!/bin/bash

kickstart.context 'Docker'

kickstart.os.is "Ubuntu" && {
    kickstart.package.update

    kickstart.package.install apt-transport-https
    kickstart.package.install ca-certificates
    kickstart.package.install curl
    kickstart.package.install software-properties-common

    kickstart.apt.add_key_from_url "https://download.docker.com/linux/ubuntu/gpg"
    kickstart.apt.ppa "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    kickstart.package.update
    kickstart.package.install docker-ce

    [ -f /usr/local/bin/docker-compose ] || {
        sudo curl -L \
            "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" \
            -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
    }
}
