#!/bin/bash

kickstart.context 'Communication/CoyIM'

kickstart.os.is "Ubuntu" && (
    kickstart.package.install software-properties-common
    kickstart.mute add-apt-repository universe
)

kickstart.package.update

kickstart.package.install coyim

kickstart.file.mkdir_and_chown $MYHOME/.config/coyim
cp --preserve=mode,ownership files/communication/coyim/accounts.json.enc $MYHOME/.config/coyim
