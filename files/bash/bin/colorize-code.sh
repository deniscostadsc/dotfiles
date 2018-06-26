#!/bin/bash

pbpaste | pygmentize -l "${1:-python}" -f rtf -O style=friendly | pbcopy
