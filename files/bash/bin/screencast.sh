#!/bin/bash

now=$(date +"%Y%m%d-%H%M%S")

# TODO: get screen size dynamically
# FIXME: Screen record not working
ffmpeg -f x11grab -s 1366x768 -r 25 -i :0.0 -acodec pcm_s16le -sameq -f alsa -ac 2 -i pulse "$HOME/screencast_$now.mkv"
