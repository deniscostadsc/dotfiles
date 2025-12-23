#!/usr/bin/env bash

set -euo pipefail

SH_SCRIPTS="$(find . -name '*.sh' -o -name '.bashrc' -o -name '.bash_profile' -o -name '*.sh.j2')"
EXIT_STATUS=0

for script in ${SH_SCRIPTS}; do
    shellcheck "${script}" && continue
    EXIT_STATUS=1
done

if ! shfmt -d .; then
    EXIT_STATUS=1
fi

exit "${EXIT_STATUS}"
