#!/bin/bash

kickstart.context 'Communication/Irssi'

kickstart.package.install irssi

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

kickstart.info "Copy Irssi config files and replace sensitive data"
cp --preserve=mode,ownership files/communication/irssi/config ~/.irssi/config
sed -i "s/\$BOUCER_IRC_ADRESS/$BOUCER_IRC_ADRESS/" ~/.irssi/config
sed -i "s/\$BOUCER_IRC_PORT/$BOUCER_IRC_PORT/" ~/.irssi/config
sed -i "s/\$BOUCER_IRC_PASSWORD/$BOUCER_IRC_PASSWORD/" ~/.irssi/config
