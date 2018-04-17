#!/bin/bash

kickstart.context 'C'

kickstart.os.is "Ubuntu" && kickstart.apt.ppa ppa:ubuntu-toolchain-r/test

kickstart.package.update

kickstart.package.install g++
kickstart.package.install gcc

kickstart.package.install autotools-dev
kickstart.package.install clang-format
kickstart.package.install doxygen
kickstart.package.install gdb
kickstart.package.install make
kickstart.package.install pkg-config
kickstart.package.install valgrind
