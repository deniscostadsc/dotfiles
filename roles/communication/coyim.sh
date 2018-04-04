#!/bin/bash

kickstart.context 'Communication/CoyIM'

kickstart.mute add-apt-repository universe

kickstart.package.update

kickstart.package.install coyim

cp --preserve=mode,ownership files/communication/coyim/accounts.json.enc ~/.config/coyim
