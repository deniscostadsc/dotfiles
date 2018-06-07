#!/bin/bash

find . -regex '.*\.py\|.*\.php\|.*\.js\|.*\.c\|.*\.cpp\|\|.*\.sh.*\.html' |\
    xargs sed -i 's/[[:space:]]\+$//'
