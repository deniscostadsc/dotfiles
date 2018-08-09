#!/bin/bash

kickstart.context 'Browsers'

kickstart.package.update

! kickstart.os.is "Arch" && kickstart.package.install chromium-browser
kickstart.package.install firefox
