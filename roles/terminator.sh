#!/bin/bash

kickstart.context 'Terminator'

kickstart.package.update

kickstart.package.install terminator

cp --preserve=mode,ownership files/terminator/config $MYHOME/.config/terminator/config
