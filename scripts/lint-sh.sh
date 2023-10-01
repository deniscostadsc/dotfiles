#!/usr/bin/env bash

set -euo pipefail

SH_SCRIPTS="$(find . -name '*.sh' -o -name '.bashrc' -o -name '.bash_profile')"
EXIT_STATUS=0

shopt -s globstar nullglob

for file in **/*.yaml; do
    echo "The file ${file} should have .yml as extension"
    EXIT_STATUS=1
done

for file in **/*.yml; do
    if ! grep '^\-\-\-$' "${file}" &> /dev/null; then
        echo "The file ${file} does not has a '---' at the beggining."
        EXIT_STATUS=1
    fi
done

for script in ${SH_SCRIPTS}; do
    shellcheck "${script}" && continue
    EXIT_STATUS=1
done

exit "${EXIT_STATUS}"
