#!/bin/bash

kickstart.context 'Slack'

# shellcheck source=recipes/flatpak.sh
source recipes/flatpak.sh

kickstart.info "Install flatpak"
kickstart.package.install_flatpak

kickstart.info "Install slack"
flatpak install -y flathub com.slack.Slack
