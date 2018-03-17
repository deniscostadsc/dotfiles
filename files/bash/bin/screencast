#!/bin/bash

now=$(date +"%Y%m%d-%H%M%S")
ffmpeg -f x11grab -s 1366x768 -r 25 -i :0.0 -acodec pcm_s16le -sameq -f alsa -ac 2 -i pulse ~/screencast_$now.mkv
