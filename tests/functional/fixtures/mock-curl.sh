#!/usr/bin/env bash

url="${2}"

if [[ "${url}" == "https://xkcd.com/info.0.json" ]]; then
    echo '{"num": 3120, "title": "Comic #3120", "alt": "Alt text for comic 3120", "img": "https://imgs.xkcd.com/comics/latest.png", "link": ""}'
elif [[ "${url}" =~ https://xkcd\.com/([0-9]+)/info\.0\.json ]]; then
    comic_num="${BASH_REMATCH[1]}"
    echo "{\"num\": ${comic_num}, \"title\": \"Comic #${comic_num}\", \"alt\": \"Alt text for comic ${comic_num}\", \"img\": \"https://imgs.xkcd.com/comics/comic${comic_num}.png\", \"link\": \"\"}"
else
    echo "${url}"
fi
