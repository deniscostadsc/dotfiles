#!/bin/bash

kickstart.context 'Communication/Irssi'

kickstart.package.install irssi

echo -n "Type your IRC bouncer adress: "
read -r -s BOUCER_IRC_ADRESS
echo -n "Type your IRC bouncer port: "
read -r -s BOUCER_IRC_PORT
echo -n "Type your IRC bouncer password: "
read -r -s BOUCER_IRC_PASSWORD

cp --preserve=mode,ownership files/communication/irc/config ~/.irssi/config
sed -i "s/\$BOUCER_IRC_ADRESS/$BOUCER_IRC_ADRESS/" ~/.irssi/config
sed -i "s/\$BOUCER_IRC_PORT/$BOUCER_IRC_PORT/" ~/.irssi/config
sed -i "s/\$BOUCER_IRC_PASSWORD/$BOUCER_IRC_PASSWORD/" ~/.irssi/config
