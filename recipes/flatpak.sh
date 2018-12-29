#!/bin/bash

kickstart.package.install_flatpak() {
    kickstart.os.is "Ubuntu" && {
        kickstart.apt.ppa ppa:alexlarsson/flatpak
    }

    kickstart.package.update
    kickstart.package.install flatpak
    kickstart.package.install gnome-software-plugin-flatpak

    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}
