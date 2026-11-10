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
    thread {
      comments(last: 1) {
        nodes {
          id
          url
        }
      }
    }
  }
}' -f threadId="${thread_id}" -f body="${body}" | jq -r '.data.addPullRequestReviewThreadReply.thread.comments.nodes[-1].url'
