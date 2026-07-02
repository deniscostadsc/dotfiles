#!/usr/bin/env bash

set -euo pipefail

gh pr edit --body-file "$(current-ticket-pr-decription-file)"
