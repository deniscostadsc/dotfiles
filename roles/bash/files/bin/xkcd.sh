#!/usr/bin/env bash

set -euo pipefail

if command -v viu &>/dev/null; then
    render_cmd=(viu -w 0 -h 0 -)
elif command -v chafa &>/dev/null; then
    render_cmd="chafa"
else
    echo "Install 'viu' to display images"
    exit 1
fi

latest=$(curl -s https://xkcd.com/info.0.json | jq -r '.num')
rand_num=$((1 + RANDOM % latest))

comic_json=$(curl -s "https://xkcd.com/$rand_num/info.0.json")
title=$(echo "$comic_json" | jq -r '.title')
alt_text=$(echo "$comic_json" | jq -r '.alt')
img_url=$(echo "$comic_json" | jq -r '.img')

echo
echo "XKCD #$rand_num: $title"
echo
curl -s "$img_url" | $render_cmd -
echo
echo "Alt Text: $alt_text"
echo "Comic URL: https://xkcd.com/$rand_num/"
echo
