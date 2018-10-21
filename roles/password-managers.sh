#!/bin/bash

kickstart.context 'Password Managers'

! kickstart.os.is "Arch" && kickstart.package.install password-gorilla

:
