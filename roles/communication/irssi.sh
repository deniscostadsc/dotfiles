#!/bin/bash

kickstart.context 'Communication/Irssi'

# shellcheck source=recipes/os.sh
source recipes/os.sh

kickstart.package.install irssi

kickstart.info "Add notification plugin"
kickstart.file.mkdir_and_chown "$MYHOME/.irssi/scripts/autorun/"
kickstart.file.copy files/communication/irssi/irssi-notifier.sh "$MYHOME/.bin/"
kickstart.file.copy files/communication/irssi/notify-listener.py "$MYHOME/.bin/notify-listener"
kickstart.file.copy files/communication/irssi/notify.pl "$MYHOME/.irssi/scripts/"
kickstart.file.link "$MYHOME/.irssi/scripts/notify.pl" "$MYHOME/.irssi/scripts/autorun/notify.pl"

kickstart.info "Ask for sensitive data about bouncer"
echo -n "Type your IRC bouncer adress: "
read -r -s BOUCER_IRC_ADRESS
echo

echo -n "Type your IRC bouncer port: "
read -r -s BOUCER_IRC_PORT
echo

echo -n "Type your IRC bouncer password: "
read -r -s BOUCER_IRC_PASSWORD
echo

HAS_ALL_VARIABLES=0
[[ -z "$BOUCER_IRC_ADRESS" ]] && HAS_ALL_VARIABLES=1
[[ -z "$BOUCER_IRC_PORT" ]] && HAS_ALL_VARIABLES=1
[[ -z "$BOUCER_IRC_PASSWORD" ]] && HAS_ALL_VARIABLES=1

if [ $HAS_ALL_VARIABLES -eq 0 ]; then
    kickstart.info "Copy Irssi config files and replace sensitive data"
    kickstart.file.copy files/communication/irssi/config "$MYHOME/.irssi/config"
    sed -i "s/\$BOUCER_IRC_ADRESS/$BOUCER_IRC_ADRESS/" "$MYHOME/.irssi/config"
    sed -i "s/\$BOUCER_IRC_PORT/$BOUCER_IRC_PORT/" "$MYHOME/.irssi/config"
    sed -i "s/\$BOUCER_IRC_PASSWORD/$BOUCER_IRC_PASSWORD/" "$MYHOME/.irssi/config"
fi
