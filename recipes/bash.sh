#!/bin/bash

kickstart.file.append_once() {
    if ! kickstart.file.contains "$1" "$2"; then
        echo "$2" >> "$1"
    fi
}
