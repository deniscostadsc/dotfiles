#!/usr/bin/env bash

set -euo pipefail

git current-branch | grep -o '[A-Z]\+-[0-9]\+'
