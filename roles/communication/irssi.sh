#!/bin/bash

kickstart.context 'Communication/Irssi'

kickstart.package.install irssi

kickstart.info "Add notification plugin"
mkdir -p $HOME/.irssi/scripts/autorun/ || true
cp --preserve=mode,ownership files/communication/irssi/irssi-notifier.sh $HOME/.bin/
cp --preserve=mode,ownership files/communication/irssi/notify-listener.py $HOME/.bin/notify-listener
cp --preserve=mode,ownership files/communication/irssi/notify.pl $HOME/.irssi/scripts/
kickstart.file.link $HOME/.irssi/scripts/notify.pl $HOME/.irssi/scripts/autorun/notify.pl

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

[[ ! -z $BOUCER_IRC_ADRESS ]] && \
[[ ! -z $BOUCER_IRC_PORT ]] && \
[[ ! -z $BOUCER_IRC_PASSWORD ]] && {
    kickstart.info "Copy Irssi config files and replace sensitive data"
    cp --preserve=mode,ownership files/communication/irssi/config $HOME/.irssi/config
    sed -i "s/\$BOUCER_IRC_ADRESS/$BOUCER_IRC_ADRESS/" $HOME/.irssi/config
    sed -i "s/\$BOUCER_IRC_PORT/$BOUCER_IRC_PORT/" $HOME/.irssi/config
    sed -i "s/\$BOUCER_IRC_PASSWORD/$BOUCER_IRC_PASSWORD/" $HOME/.irssi/config
} || true
