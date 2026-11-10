#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: show-pr-comment <thread-id>" >&2
    exit 1
fi

thread_id=$1

gh api graphql -f query="
{
  node(id: \"${thread_id}\") {
    ... on PullRequestReviewThread {
      isResolved
      isOutdated
      comments(first: 100) {
        nodes {
          author { login }
          body
          path
          line
          url
        }
      }
    }
  }
}" | jq -r '
  .data.node
  | "resolved: \(.isResolved)  outdated: \(.isOutdated)\n",
  (.comments.nodes[]
  | "[\(.author.login)]\n\(.body)\n\(.url)\n")
'
