#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 2 ]]; then
    echo "Usage: reply-pr-comment <thread-id> <body>" >&2
    exit 1
fi

thread_id=$1
body=$2

gh api graphql -f query='
mutation($threadId: ID!, $body: String!) {
  addPullRequestReviewThreadReply(input: {pullRequestReviewThreadId: $threadId, body: $body}) {
    comment {
      id
      url
    }
  }
}' -f threadId="${thread_id}" -f body="${body}" | jq -r '.data.addPullRequestReviewThreadReply.comment.url'
