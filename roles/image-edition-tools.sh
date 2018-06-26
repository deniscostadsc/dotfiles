#!/bin/bash

kickstart.context 'Image edition tools'

kickstart.package.update

kickstart.package.install gpick
kickstart.package.install gimp
kickstart.package.install inkscape
