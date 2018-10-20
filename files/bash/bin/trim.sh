#!/bin/bash

find . -regex '.*\.py\|.*\.php\|.*\.js\|.*\.c\|.*\.cpp\|\|.*\.sh.*\.html' -print0 |\
    xargs -0 sed -i 's/[[:space:]]\+$//'
