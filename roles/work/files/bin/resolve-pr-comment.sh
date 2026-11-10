#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: resolve-pr-comment <thread-id>" >&2
    exit 1
fi

thread_id=$1

gh api graphql -f query='
mutation($threadId: ID!) {
  resolveReviewThread(input: {threadId: $threadId}) {
    thread {
      isResolved
    }
  }
}' -f threadId="${thread_id}" | jq -r '"resolved: \(.data.resolveReviewThread.thread.isResolved)"'
