#!/bin/bash

kickstart.context 'Browsers'

kickstart.package.update

kickstart.package.install chromium-browser
kickstart.package.install firefox
